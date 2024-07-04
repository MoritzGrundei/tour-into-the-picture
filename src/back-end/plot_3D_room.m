function plot_3D_room(walls)
%% PLOT_3D:ROOM: transform a 2D image into a 3D plot
% 2D images of the 5 room walls

% extract room dimensions from input arguments
roomWidth = size(walls{5}, 2);
roomHeight = size(walls{5}, 1);
leftDepth = size(walls{2}, 2);
rightDepth = size(walls{3}, 2);
floorDepth = size(walls{1}, 1);
ceilingDepth = size(walls{4}, 1);

average_depth = (leftDepth + rightDepth + ceilingDepth + floorDepth) / 4;

% Create figure
f = figure;

% Plot floor
floorX = [0 roomWidth; 0 roomWidth];
floorY = [0 0; 0 0];
floorZ = [0 0; floorDepth floorDepth];
h = surface(floorX, floorY, floorZ, 'FaceColor', 'texturemap', 'CData', walls{1});
set(h, 'EdgeColor', 'none');

% Plot left wall
leftX = [0 0; 0 0];
leftY = [roomHeight roomHeight; 0 0];
leftZ = [leftDepth 0; leftDepth 0];
h = surface(leftX, leftY, leftZ, 'FaceColor', 'texturemap', 'CData', walls{2});
set(h, 'EdgeColor', 'none');

% Plot right wall
rightX = [roomWidth roomWidth; roomWidth roomWidth];
rightY = [roomHeight roomHeight; 0 0];
rightZ = [0 rightDepth; 0 rightDepth];
h = surface(rightX, rightY, rightZ, 'FaceColor', 'texturemap', 'CData', walls{3});
set(h, 'EdgeColor', 'none');

% Plot ceiling
ceilingX = [0 roomWidth; 0 roomWidth];
ceilingY = [roomHeight roomHeight; roomHeight roomHeight];
ceilingZ = [ceilingDepth ceilingDepth; 0 0];
h = surface(ceilingX, ceilingY, ceilingZ, 'FaceColor', 'texturemap', 'CData', walls{4});
set(h, 'EdgeColor', 'none');

% Plot rear wall
rearX = [0 roomWidth; 0 roomWidth];
rearY = [roomHeight roomHeight; 0 0];
rearZ = [0 0; 0 0];
h = surface(rearX, rearY, rearZ, 'FaceColor', 'texturemap', 'CData', walls{5});
set(h, 'EdgeColor', 'none');

% Set up the view
xlabel('X');
ylabel('Y');
zlabel('Z');
title('3D Room Visualization');
axis vis3d;

% turn off axis 
%axis off;

% Enable rotation
rotate3d on;

% Set camera
% Create toolbar for camera movement
cameratoolbar(f);

ax = gca;
% Set camera target at slightly in front of center of rear wall
ax.CameraTarget = [roomWidth / 2, average_depth * 0.8, roomHeight / 2];
% Set camera position at center of "entrance"
campos([roomWidth / 2, 0, roomHeight / 2]);
% Set field of view
ax.CameraViewAngle = 90;
% Enable perspective view
ax.Projection = 'perspective';

% Turn off axis scaling
axis equal;

% Show the plot
hold off;

end