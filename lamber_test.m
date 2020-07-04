clc
clear
close all

% global control_plan

mu=3.986005*10^5;
Re=6378.14;


a=10*Re;
e=0;
incl=deg2rad(0);
RA=0;
omega=0;
theta=deg2rad(0);
[R1, V01] = rv_from_oe(a,e,RA,incl,omega,theta,mu);
period1=2*pi*sqrt(a^3/mu);


a=7*Re;
e=0.3;
incl=deg2rad(90);
RA=deg2rad(20);
omega=deg2rad(30);
theta=deg2rad(180);
[R2, V02] = rv_from_oe(a,e,RA,incl,omega,theta,mu);
period2=2*pi*sqrt(a^3/mu);

% v01=sqrt(mu/r1);
% v02=sqrt(mu/r2);

% r1vec=[100000 0 0];
% r2vec=[90000 0 3];

% r1vec=[0 v1 0];
% r2vec=[0 -v2 0];



tf_days=4; %days



m=0;


[V1,V2, extremal_distances,exitflag] = lambert_pro(R1',R2',tf_days,m,mu);

deltaV1=V1'-V01;
deltaV2=V02-V2';

deltaV1_=norm(deltaV1);
deltaV2_=norm(deltaV2);

cost=deltaV1_+deltaV2_

t_start=0;
tf_days=abs(tf_days);
tf=tf_days*24*60*60;





% control_plan.N_max=2;
% control_plan.times=[t_start t_start+tf];
% control_plan.impulses=[deltaV1 deltaV2];
% control_plan.N=1;

opts = odeset('MaxStep',10);

tspan = [0.8*period1:-10:0];
x0=[R1;V01];
sol_o1 = ode45(@(t,x)odefun(t,x),tspan,x0,opts);

tspan = [0:tf];
x0=[R1;V1'];
sol_trans = ode45(@(t,x)odefun(t,x),tspan,x0,opts);

tspan = [tf:tf+0.8*period2];
x0=[R2;V02];
sol_o2 = ode45(@(t,x)odefun(t,x),tspan,x0,opts);

figure
hold on
axis equal
grid minor
view(25,45)
plot3(0,0,0,'ro')

plot3(sol_o1.y(1,:),sol_o1.y(2,:),sol_o1.y(3,:),'g')
plot3(sol_trans.y(1,:),sol_trans.y(2,:),sol_trans.y(3,:),'r')
plot3(sol_o2.y(1,:),sol_o2.y(2,:),sol_o2.y(3,:),'b')


% figure
% hold on
% grid minor
% subplot(3,1,1)
% plot(sol.x,sol.y(4,:))
% subplot(3,1,2)
% plot(sol.x,sol.y(5,:))
% subplot(3,1,3)
% plot(sol.x,sol.y(6,:))

