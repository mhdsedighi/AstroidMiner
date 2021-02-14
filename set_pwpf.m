clc
clear
close all

pwpf

t_sim=120;
test_freq=2*pi/60;
Thrust_analog=1;
min_on_off_time=1;


Tm=2;
Km=5;
h=0.4;
u_off=0;
Thrust_digital=1;



Tm_span=[1e-3 5];
Km_span=[1e-3 2000];
h_span=[0 10];
u_off_span=[-10 10];
Thrust_digital_span=[1 1];

LB=[Tm_span(1) Km_span(1) h_span(1) u_off_span(1) Thrust_digital_span(1)];
UB=[Tm_span(2) Km_span(2) h_span(2) u_off_span(2) Thrust_digital_span(2)];


% x0=[Tm,Km,h,u_off,Thrust_digital];
x0=rand_gen(1,5,LB,UB);


% cost = cost_pwpf(x0)


% fun=@(x)cost_pwpf(x);
options = optimoptions('simulannealbnd');
% options.Display='Iter';
options.PlotFcns={@saplotbestf,@saplotbestx };
options.MaxIter=1e6;
[x_opt,cost_opt,exitflag,output] = simulannealbnd(@cost_pwpf,x0,LB,UB,options);



Tm=x_opt(1)
Km=x_opt(2)
h=x_opt(3)
u_off=x_opt(4)
Thrust_digital=x_opt(5)
u_on=h+u_off


sim pwpf


