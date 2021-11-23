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
end

for i_par=1:N_par

    %     azimuths=inputArg(i_par,1:N_sat);
    %     elevations=inputArg(i_par,N_sat+1:2*N_sat);
    %     gammas=inputArg(i_par,2*N_sat+1:3*N_sat);
    %     lambdas=inputArg(i_par,3*N_sat+1:4*N_sat);
    W=inputArg(i_par,4*N_sat+1:4*N_sat+5);

    %%%%%%%%%%%%%%%%%%%%%%%%

    %     [Force_Vectors,Moment_Vectors]=rigid_positioning(sim_data.params,N_sat,azimuths,elevations,gammas,lambdas);
    %     Force_Vectors=Force_Vectors';
    %     Moment_Vectors=Moment_Vectors';

    %     max_f_available=[0 0;0 0;0 0];
    %     max_M_available=[0 0;0 0;0 0];
    %
    %
    %     for j=1:3
    %         for i=1:N_sat
    %             if Force_Vectors(j,i)>0
    %                 max_f_available(j,1)=max_f_available(j,1)+sim_data.max_f*Force_Vectors(j,i);
    %             else
    %                 max_f_available(j,2)=max_f_available(j,2)+sim_data.max_f*Force_Vectors(j,i);
    %             end
    %         end
    %     end
    %
    %     for j=1:3
    %         for i=1:N_sat
    %             if Moment_Vectors(j,i)>0
    %                 max_M_available(j,1)=max_M_available(j,1)+sim_data.max_f*Moment_Vectors(j,i);
    %             else
    %                 max_M_available(j,2)=max_M_available(j,2)+sim_data.max_f*Moment_Vectors(j,i);
    %             end
    %         end
    %     end
    %
    %     max_f_available=max_f_available*0.7;
    %     max_M_available=max_M_available*0.7;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



    simIn(i_par) = simIn(i_par).setVariable('W',W);
    %     simIn(i_par) = simIn(i_par).setVariable('Moment_Vectors',Moment_Vectors);
    %     simIn(i_par) = simIn(i_par).setVariable('max_f_available',max_f_available);
    %     simIn(i_par) = simIn(i_par).setVariable('max_M_available',max_M_available);

end


simOut=parsim(simIn,'TransferBaseWorkspaceVariables','on');

% for i_par=1:N_par
%     cost_array(i_par)=(1+simOut(i_par).Ucost.Data)^2*(1+simOut(i_par).omega.Data(end))^2;
% end


cost_array=zeros(N_par,1);
parfor i_par=1:N_par

    azimuths=inputArg(i_par,1:N_sat);
    elevations=inputArg(i_par,N_sat+1:2*N_sat);
    gammas=inputArg(i_par,2*N_sat+1:3*N_sat);
    lambdas=inputArg(i_par,3*N_sat+1:4*N_sat);


    [Force_Vectors,Moment_Vectors]=rigid_positioning(sim_data.params,N_sat,azimuths,elevations,gammas,lambdas);
    Force_Vectors=Force_Vectors';
    Moment_Vectors=Moment_Vectors';


    N_t=length(simOut(i_par).F_req_B.Time);
    T_vec=simOut(i_par).F_req_B.Time;



    FM=[simOut(i_par).F_req_B.Data';simOut(i_par).M_req.Data'];
    C=[Force_Vectors;Moment_Vectors];
    maxIter=20;
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
        if error>1e-2
            mark_err=mark_err+1;
        end

        guess=Uss(:,i);

    end

    int_Fs=trapz(T_vec,Uss,2);
    reach_fac=norm(simOut(i_par).R.Data(1:5));
    detumble_fac=simOut(i_par).omega.Data;

    cost_array(i_par)=sum(int_Fs)*(1+var(int_Fs)/1e10)*(1+mark_err/N_t)*(1+reach_fac)^2*(1+detumble_fac)^2;
    if reach_fac>1
        cost_array(i_par)=cost_array(i_par)*10;
    end


end
% 
% if sim_data.finalrun
% assignin('base','out',)
% end



end

