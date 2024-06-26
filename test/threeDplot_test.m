%% 3D plot of image
% run this script to generate 3D plot of a test image, Points are manually
% implemented and later on received by gen12Points function


% assign 2D parameters, later calculated  
roomDepth = 500;
roomHeight = 500;
roomWidth = 500;


% manually assign Points 
Points = zeros(12, 2);

Points(1, :) = [290, 412];
Points(2, :) = [570, 412];
Points(3, :) = [1, 620];
Points(4, :) = [848, 620];
Points(5, :) = [1, 620];
Points(6, :) = [848, 620];
Points(7, :) = [290, 206];
Points(8, :) = [570, 206];
Points(9, :) = [0, 0];
Points(10, :) = [848, 0];
Points(11, :) = [0, 0];
Points(12, :) = [848, 0];

% insert image 
input_image = imread('static/images/simple-room.png');

% function that generates 3D plot with given dummy data
threeDplot_function(input_image,Points, roomDepth, roomHeight, roomWidth); 