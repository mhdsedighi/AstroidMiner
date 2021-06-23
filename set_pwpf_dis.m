% clc
% clear
close all



sample_time=0.1;
% order_force= max(max(out1.U));
maxS= max(out1.U);
out2=out1;
% out2.U=out2.U./maxS;
order_force=maxS;
test_freq=2*pi/60;
min_on_off_time=0.1;

%%%%%%%%%%%


max_Thrust_analog=1e-8;
digital_factor=1e-8;
scale=order_force/max_Thrust_analog;


% t_sim=min_on_off_time*5;
% t_sim=600;
t_sim=1000;

% Tm_d=2;
% Km_d=5;
% h=0.4;
% u_off=0;
% Thrust_digital=1;

pwpf_real_signal

Tm_span=[1e-3 10];
Km_span=[1e-4 20000];
h_span=[0 10]*digital_factor;
u_off_span=[0 10]*digital_factor;
Thrust_digital_span=[1 1]*digital_factor;

LB=[Tm_span(1) Km_span(1) h_span(1) u_off_span(1) Thrust_digital_span(1)];
UB=[Tm_span(2) Km_span(2) h_span(2) u_off_span(2) Thrust_digital_span(2)];


% x0=[Tm,Km,h,u_off,Thrust_digital];
x0=rand_gen(1,5,LB,UB);
% x0(4)=-abs(x0(4));

% cost = cost_pwpf(x0)


% fun=@(x)cost_pwpf(x);
options = optimoptions('simulannealbnd');
% options.Display='Iter';
options.PlotFcns={@saplotbestf,@saplotbestx };
options.MaxIter=1e6;
[x_opt,cost_opt,exitflag,output] = simulannealbnd(@cost_pwpf_dis,x0,LB,UB,options);



Tm_d=x_opt(1)
Km_d=x_opt(2)
h=x_opt(3)
u_off=x_opt(4)
Thrust_digital=x_opt(5)
u_on=h+u_off


sim pwpf_real_signal




% save pwpf_d_tune


