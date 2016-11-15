classdef AgentSeek < Agent
    %AGENTSEEK This agent seeks a target according to Reynold's steering
    %behavior
    
    properties
    end
    
    methods
        function obj = AgentSeek()
            % obj.type = 'AgentSeek';
            obj.color = 'c';
        end
        
        function obj = nextStep(obj, objectList)
            % get seek target among objects in objectList
            for i=1:length(objectList)
                object = objectList{i};
                if (strcmp(object.type,'Target') == 1)
                    target = object.position;
                end
            end            
            
            % determine steering force to seek target
            steering_direction = obj.steeringSeek(target);
            
            % show the desired velocity vector
            % v = [obj.position'; target'; obj.position']; 
            % patch('Faces', 1:3, 'Vertices', v, 'FaceColor', 'red')
            
            % compute the new velocity, position, and orientation of agent
            obj = obj.computeVeloPos(steering_direction);
            obj = obj.reOrientate();
            
            %  wait for a moment to help show details
            % pause(0.2);
        end
    end
    
end

