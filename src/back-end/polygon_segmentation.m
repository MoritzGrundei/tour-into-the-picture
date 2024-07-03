function [mask, frame] = polygon_segmentation(image, boundingPolygon)
% POLYGON_SEGMENTATION Segments an image based on a bounding multiedge polygon into foreground and background.
%
%    MASK = SEGMENTATION(IMAGE, BOUNDINGPOLYGON) takes an input IMAGE and
%    a BOUNDINGPOLYGON and returns a binary MASK where the region inside
%    the polygon is segmented.
%
%    Inputs:
%       IMAGE - A 2D or 3D matrix representing the input image.
%       BOUNDINGPOLYGON - A Nx2 matrix representing the vertices of the
%                         bounding polygon in negative mathematical order
%
%    Outputs:
%       MASK - A binary mask of the same size as the input image, with the
%              segmented region inside the bounding polygon set to 1, and
%              the rest set to 0.
%       FRAME - Rectangle vertices around the foreground object. 

    % Calculate bounds for subimage extraction

    L = superpixels(image, 200);


    PADDING = 10;
    minX = ceil(max(min(boundingPolygon(:,1)) - PADDING, 1));
    maxX = floor(min(max(boundingPolygon(:,1)) + PADDING, size(image, 2)));
    minY = ceil(max(min(boundingPolygon(:,2)) - PADDING, 1));
    maxY = floor(min(max(boundingPolygon(:,2)) + PADDING,size(image, 1)));

    % Extract subimage within bounding polygon
    subImage = image(minY:maxY, minX:maxX, :);

    initMask = poly2mask(boundingPolygon(:,1), boundingPolygon(:,2),size(image,1),size(image,2));
    initSubMask = initMask(minY:maxY, minX:maxX);

    subMask = grabCutSegmentation(subImage, initSubMask);

    
    % Initialize a full-size mask of zeros
    mask = zeros(size(image, 1), size(image, 2));

    % Place the subMask into the full-size mask
    mask(minY:maxY, minX:maxX) = subMask;
    frame = [minX minY; maxX minY; maxX maxY; minX maxY];

end

function mask = grabCutSegmentation(image, initMask)
    % Perform Lazy Snapping Segmentation using superpixels and markers
    L = superpixels(image, 300);
    % BW = boundarymask(L);
    % imshow(imoverlay(image,BW,'cyan'),'InitialMagnification',67)

    % Perform GraphCut
    mask = grabcut(im2gray(image), L, initMask, "MaximumIterations",25);
    %B = labeloverlay(image,mask);
    %imshow(B)

end