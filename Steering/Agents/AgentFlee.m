classdef AgentFlee < Agent
    %AGENTFLEE This agent flees a target according to Reynold's steering
    %behavior; this behavior is opposite of seek
    
    properties
    end
    
    methods
        function obj = AgentFlee()
            % obj.type = obj.setType('AgentFlee');
            obj.color = 'c';
            % obj.velocity = [0;0];  % agent not moving at start
        end
        
        function obj = nextStep(obj, objectList)
            % get flee target among objects in objectList
            for i=1:length(objectList)
                object = objectList{i};
                if (strcmp(object.type,'Target') == 1)
                    target = object.position;
                end
            end            
            
            % determine steering force to flee target
            % negative of seek steering force
            steering_direction = obj.steeringFlee(target);
            
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

