classdef AgentAvoid < AgentForAvoiding
    %AGENTSEEK This agent seeks a target according to Reynold's steering
    %behavior
    
    properties
    end
    
    methods
        function obj = AgentAvoid()
            % obj.type = 'AgentSeek';
            obj.color = 'c';
        end
        
        function obj = nextStep(obj, objectList)
            % get seek target among objects in objectList
            for i=1:length(objectList)
                object = objectList{i};
                if (strcmp(object.type,'Target') == 1)
                    target = object.position;
                elseif (strcmp(object.type,'Wall') == 1)
                    wall = object;
                end
            end         
        
          
        
            % determine steering force to seek target
            steering_direction = obj.steeringSeek(target);
            normalized = steering_direction/ norm(steering_direction);
            ahead= obj.position + normalized*2;
            aheadhalf= obj.position+ normalized;
            distance = abs(wall.position- ahead);
           % distance2 = abs(wall.position- aheadhalf);
            avoidance_force = (ahead - wall.position);
            avoidance_force = norm(avoidance_force)*5;
                 if distance < 3
                     steering_direction = steering_direction + avoidance_force;
                     steering_direction = steering_direction+ cos(45);
               %  elseif distance2 < 3
               % steering_direction = steering_direction + avoidance_force;
               % steering_direction = sin(steering_direction)*500;
                end
                
   
         %   steering_direction = obj.colAvd(wall,wall1,wall3);  % probably need to take this out
            % show the desired velocity vector
            % v = [obj.position'; target'; obj.position']; 
            % patch('Faces', 1:3, 'Vertices', v, 'FaceColor', 'red')
         %   if(obj.position - wall.position <wall.radius)
          %    avoidance= ahead-wall.position*obj.max_speed; 
           %    collisionAvoidance = steering+avoidance;
            %steering_d   
         %end
            % compute the new velocity, position, and orientation of agent
            obj = obj.computeVeloPos(steering_direction);
            obj = obj.reOrientate();
            
            %  wait for a moment to help show details
            % pause(0.2);
        end
    end
    
end

