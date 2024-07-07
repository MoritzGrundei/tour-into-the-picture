classdef Receiver < handle
    % Receiver for backend calls

    properties
    end

    methods
        function obj = Receiver()
        end

        function plot3dRoom(obj, imageSource, backgroundPolygon, vanishingPoint, foregroundPolygons, useSeg, imageFileName)
            % define variables for easier handling
            numForegroundObjects = length(foregroundPolygons);
            background = imageSource.CData;
            
            % Calculate the 12 points as specified in the paper
            points = get12Points(imageSource.CData, vanishingPoint, backgroundPolygon);
            
            % estimate width, height of the wall at the back as well as the
            % depth of the room
            [ceilingDepth, floorDepth, rightDepth, leftDepth, roomHeight, roomWidth] = get_room_dimensions(background, points,vanishingPoint);

            % generate masks for foreground objects
            foregroundMasks = zeros(size(background,1), size(background, 2), length(foregroundPolygons));
            foregroundFrames = zeros(4,2,length(foregroundPolygons));
            for ii=1:numForegroundObjects
                [foregroundMasks(:,:,ii), foregroundFrames(:,:,ii)] = polygon_segmentation(background, foregroundPolygons{ii}, useSeg);
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
            foregroundCoordinates = cell(numForegroundObjects);
            for i = 1:numForegroundObjects
                foregroundCoordinates{i} = zeros(4, 3);
                % trim mask to frame dimensions
                frame = foregroundFrames(:,:,i);
                mask = foregroundMasks(frame(1,2):frame(4,2),frame(1,1):frame(2,1), i);
                % plot surface
                %foregroundCoordinates{i}(:, :) = plot_foreground_object(Points, foregroundFrames(:,:,i), tform, walls, foregroundTextures{i}, mask);
                [TL, TR, BR, BL] = plot_foreground_object(Points, foregroundFrames(:,:,i), tform, walls, foregroundTextures{i}, mask);
                foregroundCoordinates{i}(1, :) = TL;
                foregroundCoordinates{i}(2, :) = TR;
                foregroundCoordinates{i}(3, :) = BR;
                foregroundCoordinates{i}(4, :) = BL;
            end

            % Extract image name from file path
            [~, imageName, ~] = fileparts(imageFileName);

            % Check for existing files and update the filename accordingly
            counter = 1;
            saveFilename = ['output/', imageName, '_3Dplot_', sprintf('%03d', counter), '.fig'];
            while exist(saveFilename, 'file')
                % Update the filename with the counter
                saveFilename = ['output/', imageName, '_3Dplot_', sprintf('%03d', counter), '.fig'];
                counter = counter + 1;
            end

            % Save the figure to a .fig file
            savefig(hfig, saveFilename);
            
            % have the camera do a roomtour, including foreground objects
            pan_camera(hfig, roomWidth, roomHeight, floorDepth, foregroundCoordinates);

        end
    end
end