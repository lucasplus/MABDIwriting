% second try at determining the mesh for my figure
clc; clear all; close all

% Generate the mesh for a rectangular area
fd=@(p) drectangle(p,-2,2,-2,2);
[p,t]=distmesh2d(fd,@huniform,.7,[-2,-2;2,2],[-2,-2;2,-2;-2,2;2,2]);

% Number of nodes and elements
nt = size(t,1); np = size(p,1);

% Add a z component to the nodes
p = [p -.2*sin(p(:,2))];
% p = [p zeros(np,1)];

% Plot the nodes
plot3(p(:,1),p(:,2),p(:,3),'.'); grid on; axis equal; hold on;
xlabel('x'); ylabel('y'); zlabel('z')

% Plot the edges
for i = 1:nt
    v1 = p(t(i,1),:);
    v2 = p(t(i,2),:);
    v3 = p(t(i,3),:);
    line([v1(1) v2(1)],[v1(2) v2(2)],[v1(3) v2(3)])
    line([v2(1) v3(1)],[v2(2) v3(2)],[v2(3) v3(3)])
    line([v3(1) v1(1)],[v3(2) v1(2)],[v3(3) v1(3)])
end

%.5*(3/npc)*rand(npc,1)

% Create the "point cloud"
npc = 3; pc = [];
pcs = linspace(-1.5,1.5,npc)';
for i=1:npc;
    pc = [pc; pcs repmat(pcs(i),npc,1)];
end

pc = pc + .01*(3/npc)*randn(npc^2,2);

pc = [pc -.2*sin(pc(:,2))+.4*randn(npc^2,1)+1.5];
%pc = [pc .4*randn(npc^2,1)+1];

plot3(pc(:,1),pc(:,2),pc(:,3),'r.')

% matlab2tikz( 'mesh.tikz', 'height', '\figureheight', 'width', '\figurewidth' );

% Round to nearst 4th decimal place
rp = roundn(p,-4);
rpc = roundn(pc,-4);

save mesh_data p pc t nt np npc rp rpc 

tikz_commands


