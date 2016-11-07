classdef AgentForward < Agent
    %AGENTFORWARD This agent just moves forward
    
    properties
    end
    
    methods
        function obj = AgentForward()
            % obj.type = 'AgentForward';
            obj.color = 'black';
        end
        function obj = nextStep(obj, objectList)
           
            steering_direction =  [ 0.5; 0.5];
            
            obj = obj.computeVeloPos(steering_direction);
            obj = obj.reOrientate();
        end
    end
    
end

