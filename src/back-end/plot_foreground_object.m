function [TL, TR, BR, BL] = plot_foreground_object(Points, foreground_frame, tforms, walls, foreground_texture, foreground_mask)
% PLOT_FOREGROUND_OBJECT plots a 2D surface on a specified position in the
% 3D plot.
% arguments:
%   Points: 12 points specifying room geometry
%    foreground_frame: Rectangular frame encapsulating the object
%    tform: projective transformations of the different walls
%    walls: transformed images of the different walls; contain room dimensions
%    foreground_texture: image to be applied on the 2D surface
%    foreground_mask: mask of the object (for hiding black pixels)
% return:
%   3d coordinates of the foregorund object

% function to determine side of foreground object
wall_number = get_wall_number(Points, foreground_frame);

% function to get 3D coordinates of foreground
[TL, TR, BR, BL] = foreground_coordinates(tforms{wall_number}, foreground_frame, wall_number, walls);

X = [TL(1), TR(1); BL(1), BR(1)];
Y = [TL(2), TR(2); BL(2), BR(2)];
Z = [TL(3), TR(3); BL(3), BR(3)];

h = surface(X, Y, Z, 'FaceColor', 'texturemap', 'CData', foreground_texture, ...
    'EdgeColor', 'none');
% Add AlphaMask to hide black background
h.FaceAlpha = 'texturemap';
h.AlphaData = foreground_mask;

end