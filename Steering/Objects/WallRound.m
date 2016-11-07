classdef WallRound < Object
    %WALLROUND Just a round wall
    
    properties
    end
    
    methods
        function visualize(obj)
            viscircles(obj.position', obj.radius,'EdgeColor','black');
        end
           
        function obj = WallRound()
            % set initial values
            obj.position = [0;0];  % at origin by default
            obj.radius = 1;
            obj.type = 'Wall';
            obj.color = 'g';
        end
        
    end
    
end

