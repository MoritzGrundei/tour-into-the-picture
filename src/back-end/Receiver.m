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

            roomDepth = 500;
            roomHeight = 300;
            roomWidth = 500;

            % cut foreground objects (+retouching)
            

            % redefine 12 points for perspective
            Points = [points(:, 2), points(:, 1)];

            % calculate each wall perspective
            % init array 
            tform = cell(5);
            walls = cell(5);
            % floor cell{1}
            % left wall  cell{2}
            % right wall cell{3}
            % ceiling cell{4}
            % rear wall cell{5}

            [walls{1}, tform{1}] = projective_transformation(imageSource.CData,Points(1, :),Points(2, :),Points(3, :),Points(4, :),roomWidth,roomDepth);
            [walls{2}, tform{2}] = projective_transformation(imageSource.CData,Points(11, :),Points(7, :),Points(5, :),Points(1, :),roomDepth,roomHeight);
            [walls{3}, tform{3}] = projective_transformation(imageSource.CData,Points(8, :),Points(12, :),Points(2, :),Points(6, :),roomDepth,roomHeight);
            [walls{4}, tform{4}] = projective_transformation(imageSource.CData,Points(9, :),Points(10, :),Points(7, :),Points(8, :),roomWidth,roomDepth);
            [walls{5}, tform{5}] = projective_transformation(imageSource.CData,Points(7, :),Points(8, :),Points(1, :),Points(2, :),roomWidth,roomHeight);
            
            % construct room
            plot_3D_room(walls);

            % add forreground objects
            %plot_foreground_object(Points, polygon, rectangle, imageSource.CData, walls, tform); 
            
            plot_foreground_object(Points, 1, rectangle, 1, tform, walls, foreground_texture)

        end
    end
end