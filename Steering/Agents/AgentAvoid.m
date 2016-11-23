classdef AgentAvoid < Agent
    %AGENTAVOID This agent avoids any other object
    
    properties
    end
    
    methods
        function obj = AgentAvoid()
            % obj.type = 'AgentAvoid';
            obj.velocity = [0.1; 0.1];
        end
       function obj = nextStep(obj, objectList)
           
            steering_avoid = obj.steeringObjAvoidance(objectList);
            steering_direction = steering_avoid;
            
            obj = obj.computeVeloPos(steering_direction);
            obj = obj.reOrientate();
            
            % pause for a moment to allow graphics to catch up
            pause(0.005);
        end
    end
    
end

