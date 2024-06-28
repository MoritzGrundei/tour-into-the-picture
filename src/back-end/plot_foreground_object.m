function plot_foreground_object(texture, x, y, z, width, height)
% PLOT_FOREGROUND_OBJECT plots a 2D surface on a specified position in the
% 3D plot.
% x, y, z: lower left corner coordinates of the rectangle

corners_x = [x x+width; x x+width];
corners_y = [y y; y y];
corners_z = [z+height z+height; z z];
h = surface(corners_x, corners_y, corners_z, 'FaceColor', 'texturemap', 'CData', texture);
set(h, 'EdgeColor', 'none');

end