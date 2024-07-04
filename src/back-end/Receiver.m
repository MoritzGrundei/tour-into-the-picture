classdef Receiver < handle
    % Receiver for backend calls

    properties
    end

    methods
        function obj = Receiver()
        end

        function plot3dRoom(obj, imageSource, backgroundPolygon, vanishingPoint, foregroundPolygons)

            % generate masks for foreground objects
            foregroundMasks = zeros(size(imageSource.CData,1), size(imageSource.CData, 2), length(foregroundPolygons));
            foregroundFrames = zeros(2,4,length(foregroundPolygons));
            for ii=1:length(foregroundPolygons)
                [foregroundMasks(:,:,ii), foregroundFrames(:,:,ii)] = polygon_segmentation(imageSource.CData, foregroundPolygons{ii});
            end

            points = get12Points(imageSource.CData, vanishingPoint, backgroundPolygon)
            

            % mocked room dimensions of sagrada familia
            floorDepth = 916;
            leftDepth = 1321;
            rightDepth = 1318;
            ceilingDepth = 879;
            roomHeight = 829;
            roomWidth = 377;

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

            [walls{1}, tform{1}] = projective_transformation(imageSource.CData,Points(1, :),Points(2, :),Points(3, :),Points(4, :),roomWidth,floorDepth);
            [walls{2}, tform{2}] = projective_transformation(imageSource.CData,Points(11, :),Points(7, :),Points(5, :),Points(1, :),leftDepth,roomHeight);
            [walls{3}, tform{3}] = projective_transformation(imageSource.CData,Points(8, :),Points(12, :),Points(2, :),Points(6, :),rightDepth,roomHeight);
            [walls{4}, tform{4}] = projective_transformation(imageSource.CData,Points(9, :),Points(10, :),Points(7, :),Points(8, :),roomWidth,ceilingDepth);
            [walls{5}, tform{5}] = projective_transformation(imageSource.CData,Points(7, :),Points(8, :),Points(1, :),Points(2, :),roomWidth,roomHeight);
            
            % construct room
            plot_3D_room(walls);

            % add foreground objects
            %plot_foreground_object(Points, polygon, rectangle, imageSource.CData, walls, tform); 
            
            %plot_foreground_object(Points, 1, rectangle, 1, tform, walls, foreground_texture)

        end
    end
end