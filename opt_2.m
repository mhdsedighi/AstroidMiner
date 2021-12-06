clc
warning('off','all')

params.max_f=max_f;
params.mee_0=mee_0;

N_sat=25;
% lambdas=rand_gen(1,N_sat,0,360);
% phis=rand_gen(1,N_sat,-90,90);
% alphas=zeros(1,N_sat);
% betas=zeros(1,N_sat);
% [Force_Vectors,Moment_Vectors]=rigid_positioning(params,N_sat,lambdas,phis,alphas,betas);
% Force_Vectors=Force_Vectors';
% Moment_Vectors=Moment_Vectors';


lambdas_0=rand_gen(1,N_sat,0,360);
phis_0=rand_gen(1,N_sat,-90,90);
alphas_0=zeros(1,N_sat);
betas_0=zeros(1,N_sat);
W_0=[1 1 1 1 1];
rot_Gains_0=[1 1 1];
t_wait_0=0;

period0=2*pi*sqrt(mee_0(1)^3/params.mu);
max_wait=period0/2;


x0=[lambdas_0 phis_0 alphas_0 betas_0 W_0 rot_Gains_0 t_wait_0];
LB=[zeros(1,N_sat) -90*ones(1,N_sat) -45*ones(1,N_sat) 0*ones(1,N_sat) 0.5*ones(1,5) 0.5*ones(1,3) 0];
UB=[360*ones(1,N_sat) 90*ones(1,N_sat) 45*ones(1,N_sat) 180*ones(1,N_sat) 1.5*ones(1,5) 1.5*ones(1,3) max_wait];


cost_handle=@(inputArg)sim_cost(inputArg,N_sat,params);
options = optimoptions('simulannealbnd');
% options.Display='Iter';
% options.PlotFcns={@saplotbestf,@saplotbestx };
options.PlotFcns={@saplotbestf};
options.MaxIter=1e6;
options.InitialTemperature=700;
[x_opt,cost_opt,exitflag,output] = simulannealbnd(cost_handle,x0,LB,UB,options);
cost_handle(x_opt)
% 

% % % sim_data.params=params;
% % % sim_data.mee_0=mee_0;
% % % sim_data.pqr_0=pqr_0;
% % % sim_data.eul_0=eul_0;
% % % sim_data.N_sat=N_sat;
% % % sim_data.max_f=max_f;
% % % cost_handle_multi=@(inputArg)multi_sim2(inputArg,sim_data);
% % % poolobj = gcp;
% % % pctRunOnAll('initial_sim2')
% % % % addAttachedFiles(poolobj,{'myFun1.m','myFun2.m'})
% % % addAttachedFiles(poolobj,{'model_5_exact.slx','multi_sim2.m'});
% % % parfevalOnAll(@load_system,0,'model_5_exact');
% % % options = optimoptions('particleswarm','UseParallel', true, 'UseVectorized', true,'Display','iter','PlotFcn','pswplotbestf','SwarmSize',10);
% % % nvars=4*N_sat+5;
% % % [x_opt,cost_opt,exitflag,output]=particleswarm(cost_handle_multi,nvars,LB,UB,options)




lambdas=x_opt(1:N_sat);
phis=x_opt(N_sat+1:2*N_sat);
alphas=x_opt(2*N_sat+1:3*N_sat);
betas=x_opt(3*N_sat+1:4*N_sat);
W=x_opt(4*N_sat+1:4*N_sat+5);
% rot_Gains=x_opt(4*N_sat+6:4*N_sat+8);
[Force_Vectors,Moment_Vectors]=rigid_positioning(params,N_sat,lambdas,phis,alphas,betas);
Force_Vectors=Force_Vectors';
Moment_Vectors=Moment_Vectors';




out=sim('model_5_exact.slx');


ylabel('Cost Function Value')
title('')
set(gca,'Yscale','log','Xgrid','on','Ygrid','on')

plot_sats
plot_sim




