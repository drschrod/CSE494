%
%
%
% create the simulator object
sim = SteeringSimulator();

% seed the random number generator
rng(42)

%
% Combine multiple behaviors to create Demo
% This Demo Agent combines Multi-segment path following, Avoid, and
% Arrival
for i = 1:1
    rAgent = AgentComboDemo();
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
% Add a Multi-Segment path for the Demo agent to follow
% create path object
path = PathMulti();

%  add points to path
path.ptmtx = [];
for i = 1:5
    % prompt user to add a path point
    title('Use Mouse to Select Point for Path');
    [x,y] = ginput(1);
    path.ptmtx = [path.ptmtx; x y];
    % show guides as path points are chosen
    ph = 0.5;
    v = [x-ph y+ph; x+ph y+ph; x+ph y-ph; x-ph y-ph];
    patch('Faces', 1:4, 'Vertices', v, 'FaceColor', 'm', 'FaceAlpha', 0.3)
    % remove prompt
    title(' ');
end

% set path radius
path.radius = 2;

% register object with sim and display
sim = sim.registerObject(path);
sim.visualize();
%
%

%
% Add some obstacles for the Demo agent to avoid
for i = 1:5
    wall = WallRound();
    % prompt user
    title('Use Mouse to Select Point for Obstacle');
    [x,y] = ginput(1);
    wall.position = [x;y];
    wall.radius = 2;
    sim = sim.registerObject(wall);
    sim.visualize();
    % remove prompt
    title(' ');
end
%
%

%
% Add a target for the Demo agent to arrive at
targ = Target();
% prompt user
title('Use Mouse to Select Point for Arrival Target');
[x,y] = ginput(1);
targ.position = [x;y];
targ.radius = 1;
targ.color = 'b';
sim = sim.registerObject(targ);
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