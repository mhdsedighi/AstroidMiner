function cost = sim_cost(inputArg,N_sat,params)


azimuths=inputArg(1:N_sat);
elevations=inputArg(N_sat+1:2*N_sat);
gammas=inputArg(2*N_sat+1:3*N_sat);
lambdas=inputArg(3*N_sat+1:4*N_sat);
W=inputArg(4*N_sat+1:4*N_sat+5);
rot_Gains=inputArg(4*N_sat+6:4*N_sat+8);


[Force_Vectors,Moment_Vectors]=rigid_positioning(params,N_sat,azimuths,elevations,gammas,lambdas);
Force_Vectors=Force_Vectors';
Moment_Vectors=Moment_Vectors';

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

simOut=sim(simIn);

N_t=length(simOut.F_req_B.Time);
T_vec=simOut.F_req_B.Time;

T_end=T_vec(end);

FM=[simOut.F_req_B.Data';simOut.M_req.Data'];
C=[Force_Vectors;Moment_Vectors];
maxIter=20;
options = optimoptions('lsqnonlin','Algorithm','levenberg-marquardt','MaxIterations',maxIter,'Display','none');
LB=zeros(N_sat,1);
UB=params.max_f*ones(N_sat,1);

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
reach_fac=norm(simOut.R.Data(1:5));
detumble_fac=simOut.omega.Data;

cost=sum(int_Fs)*(1+var(int_Fs)/1e10)*(1+mark_err/N_t)^5*(1+reach_fac)^2*(1+detumble_fac)^2*T_end*1e-8;



end