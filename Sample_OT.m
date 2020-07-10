clc; clear; close all
addpath OptimTraj

%parameters
p.mu = 3.986005*10^5;
Re=6378.14;

%%%%%%%%%%%%%%%%%%%

a_0=15*Re;
e_0=0;
incl_0=0;
omega_0=0;
RA_0=0;
theta_0=0;

a_f=18*Re;
e_f=0;
incl_f=0;
omega_f=0;
RA_f=0;
theta_f=deg2rad(90);


mee_0=oe2mee([a_0 e_0 incl_0 omega_0 RA_0 theta_0],p.mu)';
mee_f=oe2mee([a_f e_f incl_f omega_f RA_f theta_f],p.mu)';


low_bound=[9*Re 0 0 0 0 0];
upp_bound=[20*Re pi pi pi pi 20*pi];

F_max=1e-6;




%%%%%%%%%%%%%%%%%%%%%

% User-defined dynamics and objective functions
problem.func.dynamics = @(t,x,u)( dynamics(x,u,p) );
problem.func.pathObj = @(t,x,u)( dot(u,u) );

% Problem bounds
problem.bounds.initialTime.low = 0;
problem.bounds.initialTime.upp = 0;
problem.bounds.finalTime.low = 10000;
problem.bounds.finalTime.upp = 1000000;

problem.bounds.state.low = low_bound';
% problem.bounds.state.upp = upp_bound';
problem.bounds.initialState.low = mee_0;
problem.bounds.initialState.upp = problem.bounds.initialState.low;
mee_f(end)=0;
problem.bounds.finalState.low = mee_f;
mee_f(end)=0;
problem.bounds.finalState.upp = mee_f;

problem.bounds.control.low = -F_max*ones(3,1) ;
problem.bounds.control.upp = F_max*ones(3,1);

% Guess at the initial trajectory
problem.guess.time = [0,(problem.bounds.finalTime.low+problem.bounds.finalTime.upp)/2];
problem.guess.state = [problem.bounds.initialState.low problem.bounds.finalState.low];
problem.guess.control = [0 0;0 0;0 0];

% Select a solver:
problem.options.method = 'trapezoid';
problem.options.defaultAccuracy = 'medium';

% Solve the problem
soln = optimTraj(problem);
T = soln.grid.time;
U = soln.grid.control;


N=length(T);
R=zeros(3,N);

for i=1:N
    
    [r,v]=mee2rv(soln.grid.state(:,i)',p.mu);
    oe=mee2oe(soln.grid.state(:,i)',p.mu);
    R(:,i)=r;
    OE(:,i)=oe';
    
end

figure
hold on
axis equal
grid minor
view(25,45)
plot3(0,0,0,'ro')
plot3(R(1,:),R(2,:),R(3,:),'b')
plot3(R(1,:),R(2,:),R(3,:),'k.')

figure
title('Controls')
subplot(3,1,1)
plot(T,U(1,:),'k.')
subplot(3,1,2)
plot(T,U(2,:),'k.')
subplot(3,1,3)
plot(T,U(3,:),'k.')





