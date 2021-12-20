clc
initial_sim2
warning('off','all')

params.max_f=max_f;
params.mee_0=mee_0;
params.oe_0=oe_0;

pqr_0=[0;0;0];
att_Gains=[0 0 0];
R_stop=1e-2;

% N_sat=25;
% lambdas=rand_gen(1,N_sat,0,360);
% phis=rand_gen(1,N_sat,-90,90);
% alphas=zeros(1,N_sat);
% betas=zeros(1,N_sat);
% [Force_Vectors,Moment_Vectors]=rigid_positioning(params,N_sat,lambdas,phis,alphas,betas);
% Force_Vectors=Force_Vectors';
% Moment_Vectors=Moment_Vectors';


% lambdas_0=rand_gen(1,N_sat,0,360);
% phis_0=rand_gen(1,N_sat,-90,90);
% alphas_0=zeros(1,N_sat);
% betas_0=zeros(1,N_sat);

% W_0=[1 1 1 1 1];
% theta_0=pi;

% min time
% W_0=[15.7691   19.1673   10.3197   18.2571   10.5895]/100;
% theta_0=5.4986;

% % % min energy
W_0=[1.0000    0.2350    0.1476    0.4439    0.3023];
theta_0=6.0565;

W_0=W_0./max(W_0);
rot_Gains_0=[1 1 1];


period0=2*pi*sqrt(mee_0(1)^3/params.mu);
max_w=30;
min_w=0.001;

x0=[W_0 theta_0];
LB=[min_w*ones(1,5) 0];
UB=[max_w*ones(1,5) 2*pi];


cost_handle=@(inputArg)sim_cost_path(inputArg,params);
options = optimoptions('simulannealbnd');
% options.Display='Iter';
options.PlotFcns={@saplotbestf,@saplotbestx };
options.MaxIter=1e6;
options.InitialTemperature=700;
[x_opt,cost_opt,exitflag,output] = simulannealbnd(cost_handle,x0,LB,UB,options);

% 

% sim_data.params=params;
% sim_data.mee_0=mee_0;
% sim_data.pqr_0=pqr_0;
% sim_data.eul_0=eul_0;
% sim_data.N_sat=N_sat;
% sim_data.max_f=max_f;
% cost_handle_multi=@(inputArg)multi_sim2(inputArg,sim_data);
% poolobj = gcp;
% pctRunOnAll('initial_sim2')
% addAttachedFiles(poolobj,{'model_5_exact.slx','multi_sim2.m'});
% parfevalOnAll(@load_system,0,'model_5_exact');
% options = optimoptions('particleswarm','UseParallel', true, 'UseVectorized', true,'Display','iter','PlotFcn','pswplotbestf','SwarmSize',10);
% nvars=4*N_sat+5+3+1;
% [x_opt,cost_opt,exitflag,output]=particleswarm(cost_handle_multi,nvars,LB,UB,options)





W=x_opt(1:5);
W=W./max(W)
theta_0=x_opt(end)

mee_0=params.mee_0;
mee_0(6)=mee_0(6)-params.oe_0(6)+theta_0;




out=sim('model_5_exact.slx');
T_end=out.F_req_B.Time(end)/31536000
effort=out.effort.Data


ylabel('Cost Function Value')
title('')
set(gca,'Yscale','log','Xgrid','on','Ygrid','on')

plot_sim




