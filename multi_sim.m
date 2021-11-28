function cost_array = multi_sim(inputArg,sim_data)

N_sat=sim_data.N_sat;

assignin('base','params',sim_data.params);
assignin('base','mee_0',sim_data.mee_0);
assignin('base','pqr_0',sim_data.pqr_0);
assignin('base','eul_0',sim_data.eul_0);
assignin('base','N_sat',sim_data.N_sat);
assignin('base','max_f',sim_data.max_f);


[N_par,~]=size(inputArg);
cost_array=zeros(N_par,1);

for i_par=1:N_par
    simIn(i_par) = Simulink.SimulationInput('model_1');
end

for i_par=1:N_par
    
    lambdas=inputArg(i_par,1:N_sat);
    phis=inputArg(i_par,N_sat+1:2*N_sat);
    alphas=inputArg(i_par,2*N_sat+1:3*N_sat);
    betas=inputArg(i_par,3*N_sat+1:4*N_sat);
    
    %%%%%%%%%%%%%%%%%%%%%%%%
    
    [Force_Vectors,Moment_Vectors]=rigid_positioning(sim_data.params,N_sat,lambdas,phis,alphas,betas);
    Force_Vectors=Force_Vectors';
    Moment_Vectors=Moment_Vectors';
    
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
    
    
    
    simIn(i_par) = simIn(i_par).setVariable('Force_Vectors',Force_Vectors);
    simIn(i_par) = simIn(i_par).setVariable('Moment_Vectors',Moment_Vectors);
    simIn(i_par) = simIn(i_par).setVariable('max_f_available',max_f_available);
    simIn(i_par) = simIn(i_par).setVariable('max_M_available',max_M_available);
    
end


simOut=parsim(simIn,'TransferBaseWorkspaceVariables','on');

for i_par=1:N_par
    cost_array(i_par)=(1+simOut(i_par).Ucost.Data)^2*(1+simOut(i_par).omega.Data(end))^2;
end




end

