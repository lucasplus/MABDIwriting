x = rand(1,10);
y = rand(1,10);
z = (3-2*x-5*y)/4 + rand(1,10); % Equation of the plane containing 
% (x,y,z) points is 2*x+5*y+4*z=3

Xcolv = x(:); % Make X a column vector
Ycolv = y(:); % Make Y a column vector
Zcolv = z(:); % Make Z a column vector
Const = ones(size(Xcolv)); % Vector of ones for constant term

Coefficients = [Xcolv Ycolv Const]\Zcolv; % Find the coefficients
XCoeff = Coefficients(1); % X coefficient
YCoeff = Coefficients(2); % X coefficient
CCoeff = Coefficients(3); % constant term
% Using the above variables, z = XCoeff * x + YCoeff * y + CCoeff

L=plot3(x,y,z,'ro'); % Plot the original data points
set(L,'Markersize',2*get(L,'Markersize')) % Making the circle markers larger
set(L,'Markerfacecolor','r') % Filling in the markers
hold on
[xx, yy]=meshgrid(0:0.1:1,0:0.1:1); % Generating a regular grid for plotting
zz = XCoeff * xx + YCoeff * yy + CCoeff;
surf(xx,yy,zz) % Plotting the surface
title(sprintf('Plotting plane z=(%f)*x+(%f)*y+(%f)',XCoeff, YCoeff, CCoeff))