%% 3D plot of image
% run this script to generate 3D plot of a test image, Points are manually
% implemented and later on received by gen12Points function

% manually assign Points 
Points = zeros(12, 2);

Points(1 , :) = [280, 412];
Points(2 , :) = [580, 412];
Points(3 , :) = [1, 620];
Points(4, :) = [848, 620];
Points(5 , :) = [1, 620];
Points(6, :) = [848, 620];
Points(7, :) = [280, 206];
Points(8, :) = [580, 206];
Points(9, :) = [0, 0];
Points(10, :) = [848, 0];
Points(11, :) = [0, 0];
Points(12, :) = [848, 0];

% assign 2D parameters, later calculated 
outputWidth = 200;
outputHeight = 200;

% insert image 
input_image = imread('CV-Challenge-24-Datensatz/simple-room.png');

% calculate each wall perspektive
leftWall = projective_transformation(input_image,Points(11, :),Points(7, :),Points(5, :),Points(1, :),outputWidth,outputHeight);
rightWall = projective_transformation(input_image,Points(8, :),Points(12, :),Points(2, :),Points(6, :),outputWidth,outputHeight);
rearWall = projective_transformation(input_image,Points(7, :),Points(8, :),Points(1, :),Points(2, :),outputWidth,outputHeight);
floorWall = projective_transformation(input_image,Points(1, :),Points(2, :),Points(3, :),Points(4, :),outputWidth,outputHeight);
ceilingWall = projective_transformation(input_image,Points(9, :),Points(10, :),Points(7, :),Points(8, :),outputWidth,outputHeight);

% insert 3D parameters 
roomDepth = 200;
roomHeight = 200;
roomWidth = 200;

% Plot left wall
leftX = [0 0; 0 0];
leftY = [0 roomDepth; 0 roomDepth];
leftZ = [roomHeight roomHeight; 0 0];
surface(leftX, leftY, leftZ, 'FaceColor', 'texturemap', 'CData', leftWall);

% Plot right wall
rightX = [roomWidth roomWidth; roomWidth roomWidth];
rightY = [roomDepth 0; roomDepth 0];
rightZ = [roomHeight roomHeight; 0 0];
surface(rightX, rightY, rightZ, 'FaceColor', 'texturemap', 'CData', rightWall);

% Plot rear wall
rearX = [0 roomWidth; 0 roomWidth];
rearY = [roomDepth roomDepth; roomDepth roomDepth];
rearZ = [roomHeight roomHeight; 0 0];
surface(rearX, rearY, rearZ, 'FaceColor', 'texturemap', 'CData', rearWall);

% Plot floor
floorX = [0 roomWidth; 0 roomWidth];
floorY = [roomDepth roomDepth; 0 0];
floorZ = [0 0; 0 0];
surface(floorX, floorY, floorZ, 'FaceColor', 'texturemap', 'CData', floorWall);

% Plot ceiling
ceilingX = [0 roomWidth; 0 roomWidth];
ceilingY = [0 0; roomDepth roomDepth];
ceilingZ = [roomHeight roomHeight; roomHeight roomHeight];
surface(ceilingX, ceilingY, ceilingZ, 'FaceColor', 'texturemap', 'CData', ceilingWall);

% Set up the view
xlabel('X');
ylabel('Y');
zlabel('Z');
title('3D Room Visualization');
axis vis3d;

% Enable rotation
rotate3d on;

% turn off axis 
%axis off;

% Show the plot
hold off;