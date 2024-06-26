classdef Invoker < handle
    % Command Invoker
    properties
        InvokerCommand     
    end

    methods
        function obj = Invoker()
            % empty constructor
        end

        function setCommand(obj, command)
            obj.InvokerCommand = command;
        end

        function executeCommand(obj)
            obj.InvokerCommand.execute();
        end
    end
end