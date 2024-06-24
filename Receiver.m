classdef Receiver < handle
    % Receiver for backend calls

    properties
        NumberOfCalls = 0
    end

    methods
        function obj = Receiver()
            obj.NumberOfCalls = 0;
        end

        function plot3dRoom(obj, image, backgroundPolygon, vanshingPoint)
            obj.NumberOfCalls = obj.NumberOfCalls + 1;
            disp("Called " + num2str(obj.NumberOfCalls) + " times!")
        end
    end
end