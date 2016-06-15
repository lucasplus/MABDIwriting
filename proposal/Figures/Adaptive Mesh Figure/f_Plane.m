% function to find coefficients of a plane from a set of points
% z = XCoeff * x + YCoeff * y + CCoeff
%
% N - normal of plane
% C - coefficents of plane
%
function [N C] = f_Plane(Pts)

Xcolv = Pts(:,1); % Make X a column vector
Ycolv = Pts(:,2); % Make Y a column vector
Zcolv = Pts(:,3); % Make Z a column vector
Const = ones(size(Xcolv)); % Vector of ones for constant term

Coefficients = [Xcolv Ycolv Const]\Zcolv; % Find the coefficients
XCoeff = Coefficients(1); % X coefficient
YCoeff = Coefficients(2); % X coefficient
CCoeff = Coefficients(3); % constant term
% Using the above variables, z = XCoeff * x + YCoeff * y + CCoeff

C = [XCoeff YCoeff CCoeff];

N = [-XCoeff/CCoeff -YCoeff/CCoeff 1/CCoeff];
