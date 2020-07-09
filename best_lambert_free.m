
clc
clear
close all

mu=3.986005*10^5;
Re=6378.14;

orbit1.a=12*Re;
orbit1.e=0;
orbit1.incl=deg2rad(0);
orbit1.RA=deg2rad(0);
orbit1.omega=deg2rad(0);
theta_pre_op=deg2rad(0);


orbit2.a=10*Re;
% orbit2.e=0.7;
% orbit2.incl=deg2rad(20);
% orbit2.RA=deg2rad(0);
% orbit2.omega=deg2rad(45);

e_span=[0 0];
incl_span=[deg2rad(0) deg2rad(0)];
RA_span=[0 0];
omega_span=[0 0];


theta_span=[0 2*pi];
tf_day_span=[-10 10];
m_span=[0 0];

lb=[e_span(1) incl_span(1) RA_span(1) omega_span(1) theta_span(1) theta_span(1) tf_day_span(1) m_span(1)];
ub=[e_span(2) incl_span(2) RA_span(2) omega_span(2) theta_span(2) theta_span(2) tf_day_span(2) m_span(2)];

initial_guess=rand(1,8).*(ub-lb)+lb;

[cost]=lambert_cost_free(initial_guess,orbit1,orbit2,mu);



options = optimoptions('simulannealbnd');
%%% Modify options setting
options = optimoptions(options,'FunctionTolerance', 1e-3);
options = optimoptions(options,'MaxIterations', 2e3);
options = optimoptions(options,'Display', 'off');
options = optimoptions(options,'HybridInterval', 'end');
options = optimoptions(options,'PlotFcn', {  @saplotbestf @saplotbestx });
[x_opt,cost_opt,exitflag,output] = ...
simulannealbnd(@(x)lambert_cost_free(x,orbit1,orbit2,mu),initial_guess,lb,ub,options);


orbit2.e=x_opt(1);
orbit2.incl=x_opt(2);
orbit2.RA=x_opt(3);
orbit2.omega=x_opt(4);
theta1=x_opt(5);
theta2=x_opt(6);
tf_days=x_opt(7);
m=x_opt(8);


wait_time=theta2time(theta_pre_op,theta1,orbit1,mu);
period2=2*pi*sqrt(orbit2.a^3/mu);

[R_pre_op, V_pre_op] = rv_from_oe(orbit1.a,orbit1.e,orbit1.RA,orbit1.incl,orbit1.omega,theta_pre_op,mu);
[R1, V01] = rv_from_oe(orbit1.a,orbit1.e,orbit1.RA,orbit1.incl,orbit1.omega,theta1,mu);
[R2, V02] = rv_from_oe(orbit2.a,orbit2.e,orbit2.RA,orbit2.incl,orbit2.omega,theta2,mu);

[V1,V2, ~,exitflag] = lambert_pro(R1',R2',tf_days,m,mu);
deltaV1=V1'-V01
deltaV2=V02-V2'


oe_lambert=oe_from_sv(R1,V1',mu);
period_lambert=2*pi*sqrt(oe_lambert(7)^3/mu);

tf=abs(tf_days*24*60*60);


opts = odeset('MaxStep',10);

tspan = [0:wait_time];
x0=[R_pre_op;V_pre_op];
sol_o1 = ode45(@(t,x)odefun(t,x),tspan,x0,opts);

tspan = [wait_time:wait_time+tf];
x0=[R1;V1'];
sol_trans = ode45(@(t,x)odefun(t,x),tspan,x0,opts);

tspan = [wait_time+tf:wait_time+tf+0.5*period2];
x0=[R2;V02];
sol_o2 = ode45(@(t,x)odefun(t,x),tspan,x0,opts);

figure
hold on
axis equal
grid minor
view(25,45)
xlabel('X');
ylabel('Y');
zlabel('Z');
plot3(0,0,0,'ro')

plot3(sol_o1.y(1,:),sol_o1.y(2,:),sol_o1.y(3,:),'g')
plot3(sol_trans.y(1,:),sol_trans.y(2,:),sol_trans.y(3,:),'r')
plot3(sol_o2.y(1,:),sol_o2.y(2,:),sol_o2.y(3,:),'b')



N=31;
ar_time_travel=sol_trans.x-sol_trans.x(1);
ar_X_trajectory=sol_trans.y;
X_start=sol_trans.y(:,1);
X_end=sol_trans.y(:,end);
impulse1=xyz2rsw(deltaV1,X_start(1:3),X_start(4:6))
impulse2=xyz2rsw(deltaV2,X_end(1:3),X_end(4:6))

time_travel=linspace(0,ar_time_travel(end),N);

X_trajectory(1,:) =interp1(ar_time_travel,ar_X_trajectory(1,:),time_travel);
X_trajectory(2,:) =interp1(ar_time_travel,ar_X_trajectory(2,:),time_travel);
X_trajectory(3,:) =interp1(ar_time_travel,ar_X_trajectory(3,:),time_travel);
X_trajectory(4,:) =interp1(ar_time_travel,ar_X_trajectory(4,:),time_travel);
X_trajectory(5,:) =interp1(ar_time_travel,ar_X_trajectory(5,:),time_travel);
X_trajectory(6,:) =interp1(ar_time_travel,ar_X_trajectory(6,:),time_travel);


% figure
% hold on
% axis equal
% grid minor
% view(25,45)
% xlabel('X');
% ylabel('Y');
% zlabel('Z');
% plot3(0,0,0,'ro')
% plot3(X_trajectory(1,:),X_trajectory(2,:),X_trajectory(3,:),'r')


save ig



