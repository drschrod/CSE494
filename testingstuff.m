% CSE 494 - Interactive Robotics:


% create the simulator object
sim = SteeringSimulator();

%%
% For adding targets

s = char(97:122); % Or just use: s = 'abcdefghijklmnopqrstuvwxyz';
rows=3;     %Total number of rows
sPr=3;      %sPr
count=1;
totalSeats=sPr*rows;
array=zeros(2,totalSeats);
numOfAgents=round(rand(1)*totalSeats);
% we'll need to say that the agent cannot pass through the coordinates of
% topleft corner and top right corner
% cannot pass through topright corner and bottom right cornerr
%cannot pass through top left corner and bottom left corner
%may only pass through the coordinates of bottom left and bottom right
%corner
hold on
for i=1:rows
    for j=1:sPr
        chair=seat();
        chair.seatNum=j;
        chair.row=[s(i)];
        chair.radius=1;                     
        chair.position=[(5*i);(9.5*j)];
        wall = WallRound();
        wall.position=chair.position;
        array(1,count)=chair.position(1,:);
        array(2,count)=chair.position(2,:);
        sim = sim.registerObject(wall);
        sim = sim.registerObject(chair);
        sim = sim.registerSeat(chair);    %Add the seat to the list
        %chair.visualize();
        %wall.visualize();
        %pause(0.1);                %Debug pausing to view visualization
        count=count+1;
    end 
end
hold off
count=1;
for i=1:numOfAgents
    rAgent=AgentAvoid();
    %rAgent=AgentForAvoiding();
    rAgent.position=[35;40];
    rAgent.targetX=array(1,count);
    rAgent.targetY=array(2,count);
    sim = sim.registerObject(rAgent);
    count=count+1;
end
sim.visualize();

%% run simulation for a 1000x steps
for i = 1:1000

    % sim.visualize();
    pause(0.001)
    sim= sim.simulateNextStep();
    sim.visualize()
end

close