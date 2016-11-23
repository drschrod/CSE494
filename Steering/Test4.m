%
%
%
% create the simulator object
sim = SteeringSimulator();

% seed random number generator
rng(42)

% MES: testing for path following agent "AgentPathFollow"
for i = 1:1
    rAgent = AgentPathFollow();
    % prompt user
    title('Use Mouse to Select Initial Location of Agent');
    [x,y] = ginput(1);
    rAgent.position = [x;y];
    sim = sim.registerObject(rAgent);
    sim.visualize();
    % remove prompt
    title(' ');
end

% MES:  place points defining simple path to follow
for i = 1:1
    path = PathSimple();
    % prompt user
    title('Use Mouse to Select Start of Simple Path');
    [x,y] = ginput(1);
    path.startpt = [x;y];
    % show guides as path points are chosen
    ph = 0.5;
    v = [x-ph y+ph; x+ph y+ph; x+ph y-ph; x-ph y-ph];
    patch('Faces', 1:4, 'Vertices', v, 'FaceColor', 'm', 'FaceAlpha', 0.3)
    
    % prompt user
    title('Use Mouse to Select End of Simple Path');
    [x,y] = ginput(1);
    path.endpt = [x;y];
    path.radius = 2;
    sim = sim.registerObject(path);
    sim.visualize();
    % remove prompt
    title(' ');
end

% added from Heni's code 8/24/16
% create exactly one ball
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