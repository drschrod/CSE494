classdef Target < Object
    %TARGET Point used as target for Agents
    %   
    
    properties
        velocity  % velocity of target (0 for static targets)
    end
    
    methods
        
        function obj = Target()
            % set initial values
            obj.velocity = [0;0];  % static target by default
            obj.position = [0;0];  % at origin by default
            obj.radius = 2;
            obj.type = 'Target';
            obj.color = 'y';
        end
        
        function visualize(obj)
            % show target as a circle with lines through it
            viscircles(obj.position', obj.radius, 'EdgeColor', obj.color);
            v = [obj.position' + [2 0]; obj.position' - [2 0]; obj.position' + [2 0]]; 
            patch('Faces', 1:3, 'Vertices', v, 'FaceColor', 'red')
            v = [obj.position' + [0 2]; obj.position' - [0 2]; obj.position' + [0 2]]; 
            patch('Faces', 1:3, 'Vertices', v, 'FaceColor', 'red')
        end
    end
    
end

