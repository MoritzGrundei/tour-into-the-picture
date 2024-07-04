% Read an image
img = imread('static/images/simple-room.png');

% Define the polygon vertices
foregroundPolygon = [
    300,420; %TR
    550,420; %TL
    600,650; %BL
    250,650; %BR
    ];

output = retouch_background(img, foregroundPolygon);


% Display the original and the filled image
figure;
subplot(1, 2, 1);
imshow(img);
title('Original Image');

subplot(1, 2, 2);
imshow(output);
title('Image with Filled Polygon');
