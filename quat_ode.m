clc; clear; close all
% load('params')

global pqr_history T_rot_history

load solve_rot

pqr_history=soln(end).grid.state(1:3,:)';
T_rot_history=soln(end).grid.time;


load solve_path

T_path_history=soln(end).grid.time;

T_rot_history=[T_rot_history T_path_history(end)];
pqr_history=[pqr_history ; pqr_history(end,:)];



quat_0=eul2quat(deg2rad([20 30 40]));

% %parameters
% params.mu = 3.986005*10^5;
% Re=6378.14;
% 
% params.Ixx=1000;
% params.Iyy=1000;
% params.Izz=1000;
% params.Ixy=0;
% params.Ixz=0;
% params.Iyz=0;

% a_0=100*Re;
% e_0=0;
% incl_0=deg2rad(0);
% omega_0=0;
% RA_0=0;
% theta_0=deg2rad(0);




% oe_f=oe_0;
% mee_f=mee_0;
% state_f=state_0;

tspan = [0 T(end)];
opts = odeset('MaxStep',100);
sol2 = ode45(@quat_dynamics,tspan,quat_0,opts);

N_time=length(sol2.x);
T2=sol2.x;
% soln.grid.state=zeros(13,N_time);
% soln.grid.state=sol.y;
% 
% U=zeros(params.N_sat,N_time);

plotting_ode_quat

save solve_quat

