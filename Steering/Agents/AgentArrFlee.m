classdef AgentArrFlee < Agent
    %AGENTARRFLEE This agent arrives and flees according to Reynold's steering
    %behavior
    
    properties
        slowcircle        %  distance at which agent begins to slow down
        time              %  used to count time
    end
    
    methods
        function obj = AgentArrFlee()
            % obj.type = 'AgentArrFlee';
            obj.color = 'c';
            obj.slowcircle = 50;
            obj.time = 0;
        end
        
        function obj = nextStep(obj, objectList)
                       
            % determine steering force to arrive at target
            steer_arrive = obj.steeringArrive(objectList, obj.slowcircle);
            
            % get flee target among objects in objectList
            for i=1:length(objectList)
                object = objectList{i};
                if (strcmp(object.type,'TargetF') == 1)
                    target2 = object.position;
                end
            end 
            
            % determine steering force to flee target
            steer_flee = obj.steeringFlee(target2);
            
            % set weights
            if (obj.time < 100)
                c_arr = 1.0;
                c_fl = 0;
            else
                c_arr = 0;
                c_fl = 1.0;
            end
            
            % compute steering direction as linear combo of above
            steering_direction = c_arr*steer_arrive + c_fl*steer_flee;

            % show the desired velocity vector
            % v = [obj.position'; target'; obj.position']; 
            % patch('Faces', 1:3, 'Vertices', v, 'FaceColor', 'red')
            
            % compute the new velocity, position, and orientation of agent
            obj = obj.computeVeloPos(steering_direction);
            obj = obj.reOrientate();
            
            %  wait for a moment to help show details
            % pause(0.2);
            
            % increment time
            obj.time = obj.time + 1;
        end
    end
    
end

