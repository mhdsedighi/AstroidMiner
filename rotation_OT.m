clc; clear; close all
addpath OptimTraj
addpath chebfun
load('params')

%parameters
p.mu = 3.986005*10^5;
Re=6378.14;

%%%%%%%%%%%%%%%%%%%

% a_0=30*Re;
% e_0=0.7;
% incl_0=0;
% omega_0=0;
% RA_0=0;
% theta_0=deg2rad(180);
% 
% a_f=10*Re;
% e_f=0;
% incl_f=deg2rad(0);
% omega_f=0;
% RA_f=0;

% min_revolution=1;
% max_revolution=20;

quat_0=eul2quat(deg2rad([0 0 0]));
quat_f=eul2quat(deg2rad([0 0 0]));

pqr_0=[0;0;1;quat_0'];
pqr_f=[0;0;0;quat_f'];

% low_bound=[5*Re -inf -inf -inf -inf -inf];
% upp_bound=[20*Re 1 1 1 1 pi];

torque_max=10;




%%%%%%%%%%%%%%%%%%%%%

% User-defined dynamics and objective functions
problem.func.dynamics = @(t,x,u)( rotation_dynamics(x,u,p) );
problem.func.pathObj = @(t,x,u)( dot(u,u) );

% Problem bounds
problem.bounds.initialTime.low = 0;
problem.bounds.initialTime.upp = 0;
problem.bounds.finalTime.low = 100;
problem.bounds.finalTime.upp = 1000;

% problem.bounds.state.low = low_bound';
% problem.bounds.state.upp = upp_bound';
problem.bounds.initialState.low = pqr_0;
problem.bounds.initialState.upp = problem.bounds.initialState.low;
% 
% problem.bounds.initialState.low(end)=0;
% problem.bounds.initialState.upp(end)=2*pi;


problem.bounds.finalState.low = pqr_f;
problem.bounds.finalState.upp = pqr_f;


problem.bounds.control.low = 0*ones(p.N_sat,1);
problem.bounds.control.upp = torque_max*ones(p.N_sat,1);

% Guess at the initial trajectory
problem.guess.time = [0,(problem.bounds.finalTime.low+problem.bounds.finalTime.upp)/2];
problem.guess.state = [problem.bounds.initialState.low problem.bounds.finalState.low];
problem.guess.control = zeros(p.N_sat,2);


pqr_f(4:7)=-inf;
problem.bounds.finalState.low = pqr_f;
pqr_f(4:7)=inf;
problem.bounds.finalState.upp = pqr_f;

% Select a solver:
% problem.options.method = 'rungeKutta';
problem.options.method = 'chebyshev';
% problem.options.method = 'trapezoid';
% problem.options.method = 'multiCheb';

problem.options.defaultAccuracy = 'medium';

% problem.options.rungeKutta.nSegment=100;
% problem.options.trapezoid.nGrid=200;

% problem.options.nlpOpt.MaxFunEvals=1e5;
% problem.options.nlpOpt.MaxIter=1e5;

problem.options.chebyshev.nColPts=30;

% problem.options.multiCheb.nColPts=30;


% Solve the problem
soln = optimTraj(problem);
T = soln.grid.time;
U = soln.grid.control;


N=length(T);
% R=zeros(3,N);
% V=zeros(3,N);
% 
% for i=1:N
%     
%     [r,v]=mee2rv(soln.grid.state(:,i)',p.mu);
%     R(:,i)=r;
%     V(:,i)=v;
%     
% end
% 
% Force_history=[U(1,:).*cos(U(2,:)).*sin(U(3,:)) ;U(1,:).*cos(U(2,:)).*cos(U(3,:)) ; U(1,:).*sin(U(2,:))  ];
% 
plotting_rot
