clc
clear all
close all

global mu force_t force_n force_r



mu=3.986005*10^5;
Re=6378.14;


a=10*Re;
e=0.5;
incl=deg2rad(20);
omega=deg2rad(0);
RA=deg2rad(60);
theta=deg2rad(45);


force_t=0;
force_n=0;
force_r=0;

oe=[a e incl omega RA theta];

mee0=oe2mee(oe,mu)

tspan = [0 100000];
opts = odeset('MaxStep',10);
sol = ode45(@mee_ode,tspan,mee0,opts);

N=length(sol.x);

R_ar=zeros(3,N);
for i=1:N
    [r,v]=mee2rv(sol.y(:,i),mu);
    R_ar(:,i)=r;
    
end

figure
hold on
axis equal
grid minor
view(25,45)
plot3(0,0,0,'r*')
plot3(R_ar(1,:),R_ar(2,:),R_ar(3,:))