
% A=[1 2 4;3 0 5];
% b=[3;4];
%
% x_b = lsqminnorm(A,b)

% params=[];
clc
clear

load solve3
quatS=sol2.y';
% fmS=[Force_command_xyz; Moment_command];
fmS=U';
% tS=T;
N_time=length(T2);

a=10;
b=8;
c=6;
params.a=a;
params.b=b;
params.c=c;


N_sat=20;

max_gamma=30;

% azimuths=[-45 45 180+45   180-45   90         90       0      0]
% elevations=[0 0    0         0     90+30      90-30    -90+30 -90-30]
% pitchs=zeros(1,N_sat);
% yaws=zeros(1,N_sat);

azimuths=rand_gen(1,N_sat,0,360);
elevations=rand_gen(1,N_sat,-90,90);
gammas=rand_gen(1,N_sat,0,30);
lambdas=rand_gen(1,N_sat,0,360);


x0=[azimuths elevations gammas lambdas];
LB=[zeros(1,N_sat) -90*ones(1,N_sat) zeros(1,2*N_sat)];
UB=[360*ones(1,N_sat) 90*ones(1,N_sat) max_gamma*ones(1,N_sat) 360*ones(1,N_sat)];


% params=rigid_positioning(N_sat,a,b,c,azimuths,elevations,gammas,lambdas);
% params.N_sat=N_sat;


cost=positioning_cost(x0,N_sat,N_time,T,T2,quatS,fmS,params)



x=x0;
azimuths=x(1:N_sat);
elevations=x(N_sat+1:2*N_sat);
gammas=x(2*N_sat+1:3*N_sat);
lambdas=x(3*N_sat+1:4*N_sat);
plot_sats

