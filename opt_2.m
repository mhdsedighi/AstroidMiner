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



x0=[azimuths_0 elevations_0 gammas_0 lambdas_0];
LB=[zeros(1,N_sat) -90*ones(1,N_sat) -30*ones(1,N_sat) -30*ones(1,N_sat)];
UB=[360*ones(1,N_sat) 90*ones(1,N_sat) 30*ones(1,N_sat) 30*ones(1,N_sat)];


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










