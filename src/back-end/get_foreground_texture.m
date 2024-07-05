function texture = get_foreground_texture(whole_image, mask, frame)
%GET_FOREGROUND_TEXTURE returns the texture of a foreground image, using
% the mask on the whole_image in the frame size
% input: 2D whole_image, mask and frame 
% outpur: 2D foreground texture 

% Image dimensions
width = frame(2,1) - frame(1,1) + 1;
height = frame(3,2) - frame(2,2) + 1;

% Create a new image
texture = uint8(zeros(height, width, 3));

% Apply the mask to keep only the object in the new image
for channel = 1:3
    masked_channel = whole_image(:,:,channel) .* uint8(mask);
    texture(:,:,channel) = masked_channel(frame(1,2):frame(4,2),frame(1,1):frame(2,1));
end

figure;
imshow(texture);
end