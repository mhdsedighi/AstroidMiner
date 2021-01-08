% % % 
% % % % A=[1 2 4;3 0 5];
% % % % b=[3;4];
% % % %
% % % % x_b = lsqminnorm(A,b)
% % % 
% % % % params=[];
clc
clear

load solve_path
T_path=T;

load solve_rot
Moment_command=U;
T_rot=T;

load solve_quat
% T_quats
% quats

model3d_maker

T_rot=[T_rot T_path(end)];
Moment_command=[Moment_command [0;0;0]]';


Force_history_xyz=Force_history_xyz';

% N=length(Force_history_xyz)-length(Moment_command);
%
% Moment_command=

% Moment_command

N_time=length(T_quats);
fms=zeros(6,N_time);
for i=1:N_time
    t=T_quats(i);
    
    this_quat=quats(:,i);
    this_moment=interp1(T_rot,Moment_command,t)';
    this_force=interp1(T_path,Force_history_xyz,t)';
    fms(:,i)=[this_force;this_moment];
    
end



% fmS=[Force_history_xyz; Moment_command];
% fmS=U';
% tS=T;
% N_time=length(T2);

N_sat=10;

a=20;
b=13;
c=8;
params.a=a;
params.b=b;
params.c=c;


% params.N_sat=10;

max_gamma=30;

% azimuths=[-45 45 180+45   180-45   90         90       0      0]
% elevations=[0 0    0         0     90+30      90-30    -90+30 -90-30]
% pitchs=zeros(1,N_sat);
% yaws=zeros(1,N_sat);

azimuths=rand_gen(1,N_sat,0,360);
elevations=rand_gen(1,N_sat,-90,90);
gammas=rand_gen(1,N_sat,-30,30);
lambdas=rand_gen(1,N_sat,0,180);


x0=[azimuths elevations gammas lambdas];
LB=[zeros(1,N_sat) -90*ones(1,N_sat) -max_gamma*ones(1,N_sat) zeros(1,N_sat)];
UB=[360*ones(1,N_sat) 90*ones(1,N_sat) max_gamma*ones(1,N_sat) 180*ones(1,N_sat)];


% params=rigid_positioning(N_sat,a,b,c,azimuths,elevations,gammas,lambdas);
% params.N_sat=N_sat;
fun=@(x)positioning_cost(x,N_sat,N_time,T_quats,quats,fms,params);
options = saoptimset;
% options.Display='Iter';
options.PlotFcns={@saplotbestf,@saplotbestx };
options.MaxIter=1e6;
[x_opt,cost_opt,exitflag,output] = simulannealbnd(fun,x0,LB,UB,options);


% cost=positioning_cost(x0,N_sat,N_time,T_quats,quats,fms,params)



x=x_opt;
azimuths=x(1:N_sat);
elevations=x(N_sat+1:2*N_sat);
gammas=x(2*N_sat+1:3*N_sat);
lambdas=x(3*N_sat+1:4*N_sat);
plot_sats

