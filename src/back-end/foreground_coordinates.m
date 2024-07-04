function [TL, TR, BR, BL] = foreground_coordinates(tform, rectangle, wall_number, walls)
% Calculate the 3D coordiantes with the wall_number and the 2D coordinates
% of the foreground rectangle
% input: transformed image tform, foreground rectangle, wall_number, walls

% extract room dimensions from input arguments
roomWidth = size(walls{5}, 2);
roomHeight = size(walls{5}, 1);
leftDepth = size(walls{2}, 2);
rightDepth = size(walls{3}, 2);
floorDepth = size(walls{1}, 1);
ceilingDepth = size(walls{4}, 1);

if wall_number == 1
    % floor
    BR_2D = transformPointsForward(tform{1}, rectangle(3,1), rectangle(3,2));
    BL_2D = transformPointsForward(tform{1}, rectangle(4,1), rectangle(4,2));
    rectangle_height = (rectangle(4,2)-rectangle(1,2))/(rectangle(2,1)-rectangle(1,1))*(BR_2D(1)-BL_2D(1)); 
    z_pos = BL_2D(2);
    
    BR = [BR_2D(1), 0, z_pos];
    BL = [BL_2D(1), 0, z_pos];
    TL = [BL_2D(1), rectangle_height, z_pos];
    TR = [BR_2D(1), rectangle_height, z_pos];

elseif wall_number == 2
    % left wall
    TL_2D = transformPointsForward(tform{2}, rectangle(1,1), rectangle(1,2));
    BL_2D = transformPointsForward(tform{2}, rectangle(4,1), rectangle(4,2));
    rectangle_width = (rectangle(2,1)-rectangle(1,1))/(rectangle(4,2)-rectangle(1,2))*(TL_2D(2)-BL_2D(2));
    z_pos = leftDepth - TL_2D(1);

    TL = [0, roomHeight - TL_2D(2), z_pos];
    BL = [0, roomHeight - BL_2D(2), z_pos];
    TR = [rectangle_width, roomHeight - TL_2D(2), z_pos];
    BR = [rectangle_width, roomHeight - BL_2D(2), z_pos];

elseif wall_number == 3 
    % right wall
    TR_2D = transformPointsForward(tform{3}, rectangle(2,1), rectangle{2,2});
    BR_2D = transformPointsForward(tform{3}, rectangle(3,1), rectangle(3,2));
    rectangle_width = (rectangle(2,1)-rectangle(1,1))/(rectangle(4,2)-rectangle(1,2))*(TR_2D(2)-BR_2D(2));
    z_pos = TR_2D(1);

    TR = [roomWidth, roomHeight - TR_2D(2), z_pos];
    BR = [roomWidth, roomHeight - BR_2D(2), z_pos];
    TL = [roomWidth - rectangle_width, roomHeight - TR_2D(2), z_pos];
    BL = [roomWidth - rectangle_width, roomHeight - BR_2D(2), z_pos];

elseif wall_number == 4
    % ceiling
    TL_2D = transformPointsForward(tform{4}, rectangle(1,1), rectangle(1,2));
    TR_2D = transformPointsForward(tform{4}, rectangle(2,1), rectangle(2,2));
    rectangle_height = (rectangle(1,2)-rectangle(4,2))/(rectangle(1,2)-rectangle(2,2))*(x_TR-x_TL);
    z_pos = ceilingDepth - TL_2D(2);

    TL = [TL_2D(1), roomHeight, z_pos]; 
    TR = [TR_2D(1), roomHeight, z_pos];
    BL = [TL_2D(1), roomHeight - rectangle_height, z_pos]; 
    BR = [TR_2D(1), roomHeight - rectangle_height, z_pos];

else 
    % background wall
    msg = 'Foreground object in rearwall rectangle';
    error(msg);

end 

end
