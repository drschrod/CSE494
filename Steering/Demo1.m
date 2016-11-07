% CSE 494 - Interactive Robotics:
% This demo depicts the 'seek' steering behavior
% The agent will move in a straight line to the goal

% create the simulator object
sim = SteeringSimulator();

% seed the random number generator
rng(42)

%% create an agent and ask for position of agent
rAgent = AgentSeek();

% prompt user
title('Use Mouse to Select Initial Location of Agent');
[x,y] = ginput(1);
rAgent.position = [x;y];
sim = sim.registerObject(rAgent);
sim.visualize();
% remove prompt
title(' ');


%% create a target and ask for position of target
targ = Target();
% prompt user
title('Use Mouse to Select Location of Seek Target');
[x,y] = ginput(1);
targ.position = [x;y];
targ.radius = 1;
targ.color = 'b';
sim = sim.registerObject(targ);
sim.visualize();
% remove prompt
title(' ');

%% create a ball that can be touched
rBall = Ball();
% prompt user
title('Use Mouse to Select Initial Position of Ball');
[x,y] = ginput(1);
rBall.position = [x;y];
rBall.radius = 0.7;
sim = sim.registerObject(rBall);
sim.visualize();
% remove prompt
title(' ');

%% run simulation for a 1000x steps
for i = 1:1000
    % sim.visualize();
    pause(0.01)
    sim= sim.simulateNextStep();
    sim.visualize();
end

close