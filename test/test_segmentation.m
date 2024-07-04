clear;

input_image = imread('static/images/simple-room.png');

boundingPolygon = [300, 450; 550, 450; 550, 600; 300, 600];

mask = segmentation(input_image, boundingPolygon);

figure(1);
subplot(1, 2, 1);
imshow(input_image);
title('Original Image');
hold on;
plot([boundingPolygon(:,1); boundingPolygon(1,1)], [boundingPolygon(:,2); boundingPolygon(1,2)], 'r-', 'LineWidth', 2);

subplot(1, 2, 2);
imshow(mask);
title('Segmented Mask');
hold off;


input_image = imread('static/images/oil-painting.png');

boundingPolygon = [630, 680; 820, 680; 820, 800; 630, 800];

mask = segmentation(input_image, boundingPolygon);

figure(2);
subplot(1, 2, 1);
imshow(input_image);
title('Original Image');
hold on;
plot([boundingPolygon(:,1); boundingPolygon(1,1)], [boundingPolygon(:,2); boundingPolygon(1,2)], 'r-', 'LineWidth', 2);

subplot(1, 2, 2);
imshow(mask);
title('Segmented Mask');
hold off;
