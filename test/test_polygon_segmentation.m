% clear;
% 
% input_image = imread('static/images/simple-room.png');
% 
% boundingPolygon = [338.1059  444.1203; 488.3752  442.5045; 517.4596  471.5889; 540.0808  555.6104; ...
%   540.0808  579.8474; 514.2280  589.5422; 504.5332  578.2316; 454.4434  578.2316; ...
%   342.9533  581.4632; 341.3375  592.7738; 313.8689  594.3896; 307.4057  575.0000; ...
%   292.8636  571.7684];
% 
% mask = polygon_segmentation(input_image, boundingPolygon);
% 
% figure(1);
% subplot(1, 2, 1);
% imshow(input_image);
% title('Original Image');
% hold on;
% plot([boundingPolygon(:,1); boundingPolygon(1,1)], [boundingPolygon(:,2); boundingPolygon(1,2)], 'r-', 'LineWidth', 2);
% 
% subplot(1, 2, 2);
% imshow(mask);
% title('Segmented Mask');
% hold off;


input_image = imread('static/images/oil-painting.png');

boundingPolygon = [
    726.1733  773.2852;
    698.0144  768.9531;
    669.8556  766.7870;
    650.3610  745.1264;
    659.0253  719.1336;
    674.1877  680.1444;
    700.1805  677.9783;
    719.6751  695.3069;
    747.8339  714.8014;
    775.9928  725.6318;
    788.9892  738.6282;
    797.6534  762.4549;
    758.6643  779.7834
];

mask = polygon_segmentation(input_image, boundingPolygon);

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
