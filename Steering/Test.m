sim = SteeringSimulator();

rng(42)
% MES:  test the collision avoidance agents "AgentAvoid"
%{
for i = 1:5
    rAgent = AgentAvoid();
    [x,y] = ginput(1);
    rAgent.position = [x;y];
    sim = sim.registerObject(rAgent);
    sim.visualize();
end
%}

% MES: test the agents that go fwd "AgentForward"
% MES:  both agents fly off at 45deg angle
%{
for i = 1:2
    rAgent = AgentForward();
    [x,y] = ginput(1);
    rAgent.position = [x;y];
    sim = sim.registerObject(rAgent);
    sim.visualize();
end
%}

% MES:  test the random steering agent "AgentRandom"
%{
for i = 1:2
    rAgent = AgentRandom();
    [x,y] = ginput(1);
    rAgent.position = [x;y];
    sim = sim.registerObject(rAgent);
    sim.visualize();
end
%}

% MES:  testing the wander steering agent "AgentWander"
%{
for i = 1:1
    rAgent = AgentWander();
    [x,y] = ginput(1);
    rAgent.position = [x;y];
    sim = sim.registerObject(rAgent);
    sim.visualize();
end
%}

% MES: testing for path following agent "AgentPathFollow"
%{
for i = 1:1
    rAgent = AgentPathFollow();
    [x,y] = ginput(1);
    rAgent.position = [x;y];
    sim = sim.registerObject(rAgent);
    sim.visualize();
end
%}

% MES: testing for path following agent "AgentPathFollowMulti"
%{
for i = 1:1
    rAgent = AgentPathFollowMulti();
    [x,y] = ginput(1);
    rAgent.position = [x;y];
    sim = sim.registerObject(rAgent);
    sim.visualize();
end
%}

% MES:  place points defining simple path to follow
%{
for i = 1:1
    path = PathSimple();
    [x,y] = ginput(1);
    path.startpt = [x;y];
    % show guides as path points are chosen
    ph = 0.5;
    v = [x-ph y+ph; x+ph y+ph; x+ph y-ph; x-ph y-ph];
    patch('Faces', 1:4, 'Vertices', v, 'FaceColor', 'm', 'FaceAlpha', 0.3)
    
    [x,y] = ginput(1);
    path.endpt = [x;y];
    path.radius = 2;
    sim = sim.registerObject(path);
    sim.visualize();
end
%}

% MES:  place five points defining multi-segment path to follow
%{
for i = 1:1
    % create path object
    path = PathMulti();

    %  add points to path
    path.ptmtx = [];
    for i = 1:5
        [x,y] = ginput(1);
        path.ptmtx = [path.ptmtx; x y];
        % show guides as path points are chosen
        ph = 0.5;
        v = [x-ph y+ph; x+ph y+ph; x+ph y-ph; x-ph y-ph];
        patch('Faces', 1:4, 'Vertices', v, 'FaceColor', 'm', 'FaceAlpha', 0.3)
    end

    % set path radius
    path.radius = 2;

    % register object with sim and display
    sim = sim.registerObject(path);
    sim.visualize();
end
%}

% MES:  allows user to place 10 obstacles to avoid
%{
for i = 1:10
    wall = WallRound();
    [x,y] = ginput(1);
    wall.position = [x;y];
    wall.radius = 2;
    sim = sim.registerObject(wall);
    sim.visualize();
end
%}

% MES: place target for testing Arrival/Seek/Flee Agent
%{
targ = Target();
[x,y] = ginput(1);
targ.position = [x;y];
targ.radius = 1;
targ.color = 'b';
sim = sim.registerObject(targ);
sim.visualize();
%}

% MES: place Arrival Agent for testing
%{
for i = 1:1
    rAgent = AgentArrive();
    [x,y] = ginput(1);
    rAgent.position = [x;y];
    rAgent.slowcircle = 25;
    sim = sim.registerObject(rAgent);
    sim.visualize();
end
%}

% MES: place Seek Agent for testing
%{
for i = 1:1
    rAgent = AgentSeek();
    [x,y] = ginput(1);
    rAgent.position = [x;y];
    sim = sim.registerObject(rAgent);
    sim.visualize();
end
%}

% MES: place Flee Agent for testing
%{
for i = 1:1
    rAgent = AgentFlee();
    [x,y] = ginput(1);
    rAgent.position = [x;y];
    sim = sim.registerObject(rAgent);
    sim.visualize();
end
%}

% added from Heni's code 8/24/16
% create exactly one ball
%{
rBall = Ball();
[x,y] = ginput(1);
rBall.position = [x;y];
rBall.radius = 0.7;
sim = sim.registerObject(rBall);
sim.visualize();
%}

%
% Combine multiple behaviors to create Demo
% This Demo Agent combines Multi-segment path following, Avoid, and
% Arrival

s = char(97:122); % Or just use: s = 'abcdefghijklmnopqrstuvwxyz';
rows=3;     %Total number of rows
sPr=3;      %sPr
count=1;
totalSeats=sPr*rows;
array=zeros(2,totalSeats);
numOfAgents=8;

% Add a target for the Demo agent to arrive at
for i = 1:rows
    for j = 1:sPr        
targ = Target();
targ.position= [(12*i);(10*j)];
targ.radius = 1;
targ.color = 'b';
array(1,count)=targ.position(1,:);
array(2,count)=targ.position(2,:);
sim = sim.registerObject(targ);
%sim.visualize();
% remove prompt
count = count+1;
    end
end

hold off
count=1;
countTotal = 5;
size = totalSeats;
for i = 1:1
    entrance = 1*rand(1,1);
    rAgent = AgentComboDemo();
    
  %  if(entrance < .50)
    rAgent.position=[50;50];
   % else 
    %    rAgent.position=[0;50];
   % end
    
     if(mod(count,2)==1)
    rAgent.targetPositionX=array(1,count);
    rAgent.targetPositionY=array(2,count);
    sim = sim.registerObject(rAgent);
    count=count+1;
    else 
     rAgent.targetPositionX=array(1,size);
    rAgent.targetPositionY=array(2,size);
    sim = sim.registerObject(rAgent);
    size = size -1;
    end
   
end

%
% Add a Multi-Segment path for the Demo agent to follow
% create path object
path = PathMulti();

%  add points to path
path.ptmtx = [];
for i = 1:9
    x=5;
    y=5;
    if(i==2)
        
    path.ptmtx = [path.ptmtx;  x y];
    y = 35;
    end
    
     if(i==3 )
       y = 35;
       x = 45;
    path.ptmtx = [path.ptmtx;  x y];
    
     end
    
       if(i==4 )
       y = 5;
       x =45;
    path.ptmtx = [path.ptmtx;  x y];
    
       end
    
         if(i==5 )
       y = 5;
       x =5;
    path.ptmtx = [path.ptmtx;  x y];
         end
         
         if(i==6 )
       y = 15;
       x =5;
    path.ptmtx = [path.ptmtx;  x y];
         end
    
          
         if(i==7 )
       y = 15;
       x =45;
    path.ptmtx = [path.ptmtx;  x y];
         end
         
            if(i==8 )
       y = 25;
       x =45;
    path.ptmtx = [path.ptmtx;  x y];
         end
    
          
         if(i==9 )
       y = 25;
       x =5;
    path.ptmtx = [path.ptmtx;  x y];
         end
         
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
%{
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
%}

%

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