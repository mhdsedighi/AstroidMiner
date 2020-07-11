clc; clear; close all
addpath OptimTraj
addpath chebfun

%parameters
p.mu = 3.986005*10^5;
Re=6378.14;

%%%%%%%%%%%%%%%%%%%

a_0=30*Re;
e_0=0.7;
incl_0=0;
omega_0=0;
RA_0=0;
theta_0=deg2rad(180);

a_f=10*Re;
e_f=0;
incl_f=deg2rad(0);
omega_f=0;
RA_f=0;

min_revolution=1;
max_revolution=20;


mee_0=oe2mee([a_0 e_0 incl_0 omega_0 RA_0 theta_0],p.mu)';
mee_f=oe2mee([a_f e_f incl_f omega_f RA_f theta_0],p.mu)';

low_bound=[5*Re -inf -inf -inf -inf -inf];
upp_bound=[20*Re 1 1 1 1 pi];

F_max=1e-1;




%%%%%%%%%%%%%%%%%%%%%

% User-defined dynamics and objective functions
problem.func.dynamics = @(t,x,u)( dynamics(x,u,p) );
problem.func.pathObj = @(t,x,u)( u(1,:).^2 );

% Problem bounds
problem.bounds.initialTime.low = 0;
problem.bounds.initialTime.upp = 0;
problem.bounds.finalTime.low = 1000;
problem.bounds.finalTime.upp = 10000000;

problem.bounds.state.low = low_bound';
% problem.bounds.state.upp = upp_bound';
problem.bounds.initialState.low = mee_0;
problem.bounds.initialState.upp = problem.bounds.initialState.low;
% 
% problem.bounds.initialState.low(end)=0;
% problem.bounds.initialState.upp(end)=2*pi;

mee_f(end)=mee_0(end)+min_revolution*2*pi;
problem.bounds.finalState.low = mee_f;
mee_f(end)=mee_f(end)+max_revolution*2*pi;
problem.bounds.finalState.upp = mee_f;

problem.bounds.control.low = [-F_max;-pi;-pi] ;
problem.bounds.control.upp = [F_max;pi;pi];

% Guess at the initial trajectory
problem.guess.time = [0,(problem.bounds.finalTime.low+problem.bounds.finalTime.upp)/2];
problem.guess.state = [problem.bounds.initialState.low problem.bounds.finalState.low];
problem.guess.control = [0 0;0 0;0 0];

% Select a solver:
% problem.options.method = 'rungeKutta';
problem.options.method = 'chebyshev';
% problem.options.method = 'trapezoid';

problem.options.defaultAccuracy = 'low';

% problem.options.rungeKutta.nSegment=40;
% problem.options.trapezoid.nGrid=200;

problem.options.nlpOpt.MaxFunEvals=1e5;
% problem.options.nlpOpt.MaxIter=1e5;

problem.options.chebyshev.nColPts=100;


% Solve the problem
soln = optimTraj(problem);
T = soln.grid.time;
U = soln.grid.control;


N=length(T);
R=zeros(3,N);
V=zeros(3,N);

for i=1:N
    
    [r,v]=mee2rv(soln.grid.state(:,i)',p.mu);
    R(:,i)=r;
    V(:,i)=v;
    
end

Force_history=[U(1,:).*cos(U(2,:)).*sin(U(3,:)) ;U(1,:).*cos(U(2,:)).*cos(U(3,:)) ; U(1,:).*sin(U(2,:))  ];

plotting


% 
%     'Algorithm','interior-point', ...
%     'AlwaysHonorConstraints','bounds', ...
%     'DerivativeCheck','off', ...
%     'Diagnostics','off', ...
%     'DiffMaxChange',Inf, ...
%     'DiffMinChange',0, ...
%     'Display','final', ...
%     'FinDiffRelStep', [], ...
%     'FinDiffType','forward', ...
%     'ProblemdefOptions', struct, ...
%     'FunValCheck','off', ...
%     'GradConstr','off', ...
%     'GradObj','off', ...
%     'HessFcn',[], ...
%     'Hessian',[], ...    
%     'HessMult',[], ...
%     'HessPattern','sparse(ones(numberOfVariables))', ...
%     'InitBarrierParam',0.1, ...
%     'InitTrustRegionRadius','sqrt(numberOfVariables)', ...
%     'MaxFunEvals',[], ...
%     'MaxIter',[], ...
%     'MaxPCGIter',[], ...
%     'MaxProjCGIter','2*(numberOfVariables-numberOfEqualities)', ...    
%     'MaxSQPIter','10*max(numberOfVariables,numberOfInequalities+numberOfBounds)', ...
%     'ObjectiveLimit',-1e20, ...
%     'OutputFcn',[], ...
%     'PlotFcns',[], ...
%     'PrecondBandWidth',0, ...
%     'RelLineSrchBnd',[], ...
%     'RelLineSrchBndDuration',1, ...
%     'ScaleProblem','none', ...
%     'SubproblemAlgorithm','ldl-factorization', ...
%     'TolCon',1e-6, ...
%     'TolConSQP',1e-6, ...    
%     'TolFun',1e-6, ...
%     'TolFunValue',1e-6, ...
%     'TolPCG',0.1, ...
%     'TolProjCG',1e-2, ...
%     'TolProjCGAbs',1e-10, ...
%     'TolX',[], ...
%     'TypicalX','ones(numberOfVariables,1)', ...
%     'UseParallel',false ...

