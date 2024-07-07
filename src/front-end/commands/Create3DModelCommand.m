classdef Create3DModelCommand < Command

    properties
        VanishingPoint double = []; % [y, x] of vanishing point
        BackgroundPolygon double = []; % 4x2 matrix of corners of background polygon
        Receiver % object of command receiver
        Image % image source object
        ForegroundPolygons % cell of foreground polygons
        UseSeg
    end

    methods
        function obj = Create3DModelCommand(vanishingPointROI, backgroundPolygonROI, receiver, image, foregroundPolygonROIs, useSeg)
            obj.VanishingPoint = vanishingPointROI.Position;
            obj.BackgroundPolygon = RectangleToPolygon(backgroundPolygonROI);
            
            obj.ForegroundPolygons = {};
            for ii=1:length(foregroundPolygonROIs)
                obj.ForegroundPolygons{ii} = foregroundPolygonROIs{ii}.Position;
            end
            obj.UseSeg = useSeg;
            obj.Receiver = receiver;
            obj.Image = image;
        end

        function execute(obj)
            obj.Receiver.plot3dRoom(obj.Image, obj.BackgroundPolygon, obj.VanishingPoint, obj.ForegroundPolygons, obj.UseSeg)
        end
    end
end

function polygon = RectangleToPolygon(rectangle)
    x = rectangle.Position(1);
    y = rectangle.Position(2);
    w = rectangle.Position(3);
    h = rectangle.Position(4);
    polygon = [
        x, y;  % Upper left
        x + w, y;  % Upper right
        x + w, y + h;  % Lower right
        x, y + h  % Lower left
    ];
end
