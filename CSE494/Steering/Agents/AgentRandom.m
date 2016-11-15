classdef AgentRandom < Agent
    %AGENTRANDOM This agent has a random behaviour
    
    properties
    end
    
    methods
        function obj = AgentRandom()
            % obj.type = 'AgentRandom';
            obj.color = 'yellow';
        end
       function obj = nextStep(obj, objectList)
           
            steering_direction = randn(2,1) * 0.02;
            
            obj = obj.computeVeloPos(steering_direction);
            obj = obj.reOrientate();
        end
    end
    
end

