% CSE 494 - Interactive Robotics:
% This demo depicts the 'seek' steering behavior
% The agent will move in a straight line to the goal

% create the simulator object
sim = SteeringSimulator();

% seed the random number generator
rng(42)

%% create a target and ask for position of target
targ = seat();
%{
targ1 = seat();
targ2 = seat();
targ3 = Target();
targ4 = Target();
targ5 = Target();
targ6 = Target();
targ7 = Target();
targ8 = Target();
targ9 = Target();
targ10 = Target();
targ11 = Target();
targ12 = Target();
targ13 = Target();
targ14 = Target();
targ15 = Target();
targ16 = Target();
targ17 = Target();
targ18 = Target();
targ19 = Target();
targ20 = Target();
targ21 = Target();
targ22 = Target();
targ23 = Target();
targ24 = Target();
targ25 = Target();
targ26 = Target();
targ27 = Target();
targ28 = Target();
targ29 = Target();
targ30 = Target();
%}


targ.radius = 1;
%{
targ1.radius = 1;
targ2.radius = 1;
targ3.radius = 1;
targ4.radius = 1;
targ5.radius = 1;
targ6.radius = 1;
targ7.radius = 1;
targ8.radius = 1;
targ9.radius = 1;
targ10.radius = 1;
targ11.radius = 1;
targ12.radius = 1;
targ13.radius = 1;
targ14.radius = 1;
targ15.radius = 1;
targ16.radius = 1;
targ17.radius = 1;
targ18.radius = 1;
targ19.radius = 1;
targ20.radius = 1;
targ21.radius = 1;
targ22.radius = 1;
targ23.radius = 1;
targ24.radius = 1;
targ25.radius = 1;
targ26.radius = 1;
targ27.radius = 1;
targ28.radius = 1;
targ29.radius = 1;
targ30.radius = 1;
%}


targ.position = [5;5];
%{
targ1.position = [10;5];
targ2.position = [15;5];
targ3.position = [20;5];
targ4.position = [25;5];
targ5.position = [30;5];
targ6.position = [35;5];
targ7.position = [40;5];
targ8.position = [45;5];
targ9.position = [50;5];
targ10.position = [10;15];
targ11.position = [15;15];
targ12.position = [20;15];
targ13.position = [25;15];
targ14.position = [30;15];
targ15.position = [35;15];
targ16.position = [40;15];
targ17.position = [45;15];
targ18.position = [50;15];
targ19.position = [20;15];
targ20.position = [20;15];
targ21.position = [20;20];
targ22.position = [20;20];
targ23.position = [20;20];
targ24.position = [20;20];
targ25.position = [20;20];
targ26.position = [20;20];
targ27.position = [20;20];
targ28.position = [20;20];
targ29.position = [20;20];
targ30.position = [20;20];
%}



sim = sim.registerObject(targ);
%{
sim = sim.registerObject(targ1);
sim = sim.registerObject(targ2);
sim = sim.registerObject(targ3);
sim = sim.registerObject(targ4);
sim = sim.registerObject(targ5);
sim = sim.registerObject(targ6);
sim = sim.registerObject(targ7);
sim = sim.registerObject(targ8);
sim = sim.registerObject(targ9);
sim = sim.registerObject(targ10);
sim = sim.registerObject(targ11);
sim = sim.registerObject(targ12);
sim = sim.registerObject(targ13);
sim = sim.registerObject(targ14);
sim = sim.registerObject(targ15);
sim = sim.registerObject(targ16);
sim = sim.registerObject(targ17);
sim = sim.registerObject(targ18);
sim = sim.registerObject(targ19);
sim = sim.registerObject(targ20);
sim = sim.registerObject(targ21);
sim = sim.registerObject(targ22);
sim = sim.registerObject(targ23);
sim = sim.registerObject(targ24);
sim = sim.registerObject(targ25);
sim = sim.registerObject(targ26);
sim = sim.registerObject(targ27);
sim = sim.registerObject(targ28);
sim = sim.registerObject(targ29);
sim = sim.registerObject(targ30);
%}

sim.visualize();
% remove prompt
title(' ');

%% run simulation for a 1000x steps
for i = 1:1000

    % sim.visualize();
    pause(0.05)
    sim= sim.simulateNextStep();
    sim.visualize()
end

close