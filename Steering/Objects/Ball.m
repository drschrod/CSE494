classdef Ball < Object
    %Ball - a class for a simple ball
    %   Detailed explanation goes here
    
    properties
        mass        % Mass of the Ball
        velocity    % Velocity of the Ball
        max_speed   % Maximal speed of the Ball
        cimpulse    % impulse at collision
        maxX        % maximum size of screen in X
        maxY        % maximum size of screen in Y
    end
    
     methods
        function obj = Ball()  
            obj.mass = .3;
            obj.position = [0;0];
            % obj.velocity = [-0.2;-0.2];
            obj.velocity = [0;0];   % ball is static at start
            obj.max_speed = 1;
            obj.color = 'blue';
            obj.type = 'Ball';
            obj.radius = 0.5; 
            obj.cimpulse = 0.5;
            obj.maxX = 50;
            obj.maxY = 50;
        end
        
        function obj = setScreenSize(mx, my)
            maxX = mx;
            maxY = my;
        end
        
        function ref = visualize(obj)
            %VISUALIZE This function visualized the agent as well as the
            %circular radius
            viscircles(obj.position', obj.radius);
        end
        
        function [obj] = calcNewVelocity(obj,objectList)
            % loop over all objects and check for collisions
            for i=1:length(objectList)
                object = objectList{i};
                rad = object.radius;
                
                % ignore paths
                if( strcmp(object.type, 'Path'))
                    continue;
                end
                
                % calculate distance
                d = norm(obj.position - object.position);
                
                % avoid self-collision
                if( strcmp(object.type, 'Ball'))
                    continue;
                end

                % collision occured
                if(d  < (rad + obj.radius))  
                     diffVec =  obj.position - object.position; 
                     if( strcmp(obj.type, 'Agent'))
                        obj.velocity = object.velocity - obj.cimpulse * diffVec;
                        object.velocity = obj.velocity + obj.cimpulse * diffVec;
                     else
                         obj.velocity = obj.velocity + obj.cimpulse * diffVec/obj.radius;
                     end
                end
            end  
            obj.velocity = min(obj.velocity, obj.max_speed);
            obj.velocity = max(obj.velocity, -obj.max_speed);
            obj.position = obj.position + obj.velocity;
            
            % clamp accross screen
            if obj.position(1, 1) < obj.radius
                obj.velocity(1, 1) = -obj.velocity(1, 1);
            end
            if obj.position(2, 1) < obj.radius
                obj.velocity(2, 1) = -obj.velocity(2, 1);
            end
            if obj.position(1, 1) > (obj.maxX - obj.radius)
                obj.velocity(1, 1) = -obj.velocity(1, 1);
            end
            if obj.position(2, 1) > (obj.maxY - obj.radius)
                obj.velocity(2, 1) = -obj.velocity(2, 1);
            end
        end
     
        function obj = nextStep(obj, objectList)
            %nextStep This function computes the new position and velocity
            %values of the agent for the next time step and implements the
            %specific behaviour of the agent. This function has to be
            %implemented for each new agent!
            obj = obj.calcNewVelocity(objectList); 
        end
     end
end