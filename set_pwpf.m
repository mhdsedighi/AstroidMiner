clc
clear
close all

pwpf

t_sim=100;
test_freq=1;
Thrust=1;

Tm=2;
Km=5;
h=0.4;
u_off=0;
u=1;


Tm_span=[0.01 5];
Km_span=[1e-3 500];
h_span=[0 10];
u_off_span=[-10 10];
u_span=[1 1];

LB=[Tm_span(1) Km_span(1) h_span(1) u_off_span(1) u_span(1)];
UB=[Tm_span(2) Km_span(2) h_span(2) u_off_span(2) u_span(2)];


x0=[Tm,Km,h,u_off,u];

% cost = cost_pwpf(x0)


% fun=@(x)cost_pwpf(x);
options = saoptimset;
% options.Display='Iter';
options.PlotFcns={@saplotbestf,@saplotbestx };
options.MaxIter=1e6;
[x_opt,cost_opt,exitflag,output] = simulannealbnd(@cost_pwpf,x0,LB,UB,options);



Tm=x_opt(1);
Km=x_opt(2);
h=x_opt(3);
u_off=x_opt(4);
u=x_opt(5);
u_on=h+u_off;


sim pwpf2



