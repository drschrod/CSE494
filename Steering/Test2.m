%
%
%
% create the simulator object
sim = SteeringSimulator();

% seed the random number generator
rng(42)

% MES:  testing the wander steering agent "AgentWander"
for i = 1:1
    rAgent = AgentWander();
    % prompt user
    title('Use Mouse to Select Initial Location of Agent');
    [x,y] = ginput(1);
    rAgent.position = [x;y];
    sim = sim.registerObject(rAgent);
    sim.visualize();
    % remove prompt
    title(' ');
end

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