% CSE 494 - Interactive Robotics:
% This demo depicts the 'seek' steering behavior
% The agent will move in a straight line to the goal

% create the simulator object
sim = SteeringSimulator();

%%
% For adding targets

s = char(97:122); % Or just use: s = 'abcdefghijklmnopqrstuvwxyz';
rows=7;


for i=1:rows
    for j=1:7
        chair=seat();
        chair.seatNum=j;
        chair.row=[s(i)];
        chair.radius=1;                     %Is this right?
        chair.position=[(9.5*i);(9.5*j)];
        wall = WallRound(chair);
        sim = sim.registerObject(wall);
        sim = sim.registerSeat(chair);    %Add the seat to the list
        
  
    end 
end


sim.visualize();

%% run simulation for a 1000x steps
for i = 1:1000

    % sim.visualize();
    pause(0.05)
    sim= sim.simulateNextStep();
    sim.visualize()
end

close