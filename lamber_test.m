clc
clear

mu=3.986005*10^5;
Re=6378.14;

r1=10*Re;
r2=9*Re;

a=r1;
e=0;
incl=0;
RA=0;
omega=0;
theta=deg2rad(0);
[R1, V01] = rv_from_oe(a,e,RA,incl,omega,theta,mu);

a=r2;
e=0;
incl=0;
RA=0;
omega=0;
theta=deg2rad(1);
[R2, V02] = rv_from_oe(a,e,RA,incl,omega,theta,mu);

% v01=sqrt(mu/r1);
% v02=sqrt(mu/r2);

% r1vec=[100000 0 0];
% r2vec=[90000 0 3];

% r1vec=[0 v1 0];
% r2vec=[0 -v2 0];

tf=-1; %days

m=0;


[V1,V2, extremal_distances,exitflag] = lambert_pro(R1',R2',tf,m,mu)

deltaV1=V1-V01'
deltaV2=V2-V02'



