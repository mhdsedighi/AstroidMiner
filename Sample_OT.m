% MAIN - Pendulum
%
% Demonstrates simple swing-up for a single pendulum with a torque motor.
%

clc; clear;
addpath OptimTraj

% Physical parameters of the pendulum
p.k = 1;  % Normalized gravity constant
p.c = 0.1;  % Normalized damping constant

% User-defined dynamics and objective functions
problem.func.dynamics = @(t,x,u)( dynamics(x,u,p) );
problem.func.pathObj = @(t,x,u)( u.^2 );

% Problem bounds
problem.bounds.initialTime.low = 0;
problem.bounds.initialTime.upp = 0;
problem.bounds.finalTime.low = 0.5;
problem.bounds.finalTime.upp = 2.5;

problem.bounds.state.low = [-2*pi; -inf];
problem.bounds.state.upp = [2*pi; inf];
problem.bounds.initialState.low = [0;0];
problem.bounds.initialState.upp = problem.bounds.initialState.low;
problem.bounds.finalState.low = [pi;0];
problem.bounds.finalState.upp = problem.bounds.finalState.low;

problem.bounds.control.low = -5; %-inf;
problem.bounds.control.upp = 5; %inf;

% Guess at the initial trajectory
problem.guess.time = [0,(problem.bounds.finalTime.low+problem.bounds.finalTime.upp)/2];
problem.guess.state = [problem.bounds.initialState.low problem.bounds.finalState.low];
problem.guess.control = [0, 0];

% Select a solver:
problem.options.method = 'trapezoid';
problem.options.defaultAccuracy = 'medium';

% Solve the problem
soln = optimTraj(problem);
t = soln.grid.time;
q = soln.grid.state(1,:);
dq = soln.grid.state(2,:);
u = soln.grid.control;

% Plot the solution:
figure(1); clf;

subplot(3,1,1)
plot(t,q)
ylabel('q')
title('Single Pendulum Swing-Up');

subplot(3,1,2)
plot(t,dq)
ylabel('dq')

subplot(3,1,3)
plot(t,u)
ylabel('u')


