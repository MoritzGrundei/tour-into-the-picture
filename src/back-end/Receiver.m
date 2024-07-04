classdef Receiver < handle
    % Receiver for backend calls

    properties
    end

    methods
        function obj = Receiver()
        end

        function plot3dRoom(obj, imageSource, backgroundPolygon, vanishingPoint)
            % where does the depth come from? making arbitrary assumption

            points = get12Points(imageSource.CData, vanishingPoint, backgroundPolygon);
            threeD_points = get_threeD_points(points,vanishingPoint);
            testpoints = test(vanishingPoint,points')';
            %roomDepth =500;
            %roomWidth = 500;
            %roomHeight = 500;
            [roomDepth, roomHeight, roomWidth] = get_room_dimensions(backgroundPolygon,imageSource.CData);

            threeDplot_function(imageSource.CData, [points(:, 2), points(:, 1)], roomDepth, roomHeight, roomWidth)
        end
    end
end