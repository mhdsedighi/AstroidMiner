clc; clear; close all
% load('params')

global pqr_rot_history T_rot_history

load solve_rot

pqr_rot_history=soln(end).grid.state(1:3,:)';
T_rot_history=soln(end).grid.time;

load solve_path

T_path_history=soln(end).grid.time;

% T_rot_history=[T_rot_history T_path_history(end)];
% pqr_history=[pqr_history ; pqr_history(end,:)];



quat_0=eul2quat(deg2rad([20 30 40]));
pqr_0=pqr_rot_history(end,:);

% %parameters
% params.mu = 3.986005*10^5;
% Re=6378.14;
% 
Ixx=1000;
Iyy=500;
Izz=600;
Ixy=0;
Ixz=0;
Iyz=0;

Inertia =[Ixx -Ixy -Ixz;-Ixy Iyy -Iyz;-Ixz -Iyz Izz];
inv_Inertia=inv(Inertia);


% a_0=100*Re;
% e_0=0;
% incl_0=deg2rad(0);
% omega_0=0;
% RA_0=0;
% theta_0=deg2rad(0);




% oe_f=oe_0;
% mee_f=mee_0;
% state_f=state_0;

% p_his=pqr_rot_history(:,1);
% q_his=pqr_rot_history(:,2);
% r_his=pqr_rot_history(:,3);

tspan = [0 T_rot_history(end)];
state_0=quat_0';
opts = odeset('MaxStep',10);
sol_a = ode45(@quat_dynamics,tspan,state_0,opts);


tspan = [T_rot_history(end) T_path_history(end)];
state_0=[pqr_rot_history(end,:)';sol_a.y(:,end)];
% state_0=[[0 0 0]';sol_a.y(:,end)];
opts = odeset('MaxStep',2000);
sol_b = ode45(@quat_dynamics2,tspan,state_0,opts,Inertia,inv_Inertia);

T_a=sol_a.x;
T_b=sol_b.x;
T_quats=[sol_a.x sol_b.x(2:end)];
quats=[sol_a.y(1:4,:) sol_b.y(4:7,2:end)];

pqrs_b=sol_b.y(1:3,:);
quats_a=sol_a.y(1:4,:);
quats_b=sol_b.y(4:7,:);


T_switch=pqr_rot_history(end,:);


% N_time=length(sol_a.x);
% T3=sol_a.x;


% soln.grid.state=zeros(13,N_time);
% soln.grid.state=sol.y;
% 
% U=zeros(params.N_sat,N_time);

plotting_ode_quat

save solve_quat

