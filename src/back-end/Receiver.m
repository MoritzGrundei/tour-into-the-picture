classdef Receiver < handle
    % Receiver for backend calls

    properties
    end

    methods
        function obj = Receiver()
        end

        function plot3dRoom(obj, imageSource, backgroundPolygon, vanishingPoint, foregroundPolygons)
            % define variables for easier handling
            numForegroundObjects = length(foregroundPolygons);
            background = imageSource.CData;
            
            % Calculate the 12 points as specified in the paper
            points = get12Points(imageSource.CData, vanishingPoint, backgroundPolygon);
            

            % mocked room dimensions of sagrada familia
            floorDepth = 916;
            leftDepth = 1321;
            rightDepth = 1318;
            ceilingDepth = 879;
            roomHeight = 829;
            roomWidth = 377;

            % mocked room dimensions of oil painting
            floorDepth = 400;
            leftDepth = 400;
            rightDepth = 400;
            ceilingDepth = 400;
            roomHeight = 400;
            roomWidth = 500;
            
            % to fix: get room dimensions from function

            % generate masks for foreground objects
            foregroundMasks = zeros(size(background,1), size(background, 2), length(foregroundPolygons));
            foregroundFrames = zeros(4,2,length(foregroundPolygons));
            for ii=1:numForegroundObjects
                [foregroundMasks(:,:,ii), foregroundFrames(:,:,ii)] = polygon_segmentation(background, foregroundPolygons{ii});
            end

            % cut foreground objects
            foregroundTextures = cell(numForegroundObjects);
            for i = 1:numForegroundObjects
                % extract textures
                foregroundTextures{i} = get_foreground_texture(background, foregroundMasks(:,:,i), ...
                    foregroundFrames(:,:,i));
            end

            % retouch background
            for i = 1:numForegroundObjects
                background = retouch_background(background, foregroundMasks(:,:,i));
            end

            % redefine 12 points for perspective
            Points = [points(:, 2), points(:, 1)];

            % calculate each wall perspective
            % init array 
            tform = cell(5); 
            walls = cell(5);
            % floor: cell{1}
            % left wall:  cell{2}
            % right wall: cell{3}
            % ceiling: cell{4}
            % rear wall: cell{5}

            [walls{1}, tform{1}] = projective_transformation(background,Points(1, :),Points(2, :),Points(3, :),Points(4, :),roomWidth,floorDepth);
            [walls{2}, tform{2}] = projective_transformation(background,Points(11, :),Points(7, :),Points(5, :),Points(1, :),leftDepth,roomHeight);
            [walls{3}, tform{3}] = projective_transformation(background,Points(8, :),Points(12, :),Points(2, :),Points(6, :),rightDepth,roomHeight);
            [walls{4}, tform{4}] = projective_transformation(background,Points(9, :),Points(10, :),Points(7, :),Points(8, :),roomWidth,ceilingDepth);
            [walls{5}, tform{5}] = projective_transformation(background,Points(7, :),Points(8, :),Points(1, :),Points(2, :),roomWidth,roomHeight);
            
            % construct room
            hfig = plot_3D_room(walls);

            % add foreground objects
            for i = 1:numForegroundObjects
                % trim mask to frame dimensions
                frame = foregroundFrames(:,:,i);
                mask = foregroundMasks(frame(1,2):frame(4,2),frame(1,1):frame(2,1), i);
                % plot surface
                plot_foreground_object(Points, foregroundFrames(:,:,i), tform, walls, foregroundTextures{i}, mask);
            end

            pan_camera(hfig, roomWidth, roomHeight, floorDepth);

        end
    end
end