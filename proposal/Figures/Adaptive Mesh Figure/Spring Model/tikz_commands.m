%% Script to print the tikz commands for the mesh
clc; clear all; close all

%% Initialize 

load mesh_data % p t nt np npc rp rpc 
figure_scale = 2.2;

%% Calculations 

% find the choosen node
cnc = [.5 0]; % choose the node closest to this point
[trash,index]=min(abs(rp(:,1)-cnc(1))+abs(rp(:,2)-cnc(2))); % find index
cn = rp(index,:); % what is the actual node

% distance between choosen node and point cloud points and resulting force
dpc = pc - repmat(cn,npc^2,1); % vectors to each point cloud point
fpc = sum(dpc); % summation of all vectors
fpc = fpc / (1.3*norm(fpc)); % turn into a little smaller than unit vector
fpch = roundn(cn + fpc, -4); % where will the actual head land

% choosen node movement
cnm = roundn( cn + (fpc / (3*norm(fpc))), -4);

% adjusted mesh (only moving one node)
amn = rp;
amn(index,:) = cnm;

% adjusted mesh (moving all nodes)
ama = rp;
ama(:,3) = ama(:,3) + .1*randn(np,1);

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

% making curve points for blue plane
Bn = 10;
Bx = [-2*ones(Bn,1); 2*ones(Bn,1)];
By = [linspace(-2,2,Bn)'; linspace(2,-2,Bn)'];
Bz = -.2*sin(By)+1.5;
Bpts = [Bx By Bz];
BPc = '\\filldraw[fill opacity = .1,fill=blue!70!white] ';
for i = 1:length(Bx);
    if i==1
        Nc = sprintf('(%g,%g,%g)',Bpts(i,1),Bpts(i,2),Bpts(i,3));
    else
        Nc = sprintf(' -- (%g,%g,%g)',Bpts(i,1),Bpts(i,2),Bpts(i,3));
    end
    BPc = strcat(BPc,Nc);
end
BPc = strcat(BPc,' -- cycle; \n');

% making curve points for blue plane which isn't displaced up
% Bn = 10;
% Bx = [-2*ones(Bn,1); 2*ones(Bn,1)];
% By = [linspace(-2,2,Bn)'; linspace(2,-2,Bn)'];
Bz = -.2*sin(By)+.2;
Bpts = roundn([Bx By Bz],-4);
BPcd = '\\filldraw[fill opacity = .1,fill=blue!70!white] ';
for i = 1:length(Bx);
    if i==1
        Nc = sprintf('(%g,%g,%g)',Bpts(i,1),Bpts(i,2),Bpts(i,3));
    else
        Nc = sprintf(' -- (%g,%g,%g)',Bpts(i,1),Bpts(i,2),Bpts(i,3));
    end
    BPcd = strcat(BPcd,Nc);
end
BPcd = strcat(BPcd,' -- cycle; \n');

%% Start Figure Showing Forces _________________________________________ 1

fid = fopen('adaptive_mesh_1.tikz','w'); % open a file 

% add top lines
fprintf(fid,'\\begin{tikzpicture}[scale=%g,tdplot_main_coords]\n',figure_scale);
fprintf(fid,'\\tikzstyle{spring}=[thick,decorate,decoration={zigzag,pre length=0.3cm,post length=0.3cm,segment length=6}] \n');

%% Mesh Elements

fprintf(fid,'\\begin{scope}[fill opacity = .3,fill=green!50!white, draw=gray, very thin]\n');
for i=1:nt
    v1 = rp(t(i,1),:);
    v2 = rp(t(i,2),:);
    v3 = rp(t(i,3),:);
    fprintf(fid,'\\filldraw (%g,%g,%g) -- (%g,%g,%g) -- (%g,%g,%g) -- cycle; \n',...
        v1(1),v1(2),v1(3),v2(1),v2(2),v2(3),v3(1),v3(2),v3(3));
end
fprintf(fid,'\\end{scope}\n');

%% The Nodes

% for the nodes
for i=1:np
    if i==index
        fprintf(fid,'\\fill[black] (%g,%g,%g) circle (.8pt); \n',rp(i,1),rp(i,2),rp(i,3));
    else     
        fprintf(fid,'\\fill[black] (%g,%g,%g) circle (.4pt); \n',rp(i,1),rp(i,2),rp(i,3));
    end
end

%% Point Cloud Points to Choosen Node

fprintf(fid,'\\begin{scope}[opacity=.9, red!80!white]\n');
for i=1:npc^2
    %fprintf(fid,'\\draw[Red!%g!Apricot] (%g,%g,%g) -- (%g,%g,%g); \n',...
        %opc(i),rpc(i,1),rpc(i,2),rpc(i,3),cn(1),cn(2),cn(3));
    fprintf(fid,'\\draw (%g,%g,%g) -- (%g,%g,%g); \n',...
        rpc(i,1),rpc(i,2),rpc(i,3),cn(1),cn(2),cn(3));
end
fprintf(fid,'\\end{scope}\n');

%% Dashed gray lines that show intersection 

for i=1:npc^2
    fprintf(fid,'\\fill[gray] (%g,%g,%g) circle (.4pt); \n',...
        rpc(i,1),rpc(i,2),-.2*sin(rpc(i,2))+1.5);
end

