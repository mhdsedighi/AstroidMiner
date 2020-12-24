
% A=[1 2 4;3 0 5];
% b=[3;4];
% 
% x_b = lsqminnorm(A,b)

% params=[];
clc
clear

a=10;
b=14;
c=15;
N_sat=8;
azimuths=[-45 45 180+45   180-45   90         90       0      0]
elevations=[0 0    0         0     90+30      90-30    -90+30 -90-30]
pitchs=zeros(1,N_sat);
yaws=zeros(1,N_sat);


params=rigid_positioning(N_sat,a,b,c,azimuths,elevations,pitchs,yaws);

quat=eul2quat(deg2rad([20 0 40]));

[params]=control_mat(params,quat);

A=params.control_mat
b=[-10;1;1;2;4;5]

u_star = lsqminnorm(A,b)
A*u_star-b
u_star=lsqnonneg(A,b)
A*u_star-b




% pitch=0;
% yaw=0;
% V=[1 2 3];
% O=[3 4 6];
% [V_new]=rotate_about(V,O,pitch,yaw)