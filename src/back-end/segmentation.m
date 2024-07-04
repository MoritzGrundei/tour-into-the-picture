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
    % grabCutSegmentation(subImage);

    subMask = kMeansSegmentation(subImage);
    subMask = contourSegmentation(subImage, subMask, 300);
    subMask = applyDisk(subMask, 10);

    B = labeloverlay(subImage,subMask);
    imshow(B)
    
    % Initialize a full-size mask of zeros
    mask = zeros(size(image, 1), size(image, 2));

    % Place the subMask into the full-size mask
    mask(minY:maxY, minX:maxX) = subMask;

end

function mask = kMeansSegmentationSpatial(image)
    % Create a binary mask for the subimage using k-means
    wavelength = 2.^(0:5) * 3;
    orientation = 0:45:135;
    g = gabor(wavelength,orientation);
    imageGray = im2gray(im2single(image));
    gabormag = imgaborfilt(imageGray,g);
    montage(gabormag,"Size",[4 6])

    for i = 1:length(g)
        sigma = 0.5*g(i).Wavelength;
        gabormag(:,:,i) = imgaussfilt(gabormag(:,:,i),3*sigma); 
    end
    montage(gabormag,"Size",[4 6])

    nrows = size(image,1);
    ncols = size(image,2);
    [X,Y] = meshgrid(1:ncols,1:nrows);

    featureSet = cat(3,imageGray,gabormag,X,Y);

    mask = imsegkmeans(featureSet,2,"NormalizeInput",true);

    mask = (mask == mask(floor(size(mask,1)/2), floor(size(mask,2)/2)));
end


function mask = kMeansSegmentation(image)
    % Create a binary mask for the subimage using k-means
    mask = imsegkmeans(image,2);
    mask = (mask == mask(floor(size(mask,1)/2), floor(size(mask,2)/2)));
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


function mask = lazyCutSegmentation(image)
    % Perform Lazy Snapping Segmentation using superpixels and markers
    [L, N] = superpixels(image, 200);
    BW = boundarymask(L);
    imshow(imoverlay(image,BW,'cyan'),'InitialMagnification',67)

    % Define foreground and background markers based on the given logic
    fg_markers = false(size(image, 1), size(image, 2));
    bg_markers = false(size(image, 1), size(image, 2));
    
    % (1,1) pixel is background
    bg_markers(1, 1) = true;

    % Middle pixel is foreground
    midY = round(size(image, 1) / 2);
    midX = round(size(image, 2) / 2);
    fg_markers(midY, midX) = true;

    % Convert markers to linear indices
    foregroundInd = find(fg_markers);
    backgroundInd = find(bg_markers);

    % Perform Lazy Snapping
    mask = lazysnapping(image, L, foregroundInd, backgroundInd);
    B = labeloverlay(image,mask);
    imshow(B)

end

function mask = grabCutSegmentation(image)
    % Perform Lazy Snapping Segmentation using superpixels and markers
    L = superpixels(image, 200);
    BW = boundarymask(L);
    imshow(imoverlay(image,BW,'cyan'),'InitialMagnification',67)

    % Define foreground and background markers based on the given logic
    fg_markers = false(size(image, 1), size(image, 2));
    bg_markers = false(size(image, 1), size(image, 2));
    
    % (1,1) pixel is background
    bg_markers(1, 1) = true;

    % Middle pixel is foreground
    midY = round(size(image, 1) / 2);
    midX = round(size(image, 2) / 2);
    fg_markers(midY, midX) = true;

    % Convert markers to linear indices
    foregroundInd = find(fg_markers);
    backgroundInd = find(bg_markers);

    % Perform GraphCut
    roiPoints = [1, 1; size(image, 2), 1; size(image, 2), size(image, 1); 1, size(image, 1)];
    ROI = poly2mask(roiPoints(:,1),roiPoints(:,2),size(L,1),size(L,2));
    mask = grabcut(image, L, ROI, "MaximumIterations", 20);
    B = labeloverlay(image,mask);
    imshow(B)

end