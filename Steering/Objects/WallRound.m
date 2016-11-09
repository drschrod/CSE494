classdef WallRound < Object
    %WALLROUND Just a round wall
    
    properties
    end
    
    methods
            function obj = WallRound(targ)  % changed it so that the wall is formed around each target created
            % set initial values
            obj.position = targ.position; 
            obj.radius = 1;
            obj.type = 'Wall';
            obj.color = 'g';
        end
        
        function visualize(obj)
            v = [obj.position' + [-2 2]; obj.position' + [2 2]]; % this section allows for the walls to be visualized
            patch('Faces', 1:2, 'Vertices', v, 'FaceColor', 'red')
            v = [obj.position' + [2 -2]; obj.position' + [2 2]]; 
            patch('Faces', 1:2, 'Vertices', v, 'FaceColor', 'red')
             v = [obj.position' + [-2 2]; obj.position' + [-2 -2]]; 
            patch('Faces', 1:2, 'Vertices', v, 'FaceColor', 'red')
        end
           
    
    end
    
end

