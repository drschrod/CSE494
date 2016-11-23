classdef Agent < Object
    %AGENT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        targetPositionX
        targetPositionY
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
        function obj = Agent()
            % initialize properties
            obj.mass = 1;
            obj.position = [0;0];    % agent at origin by default
            obj.velocity = [0.0;0.0];    % agent not moving at start by default
            obj.max_force = 0.2;    % orig: 0.05;  better PFM: 0.2
            obj.max_speed = 0.6;       % orig: 1;   better PFM: 0.6
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
        
        function obj = nextStep(obj, objectList)
            %nextStep This function computes the new position and velocity
            %values of the agent for the next time step and implements the
            %specific behaviour of the agent. This function has to be
            %implemented for each new agent!
            
            steering_direction = [0;0];
            
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
        
        function steering = steeringFlee(obj, target)
            %steeringFlee This function implements the Flee steering
            %behaviour
            % inverse of seek  - compute velocity away from target
            desired_velocity = (obj.position - target) * obj.max_speed;
            
            % normalize the desired velocity vector
            desired_velocity = obj.normlz(desired_velocity);
            
            % compute steering vector from desired and current velocity
            % vectors
            steering = desired_velocity - obj.velocity;
        end
        
        function steering = steeringPFM(obj, objectList)
            % initial target position is predicted future position
            % predict future position 2 units ahead
            numUA = 2;
            target = obj.position + numUA*(obj.normlz(obj.velocity));
            
            % get path object
            for i=1:length(objectList)
                object = objectList{i};
                if (strcmp(object.type,'Path') == 1)
                    po = object;
                end
            end
            
            % find number of segments in path
            [m,n] = size(po.ptmtx);
            
            % initialize world record distance
            worldRecord = 10000;
            
            % find the closest normal and start and end pts
            for i=1:m-1 
                
                % get start and end points of segment
                cur_startpt = po.ptmtx(i,1:2)';
                cur_endpt = po.ptmtx(i+1,1:2)';
            
                % get normal point
                cur_normalpt = obj.getNormalPoint(target, cur_startpt, cur_endpt);
                
                % make sure normal pt is on the segment
                % assumes path goes from left to right
                % if (cur_normalpt(1,1) < cur_startpt(1,1) || cur_normalpt(1,1) > cur_endpt(1,1))
                %     cur_normalpt = cur_endpt;
                % end
                
                % make sure normal pt is on the segment
                % path can go any direction
                x_min = min(cur_startpt(1,1), cur_endpt(1,1));
                x_max = max(cur_startpt(1,1), cur_endpt(1,1));
                if (cur_normalpt(1,1) < x_min || cur_normalpt(1,1) > x_max)
                    distance_start = obj.findDistance(target, cur_startpt);
                    distance_end = obj.findDistance(target, cur_endpt);
                    cur_normalpt = cur_endpt;
                    if (distance_start < distance_end)
                        cur_normalpt = cur_startpt;
                    end
                end
                
                % get distance to normal pt
                cur_distance = obj.findDistance(target, cur_normalpt);
                
                % if distance to normal pt is smaller, select it
                if (cur_distance < worldRecord)
                    worldRecord = cur_distance;
                    normalpt = cur_normalpt;
                    startpt = cur_startpt;
                    endpt = cur_endpt;
                end
            end
            
            % now that we've found the closest normal, steer accordingly
            
            % steer back to path if necessary
            newtarget = target;
            distance = obj.findDistance(target, normalpt);
            if (distance > po.radius)
                % find vector B
                ab = endpt - startpt;
            
                % normalize vector B
                magn = norm(ab);
                if (norm(ab) == 0)
                    magn = 0.01;
                end
                ab = ab / magn;
                
                % scale up vector B
                lead_factor = 1;
                % lead_factor = 2;
                result = ab * lead_factor;
                % add result to normalpt to get new target
                newtarget = normalpt + result;
            end
            
            % use new target to steer
            steering = obj.steeringSeek(newtarget);
            
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
        
        function steering = steeringArrive(obj, objectList, slowcircle)
             target= [obj.targetPositionX; obj.targetPositionY];
            %steeringArrive This function implements the Arrival steering
            %behaviour
            
            % get arrival target among objects in objectList
           
           % for i=1:length(objectList)
            %    object = objectList{i};
             %   if (strcmp(object.type,'Target') == 1)
              %      target = object.position;
               % end
            %end 
           
            
            % compute the desired velocity vector from the target
            desired_velocity = (target - obj.position);
            
            % find the distance to target
            dist = norm(desired_velocity);
            
            % normalize the desired velocity vector
            desired_velocity = obj.normlz(desired_velocity);
            
            % set default speed factor equal to max speed
            speed_factor = obj.max_speed;
            
            % if closer than 100 units, scale magnitude according to distance
            if (dist < slowcircle)
                speed_factor = obj.max_speed * (dist / slowcircle);
            end
            
            % apply speed factor to desired velocity
            desired_velocity = desired_velocity * speed_factor;
            
            % compute steering vector from desired and current velocity
            % vectors
            steering = desired_velocity - obj.velocity;
        end

        
        function steering = steeringObjAvoidance(obj,objectList)
            %steeringObjAvoidance This function implements the Object
            %AVoidance steering behaviour
            [~,newVec] = findNearestCollission(obj,objectList);
            if newVec(1) == inf
                steering = zeros(2,1);
                return
            end
            steering = newVec;
        end
        
        function [object,newVec] = findNearestCollission(obj,objectList)
            %findNearestCollission A basic implementation of a method to
            %find objects with which the agent is likely to collide and
            %then compute the vector 
            
            % Get the transformation matrix and its inverse
            oMat = obj.orientation;
            oMatInv = inv(oMat);
            
            
            minDist = inf;
            minID = -1;
            localX = -1;
            localY = -1;
            
            % Go through all objects and see if we collide with them
            for i=1:length(objectList)
                object = objectList{i};
                
                % ignore the object if it is of type path
                if (strcmp(object.type, 'Path') == 1)
                    continue;
                end
                
                % ignore the object if it is of type target
                if (strcmp(object.type, 'Target') == 1)
                    continue;
                end
                
                rad = object.radius;
                localPos = object.position;
                % Project the position of the object into the local
                % coordinate system of the agent
                localPos = oMatInv * (localPos - obj.position);
                % Check if the object is: (1) in front of the agent,
                % (2) in the corridor defined by the radius of our agent
                % and (3) if the object is identical to our agent
                if localPos(1) >= 0 && abs(localPos(2)) < (obj.radius + rad)...
                        && not(obj.equal(object))
                    if minDist > localPos(1) - rad
                        minDist = localPos(1) - rad;
                        minID = i;
                        localX = localPos(1);
                        localY = localPos(2);
                    end
                end
            end
            
            % Either if there is no object to collide with or we do not
            % care since it is too far away
            if minID == -1 || minDist > obj.radius * 5
                object = -1;
                newVec = inf;
                return
            end

            newVec = [0;-localY];
            %Reproject the vector back into the orientation of the global
            %coordinate system
            newVec = oMat * newVec;
            
            object = objectList{minID};
            
        end
        
    end
    
end

