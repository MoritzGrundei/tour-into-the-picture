classdef Create3DModelCommand < Command

    properties
        VanishingPoint double = []; % [y, x] of vanishing point
        BackgroundPolygon double = []; % 4x2 matrix of corners of background polygon
        Receiver % object of command receiver
        Image 
    end

    methods
        function obj = Create3DModelCommand(vanishingPointROI, backgroundPolygonROI, receiver, image)
            obj.VanishingPoint = vanishingPointROI.Position;
            % Ensure backgroundPolygonROI contains expected position data
            x = backgroundPolygonROI.Position(1);
            y = backgroundPolygonROI.Position(2);
            w = backgroundPolygonROI.Position(3);
            h = backgroundPolygonROI.Position(4);
            obj.BackgroundPolygon = [
                x, y;  % Upper left
                x + w, y;  % Upper right
                x + w, y + h;  % Lower right
                x, y + h  % Lower left
            ];
               
            obj.Receiver = receiver;
            obj.Image = image;
        end

        function execute(obj)
            obj.Receiver.plot3dRoom(obj.Image, obj.BackgroundPolygon, obj.VanishingPoint)
        end
    end
end
