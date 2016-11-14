classdef AgentWander < Agent
    %AGENTWANDER This agent wanders according to Reynold's suggestion:
    %               it retains general steering direction and makes small 
    %               random displacements to direction each frame
    
    properties
    end
    
    methods
        function obj = AgentWander()
            % obj.type = 'AgentWander';
            obj.color = 'green';
        end
        
        function obj = nextStep(obj, objectList)
           
            % wander "strength" is radius of circle ahead of agent
            wstrength = 2;
           
            % determine random displacement of steerangle on circumference
            a = -2*pi/10;          % lower end of random interval
            b = 2*pi/10;           % upper end of random interval
            random_displ = a + (b - a)*(rand);
            
            % add random displacement to steerangle
            obj.steerangle = obj.steerangle + random_displ;
            
            % find x and y components of steerangle on circumference
            x_increment = wstrength * cos(obj.steerangle);
            y_increment = wstrength * sin(obj.steerangle);
            increment = [x_increment; y_increment];
            %
            % initial target position is predicted future position
            % magn = norm(obj.velocity);
            % if (norm(obj.velocity) == 0)
            %     magn = 0.01;
            % end
            target = obj.position + 4*(obj.normlz(obj.velocity));
            
            % show the circle ahead of the agent
            viscircles(target', wstrength);
            
            % show the line from agent to center of circle ahead
            v = [obj.position'; target'; obj.position']; 
            patch('Faces', 1:3, 'Vertices', v, 'FaceColor', 'blue')

            % revise target to add random point on circumference
            target = target + increment;
            % determine steering force to seek the revised target
            steering_wander = obj.steeringSeek(target);
            steering_direction = steering_wander;  
            
            % show the desired velocity vector
            v = [obj.position'; target'; obj.position']; 
            patch('Faces', 1:3, 'Vertices', v, 'FaceColor', 'red')
            
            % compute the new velocity, position, and orientation of agent
            obj = obj.computeVeloPos(steering_direction);
            obj = obj.reOrientate();
            
            %  wait for a moment to help show details
            pause(0.2);
        end
    end
    
end

