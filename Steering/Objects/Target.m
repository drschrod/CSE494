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
            %{
            %comment and uncomment this 
            v = [obj.position' + [-2 2]; obj.position' + [2 2]]; % this section allows for the walls to be visualized
            obj.boxTopLeft = obj.position' + [-2 2];  % gives the position of the top left corner of the box
            obj.boxTopRight =  obj.position' + [2 2]; % gives the position of the top right corner of the box 
           patch('Faces', 1:2, 'Vertices', v, 'FaceColor', 'red')
           %}
           
             % commment and uncomment this 
             v = [obj.position' + [2 -2]; obj.position' + [-2 -2]]; % this section allows for the walls to be visualized
            obj.boxBottomLeft = obj.position' + [-2 -2];  % gives the position of the bottom left corner of the box
            obj.boxBottomRight =  obj.position' + [2 -2]; % gives the position of the bottom right corner of the box 
           patch('Faces', 1:2, 'Vertices', v, 'FaceColor', 'red')
           
           v = [obj.position' + [2 -2]; obj.position' + [2 2]]; 
           obj.boxTopRight = obj.position' + [2 2];   %gives position of top right corner of box
           obj.boxBottomRight = obj.position' + [2 -2]; %gives position of bottom right corner of box
           patch('Faces', 1:2, 'Vertices', v, 'FaceColor', 'red')
           
            v = [obj.position' + [-2 2]; obj.position' + [-2 -2]]; 
            obj.boxTopLeft = obj.position' + [-2 2]; % gives position of top left corner
            obj.boxBottomLeft =  obj.position' + [-2 -2]; % gives position of bottom left corner
            patch('Faces', 1:2, 'Vertices', v, 'FaceColor', 'red')
            
            viscircles(obj.position', obj.radius, 'EdgeColor', obj.color);
            %v = [obj.position' + [2 0]; obj.position' - [2 0]; obj.position' + [2 0]]; 
            %patch('Faces', 1:3, 'Vertices', v, 'FaceColor', 'red')
            %v = [obj.position' + [0 2]; obj.position' - [0 2]; obj.position' + [0 2]]; 
            %patch('Faces', 1:3, 'Vertices', v, 'FaceColor', 'red')
        end
    end
    
end

