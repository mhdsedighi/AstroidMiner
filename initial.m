
clc
clear
close all

mu=3.986005*10^5;
Re=6378.14;         % Earth Radius


a=10*Re;
e=0.5;
incl=deg2rad(1);
RA=deg2rad(0);
omega=deg2rad(0);
theta0=deg2rad(0);

[r0,r_dot0]=rv_from_oe(a,e,RA,incl,omega,theta0,mu);
% 
% 
% r_c=2*Re;
% v_c=1.18*sqrt(mu/r_c);
% 
% r0=[r_c;0;0];
% r_dot0=[0;v_c;2];

max_thrust_acc=0.01;
% 
t_sim=8000000;
% 
sim test

figure
hold on
plot_earth
plot3(ans.r_history.Data(1,1),ans.r_history.Data(1,2),ans.r_history.Data(1,3),'ro')
plot3(ans.r_history.Data(:,1),ans.r_history.Data(:,2),ans.r_history.Data(:,3),'k')
plot3(ans.r_history.Data(end,1),ans.r_history.Data(end,2),ans.r_history.Data(end,3),'b*')
axis equal
view(25,45)
grid minor
xlabel('x')
ylabel('y')
zlabel('z')