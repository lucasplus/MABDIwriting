% function to find the neighbors of a given vertice
%
% input:
%  index - index in rp of central point
%  t - 3xN connectivity of triangles
%  rp - 3xN list of vertices
%
% output:
%  conN - 3xM list of neighbors
%
function conN = f_FindN(index,t,rp)

% find the edges connected to the choosen node
[nI,nJ] = find(t==index); conN = [];
for i=1:length(nI)
    for j = 1:3
        if j~=nJ(i)
            conN = [conN; rp(t(nI(i),j),:)];
        end
    end
end
conN = unique(conN,'rows');  