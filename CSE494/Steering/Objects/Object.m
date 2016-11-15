classdef Object
    %OBJECT The general Object class. All Agents and Walls are derived from
    %this class
    
    properties
        position    % Position
        radius      % Radius of the bounding box
        ID          % Unique IDE
        type        % object type (wall, agent, etc.)
        color       % color of object
        boxBottomLeft
        boxTopLeft          %these provide boundaries of where the walls of the seats are
        boxTopRight
        boxBottomRight
    end
    
    methods
        
        function obj = Object()
            %Generate a random number - we might run into trouble with this
            %with too many agents...
            obj.ID = randi(10000000000000,1);
        end
        
        function b = equal(obj, object)
            b = obj.ID == object.ID;
        end
        function ref = visualize(obj)
            ref = [];
        end
        
        function coll = collission(obj, anotherObj)
            coll = false;
        end
        
        function [pos, rad] = getCircShape(obj)
            
            pos = [0;0];
            rad = 0;
            
        end
        
        function obj = nextStep(obj,objectlist)
            
        end
        
        function obj = setType(obj,type)
            obj.type = type;
        end
        
        function obj = setColor(obj, color)
            obj.color = color;
        end
        
    end
    
end

