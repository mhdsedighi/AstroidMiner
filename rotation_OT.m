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

state_0=[3;3;0;quat_0'];
state_f=[0;0;0;quat_f'];

% low_bound=[5*Re -inf -inf -inf -inf -inf];
% upp_bound=[20*Re 1 1 1 1 pi];

thrust_max=10;




%%%%%%%%%%%%%%%%%%%%%

% User-defined dynamics and objective functions
problem.func.dynamics = @(t,x,u)( rotation_dynamics(x,u,p) );
problem.func.pathObj = @(t,x,u)( dot(u,u) );

% Problem bounds
problem.bounds.initialTime.low = 0;
problem.bounds.initialTime.upp = 0;
problem.bounds.finalTime.low = 100;
problem.bounds.finalTime.upp = 1e5;

% problem.bounds.state.low = low_bound';
% problem.bounds.state.upp = upp_bound';
problem.bounds.initialState.low = state_0;
problem.bounds.initialState.upp = problem.bounds.initialState.low;
% 
% problem.bounds.initialState.low(end)=0;
% problem.bounds.initialState.upp(end)=2*pi;


problem.bounds.finalState.low = state_f;
problem.bounds.finalState.upp = state_f;


problem.bounds.control.low = 0*ones(p.N_sat,1);
problem.bounds.control.upp = thrust_max*ones(p.N_sat,1);

% Guess at the initial trajectory
problem.guess.time = [0,(problem.bounds.finalTime.low+problem.bounds.finalTime.upp)/2];
problem.guess.state = [problem.bounds.initialState.low problem.bounds.finalState.low];
problem.guess.control = zeros(p.N_sat,2);


state_f(4:7)=-inf;
problem.bounds.finalState.low = state_f;
state_f(4:7)=inf;
problem.bounds.finalState.upp = state_f;

% Select a solver:
% problem.options.method = 'rungeKutta';
% problem.options.method = 'chebyshev';


% problem.options.method = 'trapezoid';
% problem.options.method = 'multiCheb';

problem.options.defaultAccuracy = 'medium';

% problem.options.rungeKutta.nSegment=100;
% problem.options.trapezoid.nGrid=200;

% problem.options.nlpOpt.MaxFunEvals=1e6;
% problem.options.nlpOpt.MaxIter=1e5;

% problem.options.chebyshev.nColPts=30;

% problem.options.multiCheb.nColPts=30;

method = 'trapezoid'; %  <-- this is robust, but less accurate
% method = 'direct'; %  <-- this is robust, but some numerical artifacts
% method = 'rungeKutta';  % <-- slow, gets a reasonable, but sub-optimal soln
% method = 'orthogonal';    %  <-- this usually finds bad local minimum
% method = 'gpops';      %  <-- fast, but numerical problem is maxTorque is large

switch method
    case 'direct'
        problem.options(1).method = 'trapezoid';
        problem.options(1).trapezoid.nGrid = 20;
        
        problem.options(2).method = 'trapezoid';
        problem.options(2).trapezoid.nGrid = 40;
        
        problem.options(3).method = 'hermiteSimpson';
        problem.options(3).hermiteSimpson.nSegment = 20;
        
    case 'trapezoid'
        problem.options(1).method = 'trapezoid';
        problem.options(1).trapezoid.nGrid = 30;
        problem.options(2).method = 'trapezoid';
        problem.options(2).trapezoid.nGrid = 40;
        problem.options(3).method = 'trapezoid';
        problem.options(3).trapezoid.nGrid = 60;
        
    case 'rungeKutta'
        problem.options(1).method = 'rungeKutta';
        problem.options(1).defaultAccuracy = 'low';
        
        problem.options(2).method = 'rungeKutta';
        problem.options(2).defaultAccuracy = 'medium';
        
    case 'orthogonal'
        problem.options(1).method = 'chebyshev';
        problem.options(1).chebyshev.nColPts = 40;
        
%         problem.options(2).method = 'chebyshev';
%         problem.options(2).chebyshev.nColPts = 100;
    case 'gpops'
        problem.options(1).method = 'gpops';
        
end


% Solve the problem
soln = optimTraj(problem);
T = soln(end).grid.time;
U = soln(end).grid.control;


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