fprintf(fid,'\\begin{scope}[opacity=.9, draw=gray, very thin, dashed]\n');
for i=1:npc^2
    fprintf(fid,'\\draw (%g,%g,%g) -- (%g,%g,%g); \n',...
        rpc(i,1),rpc(i,2),-.2*sin(rpc(i,2))+1.5,rpc(i,1),rpc(i,2),rpc(i,3));
end
fprintf(fid,'\\end{scope}\n');

%% Actual Point Cloud Points

for i=1:npc^2
    fprintf(fid,'\\fill[ball color = red] (%g,%g,%g) circle (1.2pt); \n',rpc(i,1),rpc(i,2),rpc(i,3));
end

%% Resultant Force

fprintf(fid,'\\draw[->, red, >=triangle 45, thick, line width = 2pt] (%g,%g,%g) -- (%g,%g,%g); \n',cn(1),cn(2),cn(3),fpch(1),fpch(2),fpch(3));

%% Blue Plane

fprintf(fid,BPc); 

%% Springs along the edges

for i = 1:size(conN,1)
    fprintf(fid,'\\draw[spring] (%g,%g,%g) -- (%g,%g,%g); \n',...
        cn(1),cn(2),cn(3),conN(i,1),conN(i,2),conN(i,3));
end

%% Close Figure Showing Forces

fprintf(fid,'\\end{tikzpicture}');
fclose(fid);

%% Start Figure Showing Node Movement __________________________________ 2

fid = fopen('adaptive_mesh_2.tikz','w'); % open a file 

% add top lines
fprintf(fid,'\\begin{tikzpicture}[scale=%g,tdplot_main_coords]\n',figure_scale);
fprintf(fid,'\\tikzstyle{spring}=[thick,decorate,decoration={zigzag,pre length=0.3cm,post length=0.3cm,segment length=6}] \n');

%% Mesh Elements

fprintf(fid,'\\begin{scope}[fill opacity = .3,fill=green!50!white, draw=gray, very thin]\n');
for i=1:nt
    v1 = amn(t(i,1),:);
    v2 = amn(t(i,2),:);
    v3 = amn(t(i,3),:);
    fprintf(fid,'\\filldraw (%g,%g,%g) -- (%g,%g,%g) -- (%g,%g,%g) -- cycle; \n',...
        v1(1),v1(2),v1(3),v2(1),v2(2),v2(3),v3(1),v3(2),v3(3));
end
fprintf(fid,'\\end{scope}\n');

%% The Nodes

% for the nodes
for i=1:np
    if i==index
        fprintf(fid,'\\fill[black] (%g,%g,%g) circle (.8pt); \n',amn(i,1),amn(i,2),amn(i,3));
    else     
        fprintf(fid,'\\fill[black] (%g,%g,%g) circle (.4pt); \n',amn(i,1),amn(i,2),amn(i,3));
    end
end

%% Blue Plane

fprintf(fid,BPc); 

%% Close Figure Showing Forces

fprintf(fid,'\\end{tikzpicture}');
fclose(fid);

%% Start Figure Showing All Movement ___________________________________ 3

fid = fopen('adaptive_mesh_3.tikz','w'); % open a file 

% add top lines
fprintf(fid,'\\begin{tikzpicture}[scale=%g,tdplot_main_coords]\n',figure_scale);
fprintf(fid,'\\tikzstyle{spring}=[thick,decorate,decoration={zigzag,pre length=0.3cm,post length=0.3cm,segment length=6}] \n');

%% Mesh Elements

fprintf(fid,'\\begin{scope}[fill opacity = .3,fill=green!50!white, draw=gray, very thin]\n');
for i=1:nt
    v1 = ama(t(i,1),:);
    v2 = ama(t(i,2),:);
    v3 = ama(t(i,3),:);
    fprintf(fid,'\\filldraw (%g,%g,%g) -- (%g,%g,%g) -- (%g,%g,%g) -- cycle; \n',...
        v1(1),v1(2),v1(3),v2(1),v2(2),v2(3),v3(1),v3(2),v3(3));
end
fprintf(fid,'\\end{scope}\n');

%% The Nodes

% for the nodes
for i=1:np
    if i==index
        fprintf(fid,'\\fill[black] (%g,%g,%g) circle (.8pt); \n',ama(i,1),ama(i,2),ama(i,3));
    else     
        fprintf(fid,'\\fill[black] (%g,%g,%g) circle (.4pt); \n',ama(i,1),ama(i,2),ama(i,3));
    end
end

%% Blue Plane

fprintf(fid,BPcd); 

%% Close Figure Showing Forces

fprintf(fid,'\\end{tikzpicture}');
fclose(fid);




% % Show Me
% 
% % Plot the nodes
% plot3(p(:,1),p(:,2),p(:,3),'.'); grid on; axis equal; hold on;
% 
% % Plot the edges
% for i = 1:nt
%     v1 = p(t(i,1),:);
%     v2 = p(t(i,2),:);
%     v3 = p(t(i,3),:);
%     line([v1(1) v2(1)],[v1(2) v2(2)],[v1(3) v2(3)])
%     line([v2(1) v3(1)],[v2(2) v3(2)],[v2(3) v3(3)])
%     line([v3(1) v1(1)],[v3(2) v1(2)],[v3(3) v1(3)])
% end
% 
% xlabel('x'); ylabel('y'); zlabel('z')