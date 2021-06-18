clc
clear

%parameters
% params.mu = 3.986005*10^5;
params.mu = 1.32712440018 *10^11;

params.mass=450e9; %kg
params.R=435; %meters 


Ixx=0.4*params.mass*params.R^2;
Iyy=0.9*Ixx;
Izz=0.8*Ixx;
Ixy=0.2*Ixx;
Ixz=0.2*Ixx;
Iyz=0.2*Ixx;

params.Inertia =[Ixx -Ixy -Ixz;-Ixy Iyy -Iyz;-Ixz -Iyz Izz];
params.inv_Inertia=inv(params.Inertia);




%%%%ellipsoid approximation


params.a=2*435;
params.b=0.7*params.a;
params.c=0.4*params.a;





save params