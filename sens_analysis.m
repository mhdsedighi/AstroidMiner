

[sat_pos,Force_Vectors,Moment_Vectors,min_dis]=rigid_positioning_dis(sim_data.params,N_sat,lambdas,phis,alphas,betas);
params.final_test=1;
% params.max_f=max_f;
% params.mee_0=mee_0;
% params.strategy=strategy;

maxIter=50;
params.options = optimoptions('lsqnonlin','Algorithm','levenberg-marquardt','MaxIterations',maxIter,'Display','none');
params.LB=zeros(N_sat,1);
params.UB=params.max_f*ones(N_sat,1);


% k_rot_arr=[0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1 1.05 1.1 1.15 1.2 1.25 1.3 1.35 1.4 1.45 1.5];
k_rot_arr=[0.1:0.025:5]
% k_rot_arr=[0.7 0.75 0.8 0.85 0.9 0.95 1 1.05 1.1 1.15 1.2];
% k_rot_arr=[0.9 1 1.1];
% k_rot_arr=[0.2:0.2:5];
sum_arr=[];
var_arr=[];
T_damp_arr=[];
err_arr=[];
cost_arr=[];


for i=1:length(k_rot_arr)
    i
    k_rot=k_rot_arr(i);

    x_test=x_opt;
    %     x_test(4*N_sat+6:4*N_sat+8)=x_test(4*N_sat+6:4*N_sat+8)*k_rot;
    x_test(4*N_sat+6)=x_test(4*N_sat+6)*k_rot;
    %
    cost_opt=sim_cost(x_test,N_sat,params);
    sum_arr=[sum_arr sum_int_Fs];
    var_arr=[var_arr std_int_Fs];
    err_arr=[err_arr mark_err];

    mark_err

    T=out.omega.Time;
    N_t=length(T);
    spin_reduction=out.omega.Data/out.omega.Data(1)*100;
    idxs=find(spin_reduction<10);
    T_damp_arr=[T_damp_arr T(idxs(1))];


%     cost_arr=[cost_arr sum(int_Fs)^0.2*(1+std(int_Fs)/mean(int_Fs))^0.1*(1+T_end)*(1+5*mark_err/N_t)^6];

%     cost_arr=[cost_arr sum(int_Fs)^1*(1+std(int_Fs)/mean(int_Fs))^0.1*(1+T_end)^0.7*(1+5*mark_err/N_t)^6];


if params.strategy==1

cost_arr=[cost_arr sum(int_Fs)^0.2*(1+std(int_Fs)/mean(int_Fs))^0.1*(T_end)];

else

cost_arr=[cost_arr sum(int_Fs)^1*(1+std(int_Fs)/mean(int_Fs))^0.1*(T_end)^0.7];

end



end




% idx_base=find(k_rot_arr==1);


