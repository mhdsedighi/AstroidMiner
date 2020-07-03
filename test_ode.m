clc
clear 
close all

mu=3.986005*10^5;
Re=6378.14;

r1=10*Re;
r2=9*Re;

a=r1;
e=0.75;
incl=deg2rad(0);
RA=0;
omega=0;
theta=deg2rad(0);
[R1, V01] = rv_from_oe(a,e,RA,incl,omega,theta,mu);

tspan = [0 200000];
x0=[R1;V01*1.0];
opts = odeset('MaxStep',100);
sol = ode45(@(t,x)odefun(t,x),tspan,x0,opts);

figure
hold on
axis equal
grid minor
view(25,45)
plot3(0,0,0,'r*')

plot3(sol.y(1,:),sol.y(2,:),sol.y(3,:))