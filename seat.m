classdef seat < Object
    %TARGET Point used as target for Agents
    %   
    
    properties
        velocity  % velocity of target (0 for static targets)
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
            % show target as a circle with lines through it
            viscircles(obj.position', obj.radius, 'EdgeColor', obj.color);
            v = [obj.position' + [-2 2]; obj.position' + [2 2]]; 
            patch('Faces', 1:2, 'Vertices', v, 'FaceColor', 'red')
            v = [obj.position' + [2 -2]; obj.position' + [2 2]]; 
            patch('Faces', 1:2, 'Vertices', v, 'FaceColor', 'red')
             v = [obj.position' + [-2 2]; obj.position' + [-2 -2]]; 
            patch('Faces', 1:2, 'Vertices', v, 'FaceColor', 'red')
            %x1 = obj.position.x-.5;
            %x2 = obj.position.x+.5;
            %y1 = obj.position.y-.5;
            %y2 = obj.position.y+.5;
            %x = [x1, x1, x2,x2];
            %y = [y1, y2, y2,y1];
            %plot(x, y, 'b-');
        end
    end
    
end