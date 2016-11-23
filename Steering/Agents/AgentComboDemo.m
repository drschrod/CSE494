classdef AgentComboDemo < Agent
    %AGENTCOMBODEMO This agent combines several of the Reynolds' steering 
    %behaviors in a linear combination; it follows a multi-segment path,
    %avoids obstacles, and arrives at a target
    
    properties
        slowcircle        % distance at which arrival agent slows down
        time              % keeps track of time
    end
    
    methods
        function obj = AgentComboDemo()
            % obj.type = 'AgentCombo';
            obj.color = 'c';
            obj.slowcircle = 10;
            obj.velocity = [0.01; 0.01];
            obj.time = 0;
        end
        
        function obj = nextStep(obj, objectList)
             
             
            % determine steering force for Path Following
            steer_PFM = obj.steeringPFM(objectList);
            
            % determine steering force for Avoid
            steer_avoid = obj.steeringObjAvoidance(objectList);
            
            % determine steering force for Arrival
            steer_arrive = obj.steeringArrive(objectList, obj.slowcircle);
            
            % set weights
            %
            if((abs(obj.targetPositionX)-abs(obj.position(1,:))) < 6 && (abs(obj.targetPositionY)-abs(obj.position(2,:))) <6) % object is really close to target  
                c_PFM = 1;
                c_av = .5;
                c_arr = .7;
           
            %    c_PFM = .2;
             %  c_av = 0.5;
              %  c_arr = 1;
            end
            
            % compute steering direction as linear combo of above
            steering_direction = c_PFM*steer_PFM + c_av*steer_avoid + c_arr*steer_arrive;
            
            % show the desired velocity vector
            % v = [obj.position'; target'; obj.position']; 
            % patch('Faces', 1:3, 'Vertices', v, 'FaceColor', 'red')
            
            % compute the new velocity, position, and orientation of agent
            obj = obj.computeVeloPos(steering_direction);
            obj = obj.reOrientate();
            
            %  wait for a moment to help show details
            % pause(0.2);
            
            % update time
            obj.time = obj.time + 1;
        end
    end
    
end

