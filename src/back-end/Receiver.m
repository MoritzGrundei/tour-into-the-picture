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
            foregroundFrames = zeros(4,2,length(foregroundPolygons));
            for ii=1:length(foregroundPolygons)
                [foregroundMasks(:,:,ii), foregroundFrames(:,:,ii)] = polygon_segmentation(imageSource.CData, foregroundPolygons{ii});
            end

            points = get12Points(imageSource.CData, vanishingPoint, backgroundPolygon);

            roomDepth = 500;
            roomHeight = 500;
            roomWidth = 500;

            threeDplot_function(imageSource.CData, [points(:, 2), points(:, 1)], roomDepth, roomHeight, roomWidth)
        end
    end
end