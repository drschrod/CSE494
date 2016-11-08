classdef SteeringSimulator
    %STEERINGSIMULATOR This class holds a simulation, including an X-Y plot
    %of objects and agents for demonstrating Reynolds' steering behaviors
    
    properties
        fig
        objectList
        seatList
        time
    end
    
    methods
        
        function obj=SteeringSimulator()
            obj.fig = figure('units','pixel','Resize','off','position',[50 50 600 500]);
            figure(obj.fig);
            xlim([0 100])
            ylim([0 100])
            
            obj.time = 0;
            
            obj.objectList = {};
        end
        
        function obj = registerObject(obj, object)
            obj.objectList{end + 1} = object;
        end
        
        %%
        %List that Stores the seats exclusively
        %Use this for when giving assigned seats and trying to find said
        %seat
        function obj = registerSeat(obj, object)
            obj.seatList{end + 1} = object;
        end
        %%
        function visualize(obj)
            figure(obj.fig)
            cla
            hold on
            for i=1:length(obj.objectList)
                object = obj.objectList{i};
                object.visualize();
            end
            %Added another for loop for the seatList
            %We should have separate lists for diff object types
            for i=1:length(obj.seatList)
                object = obj.seatList{i};
                object.visualize();
            end
            hold off
        end
        
        function obj = simulateNextStep(obj)
            oldObjectList = obj.objectList;
            for i=1:length(obj.objectList)
                object = obj.objectList{i};
                object = object.nextStep(oldObjectList);
                obj.objectList{i} = object;
            end
            obj.time = obj.time + 1;
        end
    end
    
end

