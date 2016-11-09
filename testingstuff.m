% CSE 494 - Interactive Robotics:
% This demo depicts the 'seek' steering behavior
% The agent will move in a straight line to the goal

% create the simulator object
sim = SteeringSimulator();

% seed the random number generator
rng(42)
targ = seat(); 
targ.radius = 1;
targ.position = [5;5];
wall = WallRound(targ);  % creating 
sim = sim.registerObject(targ);  
sim = sim.registerObject(wall);

%% create a target and ask for position of target
targ = seat();

targ.radius = 1;

targ.position = [5;5];

sim = sim.registerObject(targ);


sim.visualize();
title(' ');


%%
% For adding targets

s = char(97:122) % Or just use: s = 'abcdefghijklmnopqrstuvwxyz';
rows=7


for i=1:rows
    for j=1:10
        chair=seat();
        chair.seatNum=j;
        chair.row=[s(i)];
        chair.radius=1;                     %Is this right?
        chair.position=[(5*i);(5*j)];
        wall = WallRound(chair);
        sim = sim.registerObject(wall);
        sim = sim.registerSeat(chair);    %Add the seat to the list
        
        %seat=j;                            %Debugg
        %row=[s(i)];                        %Debug
        %fprintf('\nRow:%c',row)            %Debug
        %fprintf('\n Seat:%d\n\n',seat)     %Debugging statement
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