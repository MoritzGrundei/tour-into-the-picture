%% 3D plot of image
% run this script to generate 3D plot of a test image, Points are manually
% implemented and later on received by gen12Points function


% assign 2D parameters, later calculated  
roomDepth = 500;
roomHeight = 300;
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

% add a foreground object
fg_points = [
    350,460; %TR
    495,460; %TL
    300,590; %BR
    540,590; %BL
    ];

% transformation usually not necessary
foreground_object = projective_transformation(input_image, fg_points(1, :), fg_points(2, :), fg_points(3, :), fg_points(4, :), 150, 100);

% add to plot
plot_foreground_object(foreground_object, 150, 50, 0, 200, 100);