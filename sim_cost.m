function cost = sim_cost(inputArg,N_sat,params)


lambdas=inputArg(1:N_sat);
phis=inputArg(N_sat+1:2*N_sat);
alphas=inputArg(2*N_sat+1:3*N_sat);
betas=inputArg(3*N_sat+1:4*N_sat);
W=inputArg(4*N_sat+1:4*N_sat+5);
rot_Gains=inputArg(4*N_sat+6:4*N_sat+8);
target_angles=inputArg(4*N_sat+9:4*N_sat+11);
% mass_one_fuel=inputArg(end);


rotm_target = eul2rotm(target_angles);
[sat_pos,Force_Vectors,Moment_Vectors,min_dis]=rigid_positioning_dis(params,N_sat,lambdas,phis,alphas,betas);
Force_Vectors=Force_Vectors';
Moment_Vectors=Moment_Vectors';

% Sat_mass_vec=ones(N_sat,1)*mass_one_fuel+ones(N_sat,1)*params.mass_sat_empty;
% mass_sats=sum(Sat_mass_vec);
% mass_total=params.mass+mass_sats;
% Inertia_sats=point_mass_Inertia(sat_pos,Sat_mass_vec);
% Inertia_total=params.Inertia+Inertia_sats;

% % % max_f_available=[0 0;0 0;0 0];
% % % max_M_available=[0 0;0 0;0 0];
% % % for j=1:3
% % %     for i=1:N_sat
% % %         if Force_Vectors(j,i)>0
% % %             max_f_available(j,1)=max_f_available(j,1)+sim_data.max_f*Force_Vectors(j,i);
% % %         else
% % %             max_f_available(j,2)=max_f_available(j,2)+sim_data.max_f*Force_Vectors(j,i);
% % %         end
% % %     end
% % % end
% % % for j=1:3
% % %     for i=1:N_sat
% % %         if Moment_Vectors(j,i)>0
% % %             max_M_available(j,1)=max_M_available(j,1)+sim_data.max_f*Moment_Vectors(j,i);
% % %         else
% % %             max_M_available(j,2)=max_M_available(j,2)+sim_data.max_f*Moment_Vectors(j,i);
% % %         end
% % %     end
% % % end
% % %
% % %
% % %
% % %
% % %
% % % assignin('base','Force_Vectors',Force_Vectors);
% % % assignin('base','Moment_Vectors',Moment_Vectors);
% % % assignin('base','max_f_available',max_f_available);
% % % assignin('base','max_M_available',max_M_available);



simIn= Simulink.SimulationInput('model_5_exact');
% simIn.setBlockParameter('asteroid/gain13','Gain',1);

% simIn= simIn.setVariable('W',W);

assignin('base','W',W);
assignin('base','rot_Gains',rot_Gains);
assignin('base','rotm_target',rotm_target);
% assignin('base','mass_total',mass_total);
% assignin('base','Inertia_total',Inertia_total);
% assignin('base','sat_pos',sat_pos);

simOut=sim(simIn);

N_t=length(simOut.F_req_B.Time);
T_vec=simOut.F_req_B.Time;

% T_end=T_vec(end);

FM=[simOut.F_req_B.Data';simOut.M_req.Data'];
C=[Force_Vectors;Moment_Vectors];


guess=zeros(N_sat,1);

Uss=zeros(N_sat,N_t);

mark_err=0;

for i=1:N_t

    b=FM(:,i);

    x0=guess;

    fun=@(x)(C*x-b);

    [Uss(:,i),error]=lsqnonlin(fun,x0,params.LB,params.UB,params.options);
    if error>1e-2
        mark_err=mark_err+1;
    end

    guess=Uss(:,i);

end

int_Fs=trapz(T_vec,Uss,2);
sum_int_Fs=sum(int_Fs);

int_Fs=trapz(T_vec,Uss,2);
reach_fac=norm(simOut.R.Data(1:5));
detumble_fac=simOut.omega.Data(end);
T_end=T_vec(end);

% res_fuels=Sat_mass_vec-int_Fs/(3000*9.81);
% err_fuel=sum(abs(res_fuels))*(1+sum(res_fuels<0));

if params.strategy==1

    cost=sum(int_Fs)*(1+std(int_Fs))*(1+5*mark_err/N_t)^5*(1+reach_fac)^5*(1+detumble_fac)^2*(1+T_end*3.171e-8)^0.2;

else

    cost=sum(int_Fs)*(1+std(int_Fs))*(1+5*mark_err/N_t)^5*(1+reach_fac)^5*(1+detumble_fac)^2*(1+T_end*3.171e-8)^0.2;

end


if min_dis<0.3
    cost=cost*(1+min_dis^(-2));
    %         cost_array(i_par)=cost_array(i_par)*(10/(min_dis+1));
end


if params.final_test

    assignin('base','out',simOut);
    assignin('base','mark_err',mark_err);
    assignin('base','reach_fac',reach_fac);
    assignin('base','detumble_fac',detumble_fac);
    assignin('base','min_dis',min_dis);
    assignin('base','int_Fs',int_Fs);
    assignin('base','sum_int_Fs',sum_int_Fs);
    assignin('base','std_int_Fs',std(int_Fs));
%     assignin('base','res_fuels',res_fuels);
%     assignin('base','sat_pos',sat_pos);

end

end