classdef Receiver < handle
    % Receiver for backend calls

    properties
    end

    methods
        function obj = Receiver()
        end

        function plot3dRoom(obj, imageSource, backgroundPolygon, vanishingPoint)
            % where does the depth come from? making arbitrary assumption
            
            % we estimate the 12 vertices of the room that we want to reconstruct
            points = get12Points(imageSource.CData, vanishingPoint, backgroundPolygon);

            % estimate width, height of the wall at the back as well as the
            % depth of the room
            [roomDepth, roomHeight, roomWidth] = get_room_dimensions(backgroundPolygon, imageSource.CData);

            % threeD_points = get_threeD_points(points,vanishingPoint);
            % testpoints = test(vanishingPoint,points')';

            % get room depths 
            [depth_15, depth_24, depth_711, depth_810] = compute_room_depth(points, vanishingPoint, roomDepth);
            
            % [roomDepth, roomHeight, roomWidth] = get_room_dimensions(backgroundPolygon,imageSource.CData);

            threeDplot_function(imageSource.CData, [points(:, 2), points(:, 1)], roomDepth, roomHeight, roomWidth)
        end
    end
end