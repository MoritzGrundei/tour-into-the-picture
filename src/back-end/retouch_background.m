function filledImg = retouch_background(img, foregroundMask)
%RETOUCH_BACKGROUND Fills in an area of the image with regionfill
% inputs:
%   img: background image,
%   foregroundMask: mask of the foreground object to be cut from the image

% Initialize an empty image to store the results
filledImg = img;

% Process each color channel independently
for c = 1:size(img, 3)
    % Extract the color channel
    colorChannel = img(:, :, c);
    
    % Apply regionfill to the color channel using the mask
    filledColorChannel = regionfill(colorChannel, foregroundMask);
    
    % Store the filled color channel back to the output image
    filledImg(:, :, c) = filledColorChannel;
end

end