%% 3D plot of image
% run this script to generate 3D plot of a test image, Points are manually
% implemented and later on received by gen12Points function


% assign 2D parameters, later calculated
roomDepth = 500;
roomHeight = 500;
roomWidth = 100;


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

% add a foreground object
fg_points = [
    350,460; %TR
    495,460; %TL
    300,590; %BR
    540,590; %BL
    ];

% transformation usually not necessary
foreground_object = projective_transformation(input_image, fg_points(1, :), fg_points(2, :), fg_points(3, :), fg_points(4, :), 150, 100);

fg_points = [
    350,460; %TR
    495,460; %TL
    540,590; %BL
    300,590; %BR
    ];

fg_points = [
    300,420; %TR
    550,420; %TL
    600,650; %BL
    250,650; %BR
    ];

inpaintedImage = retouch_background(input_image, fg_points);


fg_points = [

    495,460; %TL
    350,460; %TR
    300,590; %BR
    540,590; %BL
    ];

fg_points = [

    495,460; %TL
    800,460; %TR
    800,400; %BR
    540,400; %BL
    ];

wallnumber = foreground_wall(Points, fg_points)
% function that generates 3D plot with given dummy data
% !!! needs to be updated to current input structure
%plot_3D_room(inpaintedImage,Points, roomDepth, roomHeight, roomWidth);


% Display the original image and the inpainted image
figure;
subplot(1, 3, 1);
imshow(input_image);
title('Original Image');

subplot(1, 3, 2);
imshow(foreground_mask);
title('Foreground Mask');

subplot(1, 3, 3);
imshow(inpaintedImage);
title('Inpainted Image');

% add to plot
%plot_foreground_object(foreground_object, 150, 50, 0, 200, 100);