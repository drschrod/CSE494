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
            obj.boxTopLeft = obj.position' + [-2 2];  % gives the position of the top left corner of the box
            obj.boxTopRight =  obj.position' + [2 2]; % gives the position of the top right corner of the box 
           patch('Faces', 1:2, 'Vertices', v, 'FaceColor', 'red')
           
           v = [obj.position' + [2 -2]; obj.position' + [2 2]]; 
           obj.boxTopRight = obj.position' + [2 2];   %gives position of top right corner of box
           obj.boxBottomRight = obj.position' + [2 -2]; %gives position of bottom right corner of box
           patch('Faces', 1:2, 'Vertices', v, 'FaceColor', 'red')
           
            v = [obj.position' + [-2 2]; obj.position' + [-2 -2]]; 
            obj.boxTopLeft = obj.position' + [-2 2]; % gives position of top left corner
            obj.boxBottomLeft =  obj.position' + [-2 -2]; % gives position of bottom left corner
            patch('Faces', 1:2, 'Vertices', v, 'FaceColor', 'red')
        end
           
    
    end
    
end

