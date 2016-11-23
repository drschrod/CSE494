classdef AgentPathFollowMulti < Agent
    %AGENTPATHFOLLOWMULTI This agent follows a multi-segment path according to 
    %               Reynold's steering
    
    properties
    end
    
    methods
        function obj = AgentPathFollowMulti()
            % obj.type = 'AgentPathFollowMulti';
            obj.color = 'c';
        end
        
        function obj = nextStep(obj, objectList)
                                   
            % use new target to steer
            steering_direction = obj.steeringPFM(objectList);
            
            % show the desired velocity vector
            % v = [obj.position'; newtarget'; obj.position']; 
            % patch('Faces', 1:3, 'Vertices', v, 'FaceColor', 'red')
            
            obj = obj.computeVeloPos(steering_direction);
            obj = obj.reOrientate();
            
            %  wait for a moment to help show details
            % pause(0.2);
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

