function [roomDepth, roomHeight, roomWidth] = get_room_dimensions(backgroundRectangle, input_image)
    [~, image_width, ~] = size(input_image);
    ir_coords = zeros(4, 2);
    ir_coords(1, :) = [backgroundRectangle(4, 2), backgroundRectangle(4, 1)];
    ir_coords(2, :) = [backgroundRectangle(3, 2), backgroundRectangle(3, 1)];
    ir_coords(3, :) = [backgroundRectangle(1, 2), backgroundRectangle(1, 1)];
    ir_coords(4, :) = [backgroundRectangle(2, 2), backgroundRectangle(2, 1)];
    roomWidth = ceil(ir_coords(2,2)-ir_coords(1,2));
    roomHeight = ceil(ir_coords(1,1)-ir_coords(3,1));
    roomDepth = ceil(max(ir_coords(1,2),image_width-ir_coords(2,2)));

end