% CSE 494 - Interactive Robotics:


% create the simulator object
sim = SteeringSimulator();

%%
% For adding targets

s = char(97:122); % Or just use: s = 'abcdefghijklmnopqrstuvwxyz';
rows=3;


% we'll need to say that the agent cannot pass through the coordinates of
% topleft corner and top right corner
% cannot pass through topright corner and bottom right cornerr
%cannot pass through top left corner and bottom left corner
%may only pass through the coordinates of bottom left and bottom right
%corner

for i=1:rows
    for j=1:3
  
        chair=seat();
        chair.seatNum=j;
        chair.row=[s(i)];
        chair.radius=1;                     %Is this right?
        chair.position=[(5*i);(9.5*j)];
        wall = WallRound();
        wall.position=chair.position;
        sim = sim.registerObject(wall);
        sim = sim.registerObject(chair);
        sim = sim.registerSeat(chair);    %Add the seat to the list
        rAgent=AgentArrive();
        rAgent.position=[30*i;40*j];

        sim = sim.registerObject(rAgent);
  
    end 
end


sim.visualize();

%% run simulation for a 1000x steps
for i = 1:1000

    % sim.visualize();
    pause(0.1)
    sim= sim.simulateNextStep();
    sim.visualize()
end

close