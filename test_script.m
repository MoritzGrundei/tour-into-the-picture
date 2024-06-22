%% Script for testing projective_transformation

% Load the input image
input_image = imread('simple-room.png');

% Display the input image
figure;
imshow(input_image);
title('Input Image');

% Define the coordinates of the four corners of the trapezoid

TL = [1, 1];
TR = [280, 206];
BL = [1, 619];
BR = [280, 412];

outputWidth = 200;
outputHeight = 200;

output_image = projective_transformation(input_image,TL,TR,BL,BR,outputWidth,outputHeight);

% Display the output image
figure;
imshow(output_image);
title('Output Image');