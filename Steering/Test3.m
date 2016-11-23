%
%
%
% create the simulator object
sim = SteeringSimulator();

% seed the random number generator
rng(42)

% MES: place Arrival/Flee Agent for testing
for i = 1:1
    rAgent = AgentArrFlee();
    % prompt user
    title('Use Mouse to Select Initial Location of Agent');
    [x,y] = ginput(1);
    rAgent.position = [x;y];
    rAgent.slowcircle = 15;
    sim = sim.registerObject(rAgent);
    sim.visualize();
    % remove prompt
    title(' ');
end

% MES: place target for testing Arrival Agent
targ1 = Target();
% prompt user
title('Use Mouse to Select Point for Arrival Target');
[x,y] = ginput(1);
targ1.position = [x;y];
targ1.radius = 1;
targ1.color = 'g';
sim = sim.registerObject(targ1);
sim.visualize();
% remove prompt
title(' ');

%
% Add a target for the agent to flee
targ2 = Target();
% prompt user
title('Use Mouse to Select Point for Agent to Flee');
[x,y] = ginput(1);
targ2.position = [x;y];
targ2.radius = 1;
targ2.color = 'r';
targ2.type = 'TargetF';
sim = sim.registerObject(targ2);
sim.visualize();
% remove prompt
title(' ');
%
%

%
% MES:  start simulating, continue for 1000 time steps
for i = 1:1000
    % sim.visualize();
    pause(0.01)
    sim= sim.simulateNextStep();
    i
    sim.visualize();
end

close