clc
clear

%parameters
% params.mu = 3.986005*10^5;
% params.mu = 1.32712440018 *10^11;
% 
% params.mass=450e9; %kg
% params.R=435; %meters 
% 
% 
% Ixx=0.4*params.mass*params.R^2;
% Iyy=0.9*Ixx;
% Izz=0.8*Ixx;
% Ixy=0.2*Ixx;
% Ixz=0.2*Ixx;
% Iyz=0.2*Ixx;
% 
% params.Inertia =[Ixx -Ixy -Ixz;-Ixy Iyy -Iyz;-Ixz -Iyz Izz];
% params.inv_Inertia=inv(params.Inertia);
% 
% 
% 
% 
% %%%%ellipsoid approximation
% 
% 
% params.a=2*435;
% params.b=0.7*params.a;
% params.c=0.4*params.a;


load shape




params.mu = 1.32712440018 *10^11;



%%%%ellipsoid approximation

params.a=4.5;
params.b=3.45;
params.c=1.5;

% % % params.mass=169581; %kg
% params.R=435; %meters 

% density=2000;
density=1.27e3;
params.mass=shape.volume*density;

% rho=1.7385e+03;

% Ixx=480e3;
% Iyy=763116;
% Izz=1090492;
% Ixy=0;
% Ixz=0;
% Iyz=0;
% params.Inertia =[Ixx -Ixy -Ixz;-Ixy Iyy -Iyz;-Ixz -Iyz Izz];

params.Inertia=params.mass*shape.MomentTensor;

params.inv_Inertia=inv(params.Inertia);








save params params