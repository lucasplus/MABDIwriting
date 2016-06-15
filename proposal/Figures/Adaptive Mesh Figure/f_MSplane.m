% function to make tikz string to draw plane
%
% inputs:
%  x,y,z - columns of x,y,z points
%  color - string specifying color
% ouput:
%  S - string of tikz instructions
%
function S = f_MSplane(x,y,z,color)

pts = [x y z];
S = sprintf('\\\\filldraw[fill opacity = .1,fill=%s] ',color);
for i = 1:length(x);
    if i==1
        Nc = sprintf('(%g,%g,%g)',pts(i,1),pts(i,2),pts(i,3));
    else
        Nc = sprintf(' -- (%g,%g,%g)',pts(i,1),pts(i,2),pts(i,3));
    end
    S = strcat(S,Nc);
end
S = strcat(S,' -- cycle; \n');