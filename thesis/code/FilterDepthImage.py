import vtk
from vtk.util.vtkAlgorithm import VTKPythonAlgorithmBase
from vtk.util import numpy_support
from vtk.numpy_interface import dataset_adapter as dsa

import numpy as np

from timeit import default_timer as timer
import logging


class FilterDepthImage(VTKPythonAlgorithmBase):
    """
    Create a depth image of a scene

    This class uses the geometric information of the scene (vtkPolyData) and the
    orientation of the depth sensor.
    """

    def __init__(self,
                 name='none',
                 offscreen=False,
                 noise=0.0,
                 depth_image_size=(640, 480)):
        """
        :param name: default='none'
          Used for the logging statements.
        :param offscreen:
          Create the render window that is used to produce the depth image offscreen.
        :param noise:
          Noise to add to depth image.
        :param depth_image_size:
          Size of the depth image.
        """

        VTKPythonAlgorithmBase.__init__(self,
                                        nInputPorts=0,
                                        nOutputPorts=1, outputType='vtkImageData')
        self._name = name

        if type(noise) == bool:
            if noise:
                noise = 0.002
            else:
                noise = 0.0
        self._noise = noise

        # vtk render objects
        self._ren = vtk.vtkRenderer()
        self._renWin = vtk.vtkRenderWindow()
        self._iren = vtk.vtkRenderWindowInteractor()

        # wire them up
        self._renWin.AddRenderer(self._ren)
        self._iren.SetRenderWindow(self._renWin)

        # offscreen rendering
        if offscreen:
            self._renWin.SetOffScreenRendering(1)

        # kinect intrinsic parameters
        # https://msdn.microsoft.com/en-us/library/hh438998.aspx
        self._renWin.SetSize(depth_image_size)
        self._ren.GetActiveCamera().SetViewAngle(60.0)
        self._ren.GetActiveCamera().SetClippingRange(0.8, 4.0)
        self._iren.GetInteractorStyle().SetAutoAdjustCameraClippingRange(0)

        # have it looking down and underneath the "floor"
        # so that it will produce a blank vtkImageData until
        # set_sensor_orientation() is called
        self._ren.GetActiveCamera().SetPosition(0.0, -20.0, 0.0)
        self._ren.GetActiveCamera().SetFocalPoint(0.0, -25.0, 0.0)

        # calculate image bounds
        self._imageBounds = [0, 0, 0, 0]
        viewport = self._ren.GetViewport()
        size = self._renWin.GetSize()
        self._imageBounds[0] = int(viewport[0] * size[0])
        self._imageBounds[1] = int(viewport[1] * size[1])
        self._imageBounds[2] = int(viewport[2] * size[0] + 0.5) - 1
        self._imageBounds[3] = int(viewport[3] * size[1] + 0.5) - 1

    def set_polydata(self, in_polydata):
        """
        What this filter will render and consequently produce a depth image of.
        :param in_polydata: vtkAlgorithm that produces a vtkPolyData
        """
        logging.info('')

        mapper = vtk.vtkPolyDataMapper()
        mapper.SetInputConnection(in_polydata.GetOutputPort())

        actor = vtk.vtkActor()
        actor.SetMapper(mapper)

        self._ren.AddActor(actor)

        self._iren.Initialize()
        self._iren.Render()

    def set_polydata_empty(self):
        """
        Use to initialize this filter with an empty vtkPolyData
        """
        logging.info('')

        polydata = vtk.vtkPolyData()

        mapper = vtk.vtkPolyDataMapper()
        mapper.SetInputDataObject(polydata)

        actor = vtk.vtkActor()
        actor.SetMapper(mapper)

        self._ren.AddActor(actor)

        self._iren.Initialize()
        self._iren.Render()

    def set_sensor_orientation(self, in_position, in_lookat):
        """
        :param in_position: Position of sensor in world coordinates.
        :param in_lookat: Where the sensor is looking in world coordinates.
        """
        logging.info('position{} lookat{}'.format(in_position, in_lookat))

        self._ren.GetActiveCamera().SetPosition(in_position)
        self._ren.GetActiveCamera().SetFocalPoint(in_lookat)
        self._iren.Render()

    def get_vtk_camera(self):
        return self._ren.GetActiveCamera()

    def get_width_by_height_ratio(self):
        return float(self._renWin.GetSize()[0]) / float(self._renWin.GetSize()[1])

    def kill_render_window(self):
        """
        Kill render window that this instance owns. Only to be used when the user
        is sure the filter will not be run again.
        """
        # http://stackoverflow.com/questions/15639762/close-vtk-window-python
        self._renWin.Finalize()
        self._iren.TerminateApp()
        del self._renWin, self._iren

    def RequestInformation(self, request, inInfo, outInfo):
        logging.info('')
        size = self._renWin.GetSize()
        extent = (0, size[0] - 1, 0, size[1] - 1, 0, 0)
        info = outInfo.GetInformationObject(0)
        info.Set(vtk.vtkStreamingDemandDrivenPipeline.WHOLE_EXTENT(),
                 extent, len(extent))
        return 1

    def RequestData(self, request, inInfo, outInfo):
        logging.info('{}'.format(self._name))
        start = timer()

        # get the depth values
        vfa = vtk.vtkFloatArray()
        ib = self._imageBounds
        self._renWin.GetZbufferData(ib[0], ib[1], ib[2], ib[3], vfa)

        # add noise
        if self._noise is not 0.0:
            nvfa = numpy_support.vtk_to_numpy(vfa)
            nvfa += self._noise * nvfa * np.random.normal(0.0, 1.0, nvfa.shape)
            vfa = dsa.numpyTovtkDataArray(nvfa)

        # pack the depth values into the output vtkImageData
        info = outInfo.GetInformationObject(0)
        ue = info.Get(vtk.vtkStreamingDemandDrivenPipeline.UPDATE_EXTENT())
        out = vtk.vtkImageData.GetData(outInfo)
        out.GetPointData().SetScalars(vfa)
        out.SetExtent(ue)

        # append meta data to the vtkImageData containing intrinsic parameters
        out.sizex = self._renWin.GetSize()[0]
        out.sizey = self._renWin.GetSize()[1]
        out.viewport = self._ren.GetViewport()
        vtktmat = self._ren.GetActiveCamera().GetCompositeProjectionTransformMatrix(
            self._ren.GetTiledAspectRatio(),
            0.0, 1.0)
        vtktmat.Invert()
        out.tmat = self._vtkmatrix_to_numpy(vtktmat)

        end = timer()
        logging.info('Execution time {:.4f} seconds'.format(end - start))

        return 1

    def _vtkmatrix_to_numpy(self, matrix):
        """
        Copies the elements of a vtkMatrix4x4 into a numpy array.

        :param matrix: The matrix to be copied into an array.
        :type matrix: vtk.vtkMatrix4x4
        :rtype: numpy.ndarray
        """
        m = np.ones((4, 4))
        for i in range(4):
            for j in range(4):
                m[i, j] = matrix.GetElement(i, j)
        return m
