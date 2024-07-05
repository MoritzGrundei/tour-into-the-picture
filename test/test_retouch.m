% Read an image
img = imread('static/images/simple-room.png');

% Define the polygon vertices
foregroundPolygon = [
    350,460; %TR
    495,460; %TL
    540,590; %BL
    300,590; %BR
    ];


output = retouch_background(img, foregroundPolygon, 'stretch', 1.2);
% output = retouch_background(img, foregroundPolygon);

% Display the original and the filled image
figure;
subplot(1, 2, 1);
imshow(img);
title('Original Image');

subplot(1, 2, 2);
imshow(output);
title('Image with Filled Polygon');
