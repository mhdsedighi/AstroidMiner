
clc
clear
close all

syms F_r F_s F_w
mu=3.986005*10^5;
Re=6378.14;

figure
hold on

for theta=0:0.1:2*pi
a=10*Re;
e=0.5;
inc=3*pi/180;
OMEGA=0;
omega=0;
% theta=0;


n=sqrt(mu/(a^3));
x=sqrt(1-e^2);
u=theta+omega;
p=a*(1-e^2);
h=sqrt(mu*p);

r=p/(1+e*cos(theta));

a_dot=2*e*sin(theta)/(n*x)*F_r+2*a*x/(n*r)*F_s;
e_dot=x*sin(theta)/(n*a)*F_r+x/(n*a^2*e)*((a^2*x^2)/r-r)*F_s;
i_dot=r*cos(u)/(n*a^2*x)*F_w;
OMEGA_dot=r*sin(u)/(n*a^2*x*sin(inc))*F_w;
omega_dot=-x*cos(theta)/(n*a*e)*F_r+(p/(e*h))*(sin(theta)*(1+(1/(1+e*cos(theta)))))*F_s-r*cot(inc)*sin(u)/(n*a^2*x)*F_w;
M_dot=n-1/(n*a)*(2*r/a-(x^2)/e*cos(theta))*F_r-x^2/(n*a*e)*(1+r/(a*x^2))*sin(theta)*F_s;

% plot(theta,diff(omega_dot,F_r),'r.')
% plot(theta,diff(omega_dot,F_s),'g.')
% plot(theta,diff(omega_dot,F_w),'b.')

% plot(theta,diff(i_dot,F_r),'r.')
% plot(theta,diff(i_dot,F_s),'g.')
% plot(theta,diff(i_dot,F_w),'b.')

% plot(theta,diff(a_dot,F_r),'r.')
% plot(theta,diff(a_dot,F_s),'g.')
% plot(theta,diff(a_dot,F_w),'b.')


plot(theta,diff(M_dot,F_r),'r.')
plot(theta,diff(M_dot,F_s),'g.')
plot(theta,diff(M_dot,F_w),'b.')


end
