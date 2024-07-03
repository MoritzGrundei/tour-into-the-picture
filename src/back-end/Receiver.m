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
            leftWall = projective_transformation(imageSource.CData,Points(11, :),Points(7, :),Points(5, :),Points(1, :),roomDepth,roomHeight);
            rightWall = projective_transformation(imageSource.CData,Points(8, :),Points(12, :),Points(2, :),Points(6, :),roomDepth,roomHeight);
            rearWall = projective_transformation(imageSource.CData,Points(7, :),Points(8, :),Points(1, :),Points(2, :),roomWidth,roomHeight);
            floorWall = projective_transformation(imageSource.CData,Points(1, :),Points(2, :),Points(3, :),Points(4, :),roomWidth,roomDepth);
            ceilingWall = projective_transformation(imageSource.CData,Points(9, :),Points(10, :),Points(7, :),Points(8, :),roomWidth,roomDepth);
            
            % construct room
            plot_3D_room(leftWall,rightWall,rearWall,floorWall,ceilingWall);

            % add forreground objects
        end
    end
end