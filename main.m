clc; clear; close all
addpath OptimTraj
addpath chebfun


params.lag1=0.12;
params.lag2=0.142;

params.mode=1;
% params.mode=2;

%%%%%%%%%%%%%%%%%%%%%

% User-defined dynamics and objective functions
problem.func.dynamics = @(t,x,u)( company_dynamics(t,x,u,params) );
problem.func.pathObj = @(t,x,u)( cost(t,x,u));

% Problem bounds
problem.bounds.initialTime.low = 0;
problem.bounds.initialTime.upp = 0;
problem.bounds.finalTime.low = 200;
problem.bounds.finalTime.upp = 200;

problem.bounds.state.low = [0]';
problem.bounds.state.upp = [100]';
problem.bounds.initialState.low = 0;
problem.bounds.initialState.upp = 0;
%
% problem.bounds.initialState.low(end)=0;
% problem.bounds.initialState.upp(end)=2*pi;


% problem.bounds.finalState.low = state_f;
% problem.bounds.finalState.upp = state_f;


% Guess at the initial trajectory
problem.guess.time = [0,150];
problem.guess.state = [10  10];
problem.guess.control = [10 10];


problem.bounds.control.low = 0;

if params.mode==1
    problem.bounds.control.upp = 12;
else
    problem.bounds.control.upp = 10;
end
    




problem.bounds.finalState.low = 0;
problem.bounds.finalState.upp = 0;


problem.options.defaultAccuracy = 'medium';

% problem.options.rungeKutta.nSegment=100;
% problem.options.trapezoid.nGrid=200;

problem.options.nlpOpt.MaxFunEvals=1e6;
problem.options.nlpOpt.MaxIter=1e5;

step=0;
step=step+1;
problem.options(step).method = 'chebyshev';
problem.options(step).chebyshev.nColPts =50;
problem.options(step).defaultAccuracy = 'high';
%         problem.options.nlpOpt.TolFun=1e-15;
%         problem.options.nlpOpt.TolCon=1e-15;
%                         problem.options(step).nlpOpt.MaxFunEvals=1e6;
problem.options.nlpOpt.MaxIter=500;



% Solve the problem
soln = optimTraj(problem);
T = soln(end).grid.time;
U = soln(end).grid.control;
x=soln(end).grid.state(1,:);
T2=linspace(0,200,500);
N2=length(T2);
y_exact=zeros(1,N2);


N=length(T);
y=zeros(1,N);
residual=zeros(1,N);

for i=1:N
    
    if T(i)>20 && T(i)<50
        
        y(i)=14;
    elseif T(i)>100 && T(i)<110
        
        y(i)=20;
        
    else
        y(i)=5;
    end
    
    
end

for i=1:N2
    
    if T2(i)>20 && T2(i)<50
        
        y_exact(i)=14;
    elseif T2(i)>100 && T2(i)<110
        
        y_exact(i)=20;
        
    else
        y_exact(i)=5;
    end
    
    
end
residual(1)=0;
for i=2:N
    
    residual(i)=trapz(T(1:i),x(1:i))-trapz(T(1:i),y(1:i));
    
    
end


%
figure


subplot(3,1,1)
hold on
grid minor
ylabel('Production Input')
plot(T,soln(end).grid.control(1,:))
plot(T,soln(end).grid.control(1,:),'k.')


subplot(3,1,2)
hold on
grid minor
plot(T,soln(end).grid.state(1,:))
plot(T2,y_exact)
plot(T,soln(end).grid.state(1,:),'k.')
ll=legend('Production Output','Demand');
% ll.String(3)='';
% plot(T2,y_exact,'r.')
% plot(T,soln(end).grid.state(1,:),'k.')

subplot(3,1,3)
hold on
grid minor
ylabel('Repository')
xlabel('Time (days)')
plot(T,residual)
plot(T,residual,'k.')



minimum_time_span=min(diff(T))