import vtk
from vtk.util.vtkAlgorithm import VTKPythonAlgorithmBase
from vtk.util import numpy_support
from vtk.numpy_interface import dataset_adapter as dsa

from Utilities import DebugTimeVTKFilter

import numpy as np
from scipy import ndimage

from timeit import default_timer as timer
import logging


class FilterDepthImageToSurface(VTKPythonAlgorithmBase):
    """
    vtkAlgorithm with input of vtkImageData and output of vtkPolyData
    This filter first defines a connectivity on the depth image that is like a
    checkerboard but with two triangles in each square. It then throws away all points
    farther than the param_farplane_threshold and all points with a large difference
    between neighbors (controlled with param_convolution_theshold)
    Input: Depth image
    Output: Mesh created by projecting depth image
    """

    def __init__(self,
                 param_farplane_threshold=1.0,
                 param_convolution_threshold=0.01):
        """
        Algorithm setup and define parameters.
        :param param_farplane_threshold: default=1.0
          Values on the depth image range from 0.0-1.0. Points with depth values greater
          than param_farplane_threshold will be thrown away.
        :param param_convolution_threshold: default=0.01
          Convolution is used to determine pixel neighbors with a large difference. If
          there is one, the point will be thrown away. This threshold controls sensitivity.
        """

        VTKPythonAlgorithmBase.__init__(self,
                                        nInputPorts=1, inputType='vtkImageData',
                                        nOutputPorts=1, outputType='vtkPolyData')

        self._param_farplane_threshold = param_farplane_threshold
        self.param_convolution_theshold = param_convolution_threshold

        self._sizex = []
        self._sizey = []
        self._viewport = []

        self._display_pts = []
        self._viewport_pts = []
        self._world_pts = []

        self._points = vtk.vtkPoints()
        self._polys = vtk.vtkCellArray()
        self._polydata = vtk.vtkPolyData()
        self._polydata.SetPoints(self._points)
        self._polydata.SetPolys(self._polys)

        self._extract = vtk.vtkExtractPolyDataGeometry()
        DebugTimeVTKFilter(self._extract)
        self._extract.SetInputData(self._polydata)
        planefunc = vtk.vtkPlane()
        planefunc.SetNormal(0.0, -1.0, 0.0)
        planefunc.SetOrigin(0.0, -1.0, 0.0)
        self._extract.SetImplicitFunction(planefunc)

    def RequestData(self, request, inInfo, outInfo):

        logging.info('')
        start = timer()

        # input (vtkImageData)
        inp = vtk.vtkImageData.GetData(inInfo[0])

        # if the vtkImageData size has changed or this is the first time
        # save new size info and initialize containers
        if (self._sizex, self._sizey, self._viewport) != (inp.sizex, inp.sizey, inp.viewport):
            (self._sizex, self._sizey) = (inp.sizex, inp.sizey)
            self._viewport = inp.viewport
            self._init_containers()

        # the incoming depth image
        di = numpy_support.vtk_to_numpy(inp.GetPointData().GetScalars())\
            .reshape((self._sizey, self._sizex))

        # add z values to viewport_pts based on incoming depth image
        self._viewport_pts[2, :] = di.reshape(-1)

        # project to world coordinates
        self._world_pts = np.dot(inp.tmat, self._viewport_pts)
        self._world_pts = self._world_pts / self._world_pts[3]

        """ Remove invalid points """

        # index to pts outside sensor range (defined by vtkCamera clipping range)
        outside_range = ~(di < self._param_farplane_threshold)

        # find pixel neighbors with large differences in value
        # http://docs.scipy.org/doc/scipy/reference/tutorial/ndimage.html
        kh = np.array([[1, -1], [0, 0]])
        edges_h = abs(ndimage.convolve(di,
                                       kh,
                                       mode='nearest',
                                       origin=-1)) > self.param_convolution_theshold
        kv = np.array([[1, 0], [-1, 0]])
        edges_v = abs(ndimage.convolve(di,
                                       kv,
                                       mode='nearest',
                                       origin=-1)) > self.param_convolution_theshold

        # combine all the points found to be invalid
        # and set them to a value underneath the "floor of the environment"
        # http://stackoverflow.com/a/20528566/4068274
        invalid_index = np.logical_or.reduce((outside_range.reshape(-1),
                                              edges_h.reshape(-1),
                                              edges_v.reshape(-1)))
        self._world_pts[0:3, invalid_index] = np.array([[0.0], [-2.0], [0.0]])

        """ Update and set filter output """

        # update vtkPoints
        vtkarray = dsa.numpyTovtkDataArray(self._world_pts[0:3, :].T)
        self._points.SetData(vtkarray)

        # update output (vtkPolyData)
        out = vtk.vtkPolyData.GetData(outInfo)
        self._extract.Update()
        logging.info('Number of triangles: {}'.format(self._extract.GetOutput().GetNumberOfCells()))
        out.ShallowCopy(self._extract.GetOutput())

        end = timer()
        logging.info('Execution time {:.4f} seconds'.format(end - start))

        return 1

    def _init_containers(self):
        logging.info('Initializing arrays for projection calculation.')
        tstart = timer()

        # helper variables (width, height)
        (w, h) = (self._sizex, self._sizey)

        """ display points (list of all pixel coordinates) """

        self._display_pts = np.ones((2, w * h))
        self._display_pts[0, :], self._display_pts[1, :] = \
            zip(*[(j, i) for i in np.arange(h) for j in np.arange(w)])

        """ viewport points """
        # https://github.com/Kitware/VTK/blob/52d45496877b00852a08a5b9819d109c2fd9bfab/Rendering/Core/vtkCoordinate.h#L26

        self._viewport_pts = np.ones((4, self._display_pts.shape[1]))
        self._viewport_pts[0, :] = 2.0 * (self._display_pts[0, :] - w * self._viewport[0]) / \
            (w * (self._viewport[2] - self._viewport[0])) - 1.0
        self._viewport_pts[1, :] = 2.0 * (self._display_pts[1, :] - h * self._viewport[1]) / \
            (h * (self._viewport[3] - self._viewport[1])) - 1.0

        """ new world points (just initializing the container) """

        self._world_pts = np.ones(self._viewport_pts.shape)

        """ cells (list of triangles created by connecting neighbors in depth image space ) """

        # connectivity on the depth image is almost like a checkerboard pattern
        # except with two triangles in every checkerboard square
        nt = (2*w)*(h-1)  # number of triangles
        cells = np.zeros((3, nt), dtype=np.int)
        i = 0
        while i < (nt/2):
            if ((i+1) % w) != 0:  # if on the side of the image skip
                cells[:, 2*i] = (i, i+1, w+i)
                cells[:, 2*i+1] = (i+1, w+i+1, w+i)
            i += 1

        # remove columns with zeros (the ones we skipped in the while loop)
        index = np.where(cells.any(axis=0))[0]  # all columns that are non zero
        cells = cells[:, index]

        # turn our connectivity list into a vtk object (vtkCellArray)
        for tpt in cells.T:
            self._polys.InsertNextCell(3)
            self._polys.InsertCellPoint(tpt[0])
            self._polys.InsertCellPoint(tpt[1])
            self._polys.InsertCellPoint(tpt[2])
        self._polydata.SetPolys(self._polys)

        # time me
        tend = timer()
        logging.info('Initializing arrays for projection calculation {:.4f} seconds'.format(tend - tstart))

