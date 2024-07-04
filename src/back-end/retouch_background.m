function filledImg = retouch_background(img, foregroundPolygon, varargin)
%RETOUCH_BACKGROUND Fills in a polygonal area of the image with regionfill
%   input img, polygon of the foreground object to be cut from the image,
%   the polygon can optionally be stretched by a given factor 'stretch'

% Input parsing
p = inputParser;
addParameter(p, 'stretch', 1.0, @(x)validateattributes(x, {'numeric'}, {'scalar', '>=', 0}));
parse(p, varargin{:}); 
stretch = p.Results.stretch;

% Calculate the centroid of the polygon
centroid = mean(foregroundPolygon);

% Stretch the polygon vertices
foregroundPolygon = bsxfun(@plus, centroid, stretch * bsxfun(@minus, foregroundPolygon, centroid));

% Create a binary mask of the same size as the image
mask = poly2mask(foregroundPolygon(:,1), foregroundPolygon(:,2), size(img, 1), size(img, 2));

% Initialize an empty image to store the results
filledImg = img;

% Process each color channel independently
for c = 1:size(img, 3)
    % Extract the color channel
    colorChannel = img(:, :, c);
    
    % Apply regionfill to the color channel using the mask
    filledColorChannel = regionfill(colorChannel, mask);
    
    % Store the filled color channel back to the output image
    filledImg(:, :, c) = filledColorChannel;
end

end