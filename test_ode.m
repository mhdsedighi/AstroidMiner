clc; clear; close all
load('params')

global params

%parameters
params.mu = 3.986005*10^5;
Re=6378.14;

params.Ixx=1000;
params.Iyy=1000;
params.Izz=1000;
params.Ixy=0;
params.Ixz=0;
params.Iyz=0;

a_0=100*Re;
e_0=0;
incl_0=deg2rad(0);
omega_0=0;
RA_0=0;
theta_0=deg2rad(0);


oe_0=[a_0 e_0 incl_0 omega_0 RA_0 theta_0];
quat_0=eul2quat(deg2rad([20 30 40]));


mee_0=oe2mee(oe_0,params.mu)';
state_0=[1e-3;2e-3;5e-3;quat_0';mee_0];

oe_f=oe_0;
mee_f=mee_0;
state_f=state_0;

tspan = [0 100000];
opts = odeset('MaxStep',10);
sol = ode45(@ode_dynamics,tspan,state_0,opts);

N_time=length(sol.x);
T=sol.x;
soln.grid.state=zeros(13,N_time);
soln.grid.state=sol.y;

U=zeros(params.N_sat,N_time);

plotting_combo

