classdef Receiver < handle
    % Receiver for backend calls

    properties
    end

    methods
        function obj = Receiver()
        end

        function plot3dRoom(obj, imageSource, backgroundPolygon, vanishingPoint)
            % where does the depth come from? making arbitrary assumption
            % here we have to apply the spidery mesh
            % taking test values for now TODO: implement this!
            points = get12Points(imageSource, vanishingPoint, backgroundPolygon);

            roomDepth = 500;
            roomHeight = 500;
            roomWidth = 500;
            
            
            % manually assign Points 
            % points = zeros(12, 2);
            % 
            % points(1, :) = [290, 412];
            % points(2, :) = [570, 412];
            % points(3, :) = [1, 620];
            % points(4, :) = [848, 620];
            % points(5, :) = [1, 620];
            % points(6, :) = [848, 620];
            % points(7, :) = [290, 206];
            % points(8, :) = [570, 206];
            % points(9, :) = [0, 0];
            % points(10, :) = [848, 0];
            % points(11, :) = [0, 0];
            % points(12, :) = [848, 0];

            threeDplot_function(imageSource.CData, [points(:, 2), points(:, 1)], roomDepth, roomHeight, roomWidth)
        end
    end
end