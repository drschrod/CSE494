classdef WallRound < Object
    %WALLROUND Just a round wall
    
    properties
    end
    
    methods
        function visualize(obj)
            viscircles(obj.position', obj.radius,'EdgeColor','black');
        end
    end
    
end

