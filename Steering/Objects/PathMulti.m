classdef PathMulti < Object
    %PATHMULTI Path having multiple linear segments
    %   The path includes a radius as well as an nx2 matrix containing
    %   points, where n is the number of points in the path and (n-1)
    %   is the number of segments
    
    properties
        ptmtx     % nx2 matrix of points (n = # of points)
    end
    
    methods
        
        function obj = PathMulti()
            %  initial values
            obj.ptmtx = [1 1; 2 2];
            obj.radius = 1;
            obj.type = 'Path';
            obj.color = 'magenta';
        end
        
        function visualize(obj)
            % find the number of points in segment
            [m,n] = size(obj.ptmtx);
            num_segments = m-1;
            % loop through the segments
            for i=1:num_segments
                
                % find start and end points of segment
                segstartpt = obj.ptmtx(i,1:2)';
                segendpt = obj.ptmtx(i+1,1:2)';
                
                % find the angle above horizontal for segment
                segvec = segendpt - segstartpt;
                theta = atan( segvec(2,1) / segvec(1,1) );
                if (segvec(1,1) == 0)
                    theta = pi/2;
                end
                
                % draw the upper half path region
                pt3 = [0;0];
                pt3(1,1) = segendpt(1,1) - obj.radius * sin(theta);
                pt3(2,1) = segendpt(2,1) + obj.radius * cos(theta);
                pt4 = [0;0];
                pt4(1,1) = segstartpt(1,1) - obj.radius * sin(theta);
                pt4(2,1) = segstartpt(2,1) + obj.radius * cos(theta);
                
                v = [segstartpt'; segendpt'; pt3'; pt4'];
                patch('Faces', 1:4, 'Vertices', v, 'FaceColor', obj.color, 'FaceAlpha', 0.3)
                
                % draw the lower half path region
                pt5 = [0;0];
                pt5(1,1) = segendpt(1,1) + obj.radius * sin(theta);
                pt5(2,1) = segendpt(2,1) - obj.radius * cos(theta);
                pt6 = [0;0];
                pt6(1,1) = segstartpt(1,1) + obj.radius * sin(theta);
                pt6(2,1) = segstartpt(2,1) - obj.radius * cos(theta);
                
                v = [segstartpt'; segendpt'; pt5'; pt6'];
                patch('Faces', 1:4, 'Vertices', v, 'FaceColor', obj.color, 'FaceAlpha', 0.3)
                
                % color in the path between segments
                v = [];
                rad = obj.radius;
                for j=0:pi/10:2*pi
                    v = [v; segendpt(1,1)+rad*sin(j), segendpt(2,1)+rad*cos(j)];
                end
                patch('Faces', 1:21, 'Vertices', v, 'FaceColor', obj.color, 'FaceAlpha', 0.3)
                
            end
            
        end
    end
    
end

