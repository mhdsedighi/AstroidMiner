clc
close all
mu=3.986005*10^5;
Re=6378.14;

r1_=10*Re
v1_=sqrt(mu/r1_)

r2_=9*Re
v2_=sqrt(mu/r2_)


e=0;
a=r1_;
RA=0;
incl=0;
omega=0;
theta1=0;

[r1, v1] = rv_from_oe(a,e,RA,incl,omega,theta1,mu)

e=0;
a=r2_;
RA=0;
incl=0;
omega=0;
theta2=deg2rad(35);

[r2, v2] = rv_from_oe(a,e,RA,incl,omega,theta2,mu)

N=51;
r_array=linspace(r1_,r2_,N);
theta_array=linspace(theta1,theta2,N);

ig_x=r_array.*cos(theta_array)
ig_y=r_array.*sin(theta_array)

figure
hold on
plot(ig_x,ig_y)
axis equal
plot(0,0,'r*')



