clc
warning('off','all')

params.max_f=max_f;

N_sat=25;
% azimuths=rand_gen(1,N_sat,0,360);
% elevations=rand_gen(1,N_sat,-90,90);
% gammas=zeros(1,N_sat);
% lambdas=zeros(1,N_sat);
% [Force_Vectors,Moment_Vectors]=rigid_positioning(params,N_sat,azimuths,elevations,gammas,lambdas);
% Force_Vectors=Force_Vectors';
% Moment_Vectors=Moment_Vectors';


azimuths_0=rand_gen(1,N_sat,0,360);
elevations_0=rand_gen(1,N_sat,-90,90);
gammas_0=zeros(1,N_sat);
lambdas_0=zeros(1,N_sat);
W_0=[1 1 1 1 1];
rot_Gains_0=[1 1 1];



x0=[azimuths_0 elevations_0 gammas_0 lambdas_0 W_0 rot_Gains_0];
LB=[zeros(1,N_sat) -90*ones(1,N_sat) -30*ones(1,N_sat) -30*ones(1,N_sat) 0.5*ones(1,5) 0.5*ones(1,3)];
UB=[360*ones(1,N_sat) 90*ones(1,N_sat) 30*ones(1,N_sat) 30*ones(1,N_sat) 1.5*ones(1,5) 5*ones(1,3)];


cost_handle=@(inputArg)sim_cost(inputArg,N_sat,params);
options = optimoptions('simulannealbnd');
% options.Display='Iter';
options.PlotFcns={@saplotbestf,@saplotbestx };
options.MaxIter=1e6;
[x_opt,cost_opt,exitflag,output] = simulannealbnd(cost_handle,x0,LB,UB,options);
cost_handle(x_opt)
azimuths=x_opt(1:N_sat);
elevations=x_opt(N_sat+1:2*N_sat);
gammas=x_opt(2*N_sat+1:3*N_sat);
lambdas=x_opt(3*N_sat+1:4*N_sat);
plot_sats
plot_sim


sim_data.params=params;
sim_data.mee_0=mee_0;
sim_data.pqr_0=pqr_0;
sim_data.eul_0=eul_0;
sim_data.N_sat=N_sat;
sim_data.max_f=max_f;




% cost_handle_multi=@(inputArg)multi_sim2(inputArg,sim_data);
% 
% % cost_handle_multi([x0;LB])
% 
% 
% poolobj = gcp;
% pctRunOnAll('initial_sim2')
% % addAttachedFiles(poolobj,{'myFun1.m','myFun2.m'})
% addAttachedFiles(poolobj,{'model_5_exact.slx','multi_sim2.m'});
% parfevalOnAll(@load_system,0,'model_5_exact');
% options = optimoptions('particleswarm','UseParallel', true, 'UseVectorized', true,'Display','iter','PlotFcn','pswplotbestf','SwarmSize',10);
% nvars=4*N_sat+5;
% 
% 
% [x_opt,cost_opt,exitflag,output]=particleswarm(cost_handle_multi,nvars,LB,UB,options)




azimuths=x_opt(1:N_sat);
elevations=x_opt(N_sat+1:2*N_sat);
gammas=x_opt(2*N_sat+1:3*N_sat);
lambdas=x_opt(3*N_sat+1:4*N_sat);
W=x_opt(4*N_sat+1:4*N_sat+5);
rot_Gains=x_opt(4*N_sat+6:4*N_sat+8);

out=sim('model_5_exact.slx');

close all
plot_sats
plot_sim













