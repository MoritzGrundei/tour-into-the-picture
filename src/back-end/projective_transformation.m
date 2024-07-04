function [rect_image,tform] = projective_transformation(input_image, TL, TR, BL, BR, outputWidth, outputHeight)
% PROJECTIVE_TRANSFORMATION  Transform a trapezoidal section of the
% input_image into a rectangular image.
%
%   TL, TR, BL, BR: top left, top right, bottom left, bottom right corners
%   of the trapezoidal image section.
%   outputWidht, outputHeight: dimensions of the output image

% Create array of input corners
inputPoints = [TL; TR; BR; BL];

% Define the coordinates of the four corners of the desired rectangle
outputPoints = [0, 0; outputWidth-1, 0; outputWidth-1, outputHeight-1; 0, outputHeight-1];

% Calculate the transformation matrix
tform = fitgeotrans(inputPoints, outputPoints, 'projective');

% Apply the transformation to the input image
rect_image = imwarp(input_image, tform, 'OutputView', imref2d([outputHeight, outputWidth]));

end