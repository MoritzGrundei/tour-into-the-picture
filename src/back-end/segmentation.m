function mask = segmentation(image, boundingPolygon)
% SEGMENTATION Segments an image based on a bounding polygon into foreground and background.
%
%    MASK = SEGMENTATION(IMAGE, BOUNDINGPOLYGON) takes an input IMAGE and
%    a BOUNDINGPOLYGON and returns a binary MASK where the region inside
%    the polygon is segmented.
%
%    Inputs:
%       IMAGE - A 2D or 3D matrix representing the input image.
%       BOUNDINGPOLYGON - A 4x2 matrix representing the vertices of the
%                         bounding polygon. Order: [UL, UR, LR, LL]
%
%    Outputs:
%       MASK - A binary mask of the same size as the input image, with the
%              segmented region inside the bounding polygon set to 1, and
%              the rest set to 0.

    % Calculate bounds for subimage extraction
    minX = min(boundingPolygon(:,1));
    maxX = max(boundingPolygon(:,1));
    minY = min(boundingPolygon(:,2));
    maxY = max(boundingPolygon(:,2));

    % Extract subimage within bounding polygon
    subImage = image(minY:maxY, minX:maxX, :);

    subMask = kMeansSegmentation(subImage);
    subMask = contourSegmentation(subImage, subMask, 500);
    subMask = applyDisk(subMask, 10);
    B = labeloverlay(subImage,subMask);
    figure(3)
    imshow(B)
    
    % Initialize a full-size mask of zeros
    mask = zeros(size(image, 1), size(image, 2));

    % Place the subMask into the full-size mask
    mask(minY:maxY, minX:maxX) = subMask;

end

function mask = kMeansSegmentation(image)
    % Create a binary mask for the subimage using k-means
    mask = imsegkmeans(image,2);
    mask = mod(mask, 2);
end

function mask = applyDisk(mask, dist)
    % Apply morphological closing to fill small holes
    se = strel('disk', dist);  % Create a structural element (disk-shaped)
    mask = imclose(mask, se);  % Closing operation
end

function mask = contourSegmentation(image, initMask, numIter)
    % Convert image to grayscale if it is not already
    if size(image, 3) == 3
        grayImage = rgb2gray(image);
    else
        grayImage = image;
    end

    % Evolve the contour based on the grayscale image and the initial mask
    mask = activecontour(grayImage, initMask, numIter, 'edge');
end
