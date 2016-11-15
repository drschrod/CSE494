classdef PathSimple < Object
    %PATHSIMPLE Just a simple path having a single linear segment
    %   The path includes start and end points, as well as a radius
    
    properties
        startpt   % starting point of the path
        endpt     % ending point of the path
    end
    
    methods
        
        function obj = PathSimple()
            obj.startpt = [1;1];
            obj.endpt = [5;3];
            obj.radius = 1;
            obj.type = 'Path';
            obj.color = 'magenta';
        end
        
        function visualize(obj)
            % find the angle above horizontal for segment
            segvec = obj.endpt - obj.startpt;
            theta = atan( segvec(2,1) / segvec(1,1) );
            if (segvec(1,1) == 0)
                theta = pi/2;
            end
            
            % draw the upper half path region
            pt3 = [0;0];
            pt3(1,1) = obj.endpt(1,1) - obj.radius * sin(theta);
            pt3(2,1) = obj.endpt(2,1) + obj.radius * cos(theta);
            pt4 = [0;0];
            pt4(1,1) = obj.startpt(1,1) - obj.radius * sin(theta);
            pt4(2,1) = obj.startpt(2,1) + obj.radius * cos(theta);
            
            v = [obj.startpt'; obj.endpt'; pt3'; pt4']; 
            patch('Faces', 1:4, 'Vertices', v, 'FaceColor', obj.color, 'FaceAlpha', 0.3)
            
            % draw the lower half path region
            pt5 = [0;0];
            pt5(1,1) = obj.endpt(1,1) + obj.radius * sin(theta);
            pt5(2,1) = obj.endpt(2,1) - obj.radius * cos(theta);
            pt6 = [0;0];
            pt6(1,1) = obj.startpt(1,1) + obj.radius * sin(theta);
            pt6(2,1) = obj.startpt(2,1) - obj.radius * cos(theta);
            
            v = [obj.startpt'; obj.endpt'; pt5'; pt6']; 
            patch('Faces', 1:4, 'Vertices', v, 'FaceColor', obj.color, 'FaceAlpha', 0.3)
            
        end
    end
    
end

