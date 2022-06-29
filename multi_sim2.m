function cost_array = multi_sim2(inputArg,sim_data)



N_sat=sim_data.N_sat;

% assignin('base','params',sim_data.params);
% assignin('base','mee_0',sim_data.mee_0);
% assignin('base','pqr_0',sim_data.pqr_0);
% assignin('base','eul_0',sim_data.eul_0);
% assignin('base','N_sat',sim_data.N_sat);
% assignin('base','max_f',sim_data.max_f);


[N_par,~]=size(inputArg);
% cost_array=zeros(N_par,1);

for i_par=1:N_par
    simIn(i_par) = Simulink.SimulationInput('model_5_exact');
    simIn(i_par).setModelParameter('TimeOut', 120);
end

for i_par=1:N_par

    lambdas=inputArg(i_par,1:N_sat);
    phis=inputArg(i_par,N_sat+1:2*N_sat);
    alphas=inputArg(i_par,2*N_sat+1:3*N_sat);
    betas=inputArg(i_par,3*N_sat+1:4*N_sat);
    W=inputArg(i_par,4*N_sat+1:4*N_sat+5);
    rot_Gains=inputArg(i_par,4*N_sat+6:4*N_sat+8);
    target_angles=inputArg(i_par,4*N_sat+9:4*N_sat+11);
    dif_theta=inputArg(4*N_sat+12);
%     mass_one_fuel=inputArg(i_par,end);

    %%%%%%%%%%%%%%%%%%%%%%%%
    rotm_target = eul2rotm(target_angles);
%     [sat_pos,Force_Vectors,Moment_Vectors,min_dis]=rigid_positioning_dis(sim_data.params,N_sat,lambdas,phis,alphas,betas);
    [~,Force_Vectors,Moment_Vectors,~]=rigid_positioning_dis(sim_data.params,N_sat,lambdas,phis,alphas,betas);
    Force_Vectors=Force_Vectors';
    Moment_Vectors=Moment_Vectors';

%     Sat_mass_vec=ones(N_sat,1)*mass_one_fuel+ones(N_sat,1)*sim_data.params.mass_sat_empty;
%     mass_sats=sum(Sat_mass_vec);
%     mass_total=sim_data.params.mass+mass_sats;
%     Inertia_sats=point_mass_Inertia(sat_pos,Sat_mass_vec);
%     Inertia_total=sim_data.params.Inertia+Inertia_sats;


    max_f_available=[0 0;0 0;0 0];
    max_M_available=[0 0;0 0;0 0];


    for j=1:3
        for i=1:N_sat
            if Force_Vectors(j,i)>0
                max_f_available(j,1)=max_f_available(j,1)+sim_data.max_f*Force_Vectors(j,i);
            else
                max_f_available(j,2)=max_f_available(j,2)+sim_data.max_f*Force_Vectors(j,i);
            end
        end
    end

    for j=1:3
        for i=1:N_sat
            if Moment_Vectors(j,i)>0
                max_M_available(j,1)=max_M_available(j,1)+sim_data.max_f*Moment_Vectors(j,i);
            else
                max_M_available(j,2)=max_M_available(j,2)+sim_data.max_f*Moment_Vectors(j,i);
            end
        end
    end

    max_f_available=max_f_available*0.7;
    max_M_available=max_M_available*0.7;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



    simIn(i_par) = simIn(i_par).setVariable('W',W);
    %     simIn(i_par) = simIn(i_par).setVariable('Force_Vectors',Force_Vectors);
    %     simIn(i_par) = simIn(i_par).setVariable('Moment_Vectors',Moment_Vectors);
    simIn(i_par) = simIn(i_par).setVariable('rot_Gains',rot_Gains);
    simIn(i_par) = simIn(i_par).setVariable('rotm_target',rotm_target);
    simIn(i_par) = simIn(i_par).setVariable('max_f_available',max_f_available);
    simIn(i_par) = simIn(i_par).setVariable('max_M_available',max_M_available);
%     simIn(i_par) = simIn(i_par).setVariable('mass_total',mass_total);
%     simIn(i_par) = simIn(i_par).setVariable('Inertia_total',Inertia_total);
simIn(i_par) = simIn(i_par).setVariable('dif_theta',dif_theta);


end


simOut=parsim(simIn,'TransferBaseWorkspaceVariables','on');

% for i_par=1:N_par
%     cost_array(i_par)=(1+simOut(i_par).Ucost.Data)^2*(1+simOut(i_par).omega.Data(end))^2;
% end


