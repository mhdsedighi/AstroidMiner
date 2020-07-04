
clc
clear
close all

mu=3.986005*10^5;
Re=6378.14;

orbit1.a=10*Re;
orbit1.e=0;
orbit1.incl=deg2rad(0);
orbit1.RA=0;
orbit1.omega=0;
theta_pre_op=deg2rad(10);


orbit2.a=15*Re;
orbit2.e=0.7;
orbit2.incl=deg2rad(20);
orbit2.RA=deg2rad(60);
orbit2.omega=deg2rad(45);


theta_span=[0 2*pi];
tf_day_span=[-10 10];
m_span=[0 0];

lb=[theta_span(1) theta_span(1) tf_day_span(1) m_span(1)];
ub=[theta_span(2) theta_span(2) tf_day_span(2) m_span(2)];

initial_guess=rand(1,4).*(ub-lb)+lb;

% [cost]=lambert_cost(x0,orbit1,orbit2,mu);



options = optimoptions('simulannealbnd');
%%% Modify options setting
options = optimoptions(options,'FunctionTolerance', 1e-3);
options = optimoptions(options,'MaxIterations', 1e3);
options = optimoptions(options,'Display', 'off');
options = optimoptions(options,'HybridInterval', 'end');
options = optimoptions(options,'PlotFcn', {  @saplotbestf @saplotbestx });
[x_opt,cost_opt,exitflag,output] = ...
simulannealbnd(@(x)lambert_cost(x,orbit1,orbit2,mu),initial_guess,lb,ub,options);



theta1=x_opt(1);
theta2=x_opt(2);
tf_days=x_opt(3);
m=x_opt(4);


wait_time=theta2time(theta_pre_op,theta1,orbit1,mu);
period2=2*pi*sqrt(orbit2.a^3/mu);

[R_pre_op, V_pre_op] = rv_from_oe(orbit1.a,orbit1.e,orbit1.RA,orbit1.incl,orbit1.omega,theta_pre_op,mu);
[R1, V01] = rv_from_oe(orbit1.a,orbit1.e,orbit1.RA,orbit1.incl,orbit1.omega,theta1,mu);
[R2, V02] = rv_from_oe(orbit2.a,orbit2.e,orbit2.RA,orbit2.incl,orbit2.omega,theta2,mu);

[V1,V2, ~,exitflag] = lambert_pro(R1',R2',tf_days,m,mu);


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







