function pan_camera(hfig, roomWidth, roomHeight, roomDepth, foregroundCoordinates)
%PAN_CAMERA to 4 predefined positions and to every foreground object
% inputs:
%   hfig: handle to the 3D plot
%   room dimensions

pos1 = [roomWidth * 0.9, roomHeight * 0.6, roomDepth];
pos2 = [roomWidth * 0.6, roomHeight * 0.9, roomDepth];
pos3 = [roomWidth * 0.1, roomHeight * 0.1, roomDepth * 0.6];
pos4 = [roomWidth * 0.5, roomHeight * 0.5, roomDepth * 1.2];

% Pan the camera
pause(1);
go_to_position(hfig, pos1, 2, 0.01);
pause(0.5);
go_to_position(hfig, pos2, 2, 0.01);
pause(0.5);
go_to_position(hfig, pos3, 3, 0.01);
pause(0.5);
go_to_position(hfig, pos4, 3, 0.01);

for i = 1:length(foregroundCoordinates)
    posi = [(foregroundCoordinates{i}(1, 1) + foregroundCoordinates{i}(2, 1)) / 2, ...
        (foregroundCoordinates{i}(1, 2) + foregroundCoordinates{i}(4, 2)) / 2, ...
        max(foregroundCoordinates{i}(1, 3) * 1.2, foregroundCoordinates{i}(1, 3) + roomDepth * 0.2)];
    go_to_position(hfig, posi, 2, 0.01);
    pause(1);
    go_to_position(hfig, pos4, 1, 0.01);
    pause(0.5);
end

end

function go_to_position(hfig, goal, duration, tickRate)
%GO_TO_POSITION moves the camera to a new position
% inputs:
%   hfig: handle to the 3d plot
%   goal: goal position
%   duration: duration of the pan
%   tickRate: tick rate of the camera updates; high values will look
%       unsmooth

startingPosition = campos();

for ii = 0:tickRate:duration
    if ~ishghandle(hfig)
        disp('Figure has been closed. Aborting pan.');
        break;
    end
    newPosition = startingPosition + (goal - startingPosition) * (ii / duration);
    campos(newPosition);
    pause(tickRate);
end

end