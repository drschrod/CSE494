classdef AgentPathFollow < Agent
    %AGENTPATHFOLLOW This agent follows a multi-segment path according to 
    %               Reynold's steering
    
    properties
    end
    
    methods
        function obj = AgentPathFollow()
            % obj.type = 'AgentPathFollow';
            obj.color = 'c';
        end
        
        function obj = nextStep(obj, objectList)
                       
            % initial target position is predicted future position
            magn = norm(obj.velocity);
            if (norm(obj.velocity) == 0)
                magn = 0.01;
            end
            target = obj.position + 2*(obj.velocity/magn);
            
            % get path object
            for i=1:length(objectList)
                object = objectList{i};
                if (strcmp(object.type,'Path') == 1)
                    po = object;
                end
            end
            
            % get normal point
            normalpt = obj.getNormalPoint(target, po.startpt, po.endpt);
            
            % steer back to path if necessary
            newtarget = target;
            distance = obj.findDistance(target, normalpt);
            if (distance > po.radius)
                % find vector B
                ab = po.endpt - po.startpt;
            
                % normalize vector B
                magn = norm(ab);
                if (norm(ab) == 0)
                    magn = 0.01;
                end
                ab = ab / magn;
                
                % scale up vector B
                result = ab * 2;
                % add result to normalpt to get new target
                newtarget = normalpt + result;
            end
            
            % if gone past end of path, double back to endpt
            if (newtarget(1,1) > po.endpt(1,1))
                newtarget = po.endpt;
            end
            
            % use new target to steer
            steering_direction = obj.steeringSeek(newtarget);
            
            % show the desired velocity vector
            v = [obj.position'; newtarget'; obj.position']; 
            patch('Faces', 1:3, 'Vertices', v, 'FaceColor', 'red')
            
            obj = obj.computeVeloPos(steering_direction);
            obj = obj.reOrientate();
            
            %  wait for a moment to help show details
            pause(0.2);
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

