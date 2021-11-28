% % % 
% % % % A=[1 2 4;3 0 5];
% % % % b=[3;4];
% % % %
% % % % x_b = lsqminnorm(A,b)
% % % 
% % % % params=[];
clc
clear

addpath('geom3d/geom3d')
addpath('geom3d/meshes3d')
addpath('3dmodels')

mass=450e9; %kg



load solve_path
T_path=T;

load solve_rot
Moment_command=U;
T_rot=T;

load solve_quat
% T_quats
% quats

% model3d_maker
load shape
params.shape=shape;
params.a=435*2;
params.b=435*2;
params.c=435*2;

T_rot=[T_rot T_path(end)];
Moment_command=[Moment_command [0;0;0]]';


Force_history_xyz=Force_history_xyz';


Force_history_xyz=Force_history_xyz*1000*mass;

% N=length(Force_history_xyz)-length(Moment_command);
%
% Moment_command=

% Moment_command

N_time=length(T_quats);
fms=zeros(6,N_time);
for i=1:N_time
    t=T_quats(i);
    
%     this_quat=quats(:,i);
    this_moment=interp1(T_rot,Moment_command,t)';
    this_force=interp1(T_path,Force_history_xyz,t)';
    fms(:,i)=[this_force;this_moment];
    
end



% fmS=[Force_history_xyz; Moment_command];
% fmS=U';
% tS=T;
% N_time=length(T2);

N_sat=20;




% params.N_sat=10;

max_alpha=30;

% lambdas=[-45 45 180+45   180-45   90         90       0      0]
% phis=[0 0    0         0     90+30      90-30    -90+30 -90-30]
% pitchs=zeros(1,N_sat);
% yaws=zeros(1,N_sat);

lambdas=rand_gen(1,N_sat,0,360);
phis=rand_gen(1,N_sat,-90,90);
alphas=rand_gen(1,N_sat,-30,30);
betas=rand_gen(1,N_sat,0,180);


x0=[lambdas phis alphas betas];
LB=[zeros(1,N_sat) -90*ones(1,N_sat) -max_alpha*ones(1,N_sat) zeros(1,N_sat)];
UB=[360*ones(1,N_sat) 90*ones(1,N_sat) max_alpha*ones(1,N_sat) 180*ones(1,N_sat)];


% params=rigid_positioning(N_sat,a,b,c,lambdas,phis,alphas,betas);
% params.N_sat=N_sat;
fun=@(x)positioning_cost(x,N_sat,N_time,T_quats,quats,fms,params);
options = saoptimset;
% options.Display='Iter';
options.PlotFcns={@saplotbestf,@saplotbestx };
options.MaxIter=1e6;
[x_opt,cost_opt,exitflag,output] = simulannealbnd(fun,x0,LB,UB,options);


% cost=positioning_cost(x0,N_sat,N_time,T_quats,quats,fms,params)



x=x_opt;
lambdas=x(1:N_sat);
phis=x(N_sat+1:2*N_sat);
alphas=x(2*N_sat+1:3*N_sat);
betas=x(3*N_sat+1:4*N_sat);
plot_sats

