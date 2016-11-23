classdef AgentArrive < Agent
    %AGENTARRIVE This agent arrives according to Reynold's steering
    %behavior
    
    properties
        slowcircle        %  distance at which agent begins to slow down
    end
    
    methods
        function obj = AgentArrive()
            % obj.type = 'AgentArrive';
            obj.color = 'c';
            obj.slowcircle = 50;
        end
        
        function obj = nextStep(obj, objectList)
                       
            % determine steering force to arrive at target
            steering_direction = obj.steeringArrive(objectList, obj.slowcircle);
            
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

