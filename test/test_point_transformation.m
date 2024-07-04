%% Script for testing projective_transformation

% Load the input image
input_image = imread('static/images/simple-room.png');

% Display the input image
%figure;
%imshow(input_image);
%title('Input Image');

% Define the coordinates of the four corners of the trapezoid

TL = [-300, -300];
TR = [280, 206];
BL = [1, 619];
%BL = [-300, 900];
BR = [280, 412];

%TR = [560, 206];
%TL = [280, 206];
%BR = [560, 412];
%BL = [280, 412];

BR = [848, 620];
TR = [520, 412];
BL = [1, 619];
TL = [280, 412];

outputWidth = 400;
outputHeight = 300;

[output_image,tform] = projective_transformation(input_image,TL,TR,BL,BR,outputWidth,outputHeight);


fg_points = [
    350,460; %TR
    495,460; %TL
    300,590; %BR
    540,590; %BL
    ];
[x1, y1] = transformPointsForward(tform,fg_points(1,1),fg_points(1,2));
[x2, y2] = transformPointsForward(tform,fg_points(2,1),fg_points(2,2));


% Display the output image
figure;
imshow(output_image);

hold on;
plot([x1, x2], [y1, y2], '-o');
title('Output Image');
hold off;