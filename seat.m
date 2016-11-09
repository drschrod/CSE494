classdef seat < Object
    %TARGET Point used as target for Agents
    %   
    
    properties
        velocity  % velocity of target (0 for static targets)
        seatNum   %The seat number within the row
        row       %The row letter, should be a char a-z
    end
    
    methods
        
        function obj = seat()
            % set initial values
            obj.velocity = [0;0];  % static target by default
            obj.position = [0;0];  % at origin by default
            obj.radius = 2;
            obj.type = 'seat';
            obj.color = 'r';
        end
        
        function visualize(obj)
           %got rid of the visualize within the seat since its made in wall
           %round
           viscircles(obj.position', obj.radius, 'EdgeColor', obj.color);
           
            
        end
    end
    
end