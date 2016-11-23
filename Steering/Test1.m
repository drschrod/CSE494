%
%
%
% create the simulator object
sim = SteeringSimulator();

% seed the random number generator
rng(42)

% MES: place Seek Agent for testing
for i = 1:1
    rAgent = AgentSeek();
    % prompt user
    title('Use Mouse to Select Initial Location of Agent');
    [x,y] = ginput(1);
    rAgent.position = [x;y];
    sim = sim.registerObject(rAgent);
    sim.visualize();
    % remove prompt
    title(' ');
end

% MES: place target for testing Arrival/Seek/Flee Agent
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