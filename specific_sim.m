function cost = specific_sim(inputArg,sim_data)

N_sat=sim_data.N_sat;

assignin('base','params',sim_data.params);
assignin('base','mee_0',sim_data.mee_0);
assignin('base','pqr_0',sim_data.pqr_0);
assignin('base','eul_0',sim_data.eul_0);
assignin('base','N_sat',sim_data.N_sat);
assignin('base','max_f',sim_data.max_f);



azimuths=inputArg(1:N_sat);
elevations=inputArg(N_sat+1:2*N_sat);
gammas=inputArg(2*N_sat+1:3*N_sat);
lambdas=inputArg(3*N_sat+1:4*N_sat);

%%%%%%%%%%%%%%%%%%%%%%%%

[Force_Vectors,Moment_Vectors]=rigid_positioning(sim_data.params,N_sat,azimuths,elevations,gammas,lambdas);
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

assignin('base','Force_Vectors',Force_Vectors);
assignin('base','Moment_Vectors',Moment_Vectors);
assignin('base','max_f_available',max_f_available);
assignin('base','max_M_available',max_M_available);



simIn= Simulink.SimulationInput('model_1');
% simIn.setBlockParameter('asteroid/gain13','Gain',1);
simOut = sim(simIn);

cost=(1+simOut.Ucost.Data)^2*(1+simOut.omega.Data(end))^2;




end

