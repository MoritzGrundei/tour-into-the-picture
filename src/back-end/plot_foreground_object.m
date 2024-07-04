function plot_foreground_object(Points, polygon, rectangle, imageSource, walls, )
% PLOT_FOREGROUND_OBJECT plots a 2D surface on a specified position in the
% 3D plot.
% x, y, z: lower left corner coordinates of the rectangle

% function to determine side of foreground object
wall_number = get_wall_number(Points, rectangle);

% function to get 3D coordinates of foreground
[TL, TR, BR, BL] = foreground_coordinates(tform{wall}, rectangle, wall_number, walls); 

% scaling 

corners_x = [TL(1) TR(1); BL(1) BR(2)];
corners_y = [y y; y y];
corners_z = [z+height z+height; z z];
h = surface(corners_x, corners_y, corners_z, 'FaceColor', 'texturemap', 'CData', polygon);
set(h, 'EdgeColor', 'none');


corners_x = [x x+width; x x+width];
corners_y = [y y; y y];
corners_z = [z+height z+height; z z];
h = surface(corners_x, corners_y, corners_z, 'FaceColor', 'texturemap', 'CData', polygon);
set(h, 'EdgeColor', 'none');

end