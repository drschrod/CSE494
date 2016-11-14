classdef AgentForAvoiding < Object
    %AGENT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        mass        % Mass of the Agent 
        velocity    % Velocity of the Agent
        max_force   % The max of velocity
        max_speed   % Maximal speed of the Agent
        orientation % The current orientation of the agent represented as a transformation matrix with the basis vectors
        steerangle  % Current state of angle used for steering direction (used for wander)
    end
    
    properties (Access = private)
        
        %vert = [ -.5 -.5; .5 -.5 ; 0 .5];
        vert = [0.5 0; -0.5 -0.5; -0.5 0.5 ]; % The triangular shape of the agent
        %rad = 0.7;
        
    end
    
    methods
        function obj = AgentForAvoiding()
            % initialize properties
            obj.mass = 1;
            obj.position = [0;0];    % agent at origin by default
            obj.velocity = [0.0;0.0];    % agent not moving at start by default
            obj.max_force = 0.5;    % orig: 0.05;  better PFM: 0.2
            obj.max_speed = 0.6;       % orig: 1;   better PFM: 0.
            obj.orientation = [1 0; 0 1];
            obj.color = 'blue';
            obj.type = 'Agent';
            obj.radius = 1;
            obj.steerangle = 0;
       
            
        end
  
        
        function ref = visualize(obj)
            %VISUALIZE This function visualizes the agent as well as the
            %circular radius
            vertReal = obj.vert * obj.orientation;   % transform: rotate
            vertReal = vertReal + repmat(obj.position',3,1);  % transform: translate
            % draw the agent's triangle
            ref = patch('Faces',1:3,'Vertices',vertReal,'FaceColor',obj.color);
            % draw the agent's circle around the triangle
            viscircles(obj.position', obj.radius);
        end
        
        
        function obj = reOrientate(obj)
            %reOrientade COmputes a new orientation matrix assuming ther
            %was a change in the velocity/direction of the agent
           magn = norm(obj.velocity);
           if (magn == 0)
               magn = 0.01;
           end
           new_forward = obj.velocity / magn;
          % new_forward = obj.normlz(obj.velocity);
           
           %new_forward = obj.velocity / norm(obj.velocity);
           %if not(  new_forward == new_forward )
           %    new_forward = [1;0]
           %end
           new_forward = [new_forward;0];
           new_up = [0;0;1];
           new_side = cross(new_forward,new_up);
           obj.orientation = [new_forward(1:2,1),new_side(1:2,1)]';
        end
        
        function obj = nextStep(obj, seatList)
            %nextStep This function computes the new position and velocity
            %values of the agent for the next time step and implements the
            %specific behaviour of the agent. This function has to be
            %implemented for each new agent!
            for i=1:length(seatList)
                object = seatList{i};
                if (strcmp(object.type,'seat') == 1)
                    chair = object.position;
                end
            end  
            %steering_direction = [0;0];
            steering_direction = obj.steeringSeek(chair);
            obj.computeVeloPos(steering_direction);
            obj.reOrientate();
        end
        
        function obj = computeVeloPos(obj,steering_direction)
            %computeVeloPos Taking a steering direction thus function
            %computes the new velocity and position of the agent in the
            %next time step
            steering_force = min(steering_direction, repmat(obj.max_force,2,1));
            steering_force = max(steering_force, -repmat(obj.max_force,2,1));
            acceleration = steering_force/obj.mass;
            obj.velocity = min(obj.velocity + acceleration, obj.max_speed);
            obj.velocity = max(obj.velocity, -obj.max_speed);
            obj.position = obj.position + obj.velocity;
        end
        
        function output_vector = normlz(obj, input_vector)
            %normlz This function computes the normalized vector
            % input_vector is expected to have form: [x_comp; y_comp]
            magn = norm(input_vector);
            % make sure the magnitude is not zero before dividing by it
            if (magn == 0)
                output_vector = [0;0];
            else
                output_vector = input_vector / magn;
            end
        end
        
      
   
            
       % end
            function steering = steeringSeek(obj, target)
            %steeringSeek This function implements the Seek steering
            %behaviour
            %  MES: here's where the error was
            % desired_velocity = (obj.position - target) * obj.max_speed;
            % compute the desired velocity vector from the target
            desired_velocity = (target - obj.position) * obj.max_speed;
            
            % normalize the desired velocity vector
            desired_velocity = obj.normlz(desired_velocity);
            
            % compute steering vector from desired and current velocity
            % vectors
            
            steering = desired_velocity - obj.velocity;
            end
            
        
       
         
        
        function normalpt = getNormalPoint(obj, predpt, startpt, endpt)
            % find vector A
            ap = predpt - startpt;
            % find vector B
            ab = endpt - startpt;
            
            % normalize vector B
            magn = norm(ab);
            if (norm(ab) == 0)
                magn = 0.01;
            end
            ab = ab / magn;
            
            % find projection of vector A on vector B
            ab = ab * dot(ap, ab);
            
            % find normal point
            normalpt = startpt + ab;
            
        end
        
        function distance = findDistance(obj, startpt, endpt)
            % find the segment vector
            segvec = endpt - startpt;
            
            % normalize segment vector
            distance = norm(segvec);
            
        end
        
      
                
    end
    
end

