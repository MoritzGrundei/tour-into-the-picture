function plot_foreground_object(Points, polygon, rectangle, imageSource, tform, walls, foreground_texture)
% PLOT_FOREGROUND_OBJECT plots a 2D surface on a specified position in the
% 3D plot.
% x, y, z: lower left corner coordinates of the rectangle

% function to determine side of foreground object
wall_number = get_wall_number(Points, rectangle);

% function to get 3D coordinates of foreground
[TL, TR, BR, BL] = foreground_coordinates(tform{wall_number}, rectangle, wall_number, walls); 

X = [TL(1), TR(1); BL(1), BR(1)];
Y = [TL(2), TR(2); BL(2), BR(2)];
Z = [TL(3), TR(3); BL(3), BR(3)];
h = surface(X, Y, Z, 'FaceColor', 'texturemap', 'CData', foreground_texture);
set(h, 'EdgeColor', 'none');

end