cost_array=zeros(N_par,1);
for i_par=1:N_par

    lambdas=inputArg(i_par,1:N_sat);
    phis=inputArg(i_par,N_sat+1:2*N_sat);
    alphas=inputArg(i_par,2*N_sat+1:3*N_sat);
    betas=inputArg(i_par,3*N_sat+1:4*N_sat);


    [sat_pos,Force_Vectors,Moment_Vectors,min_dis]=rigid_positioning_dis(sim_data.params,N_sat,lambdas,phis,alphas,betas);
    Force_Vectors=Force_Vectors';
    Moment_Vectors=Moment_Vectors';


    N_t=length(simOut(i_par).F_req_B.Time);
    T_vec=simOut(i_par).F_req_B.Time;



    FM=[simOut(i_par).F_req_B.Data';simOut(i_par).M_req.Data'];
    C=[Force_Vectors;Moment_Vectors];
    maxIter=25;
    options = optimoptions('lsqnonlin','Algorithm','levenberg-marquardt','MaxIterations',maxIter,'Display','none');
    LB=zeros(N_sat,1);
    UB=sim_data.params.max_f*ones(N_sat,1);

    guess=zeros(N_sat,1);

    Uss=zeros(N_sat,N_t);

    mark_err=0;

    for i=1:N_t

        b=FM(:,i);

        x0=guess;

        fun=@(x)(C*x-b);

        [Uss(:,i),error]=lsqnonlin(fun,x0,LB,UB,options);

        guess=Uss(:,i);


        if error>1e-2
            mark_err=mark_err+1;
%             Uss(:,i)=zeros(N_sat,1);
        end

        

    end

    int_Fs=trapz(T_vec,Uss,2);
    reach_fac=norm(simOut(i_par).R.Data(1:5));
    detumble_fac=simOut(i_par).omega.Data(end);
    T_end=T_vec(end);

%     res_fuels=Sat_mass_vec-int_Fs/(sim_data.params.Isp*9.81);
%     err_fuel=sum(abs(res_fuels))*(1+sum(res_fuels<0));

    if sim_data.params.strategy==1

%         cost_array(i_par)=sum(int_Fs)^0*(1+std(int_Fs)/1e8)^0*(1+5*mark_err/N_t)^0*(1+reach_fac)^5*(1+detumble_fac)^2*(1+T_end*3.171e-8)^0.2;
%         cost_array(i_par)=sum(int_Fs)^0.2*(1+std(int_Fs)/1e8)^0*(1+5*mark_err/N_t)^0*(1+reach_fac)^5*(1+detumble_fac)^2*(1+T_end*3.171e-8);

% cost_array(i_par)=(1+reach_fac)^5*(1+detumble_fac)^2;
cost_array(i_par)=(T_end*3.171e-8)*sum(int_Fs)^0.05;
% cost_array(i_par)=sum(int_Fs)*(1+std(int_Fs)/1e8)*(1+detumble_fac)^2;

    else

%         cost_array(i_par)=sum(int_Fs)*(1+std(int_Fs)/1e8)*(1+5*mark_err/N_t)^0*(1+reach_fac)^5*(1+detumble_fac)^2*(1+T_end*3.171e-8)^0.2;
cost_array(i_par)=sum(int_Fs)*(1+std(int_Fs)/1e8);

if (T_end*3.171e-8)>3
cost_array(i_par)=cost_array(i_par)*100;
end

    end


%     if min_dis<0.3
        %         this_min_dis=min_dis;
        %         if this_min_dis<0.05  %%avoiding inf
% %         %             this_min_dis=0.05;
% %         %         end
% %         %         cost_array(i_par)=cost_array(i_par)*(1+this_min_dis^(-15));
% %         %                 cost_array(i_par)=cost_array(i_par)*(10/(min_dis+1));
% % 
%         cost_array(i_par)=cost_array(i_par)*100;
%     end
% min_dis
%     if min_dis

%         cost_array(i_par)=cost_array(i_par)*(1+min_dis);
%     end

     cost_array(i_par)=cost_array(i_par)*(1+min_dis);



     if sim_data.params.final_test
         assignin('base','out')
         assignin('base','mark_err',mark_err);
         assignin('base','reach_fac',reach_fac);
         assignin('base','detumble_fac',detumble_fac);
         assignin('base','min_dis',min_dis);
         assignin('base','int_Fs',int_Fs);
         assignin('base','sum_int_Fs',sum_int_Fs);
         assignin('base','var_int_Fs',var(int_Fs));
         assignin('base','sat_pos',sat_pos);
     end

end



end

