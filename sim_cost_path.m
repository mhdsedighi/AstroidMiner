function cost = sim_cost_path(inputArg,params)


% lambdas=inputArg(1:N_sat);
% phis=inputArg(N_sat+1:2*N_sat);
% alphas=inputArg(2*N_sat+1:3*N_sat);
% betas=inputArg(3*N_sat+1:4*N_sat);
W=inputArg(1:5);
% rot_Gains=inputArg(4*N_sat+6:4*N_sat+8);
theta_0=inputArg(end);

mee_0=params.mee_0;
mee_0(6)=mee_0(6)-params.oe_0(6)+theta_0;


% [Force_Vectors,Moment_Vectors]=rigid_positioning(params,N_sat,lambdas,phis,alphas,betas);
% Force_Vectors=Force_Vectors';
% Moment_Vectors=Moment_Vectors';

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
assignin('base','mee_0',mee_0);

simOut=sim(simIn);

% N_t=length(simOut.F_req_B.Time);
T_vec=simOut.F_req_B.Time;

T_end=T_vec(end);

% FM=[simOut.F_req_B.Data';simOut.M_req.Data'];
% FM=simOut.F_req_B.Data'.^2;
% C=[Force_Vectors;Moment_Vectors];
% maxIter=10;
% options = optimoptions('lsqnonlin','Algorithm','levenberg-marquardt','MaxIterations',maxIter,'Display','none');
% LB=zeros(N_sat,1);
% UB=params.max_f*ones(N_sat,1);
%
% guess=zeros(N_sat,1);
%
% Uss=zeros(N_sat,N_t);
%
% mark_err=0;

% for i=1:N_t
%
%     b=FM(:,i);
%
%     x0=guess;
%
%     fun=@(x)(C*x-b);
%
%     [Uss(:,i),error]=lsqnonlin(fun,x0,LB,UB,options);
%     if error>1e-2
%         mark_err=mark_err+1;
%     end
%
%     guess=Uss(:,i);
%
% end

% int_Fs=trapz(T_vec,FM,2);
% effort=simOut.effort.Data;
% reach_fac=norm(simOut.R.Data(1:5));
% detumble_fac=simOut.omega.Data;
% detumble_fac=0;
% mark_err=0;

% 1 year=31536000

% cost=sum(int_Fs)*(1+var(int_Fs)/1e10)*(1+5*mark_err/N_t)^5*(1+reach_fac)^5*(1+detumble_fac)^2*(1+T_end*3.171e-8)^0.8;


if params.strategy==1


    % cost=effort*time_cost^0.2;

    cost=T_end/31536000;

elseif params.strategy==2

    effort=simOut.effort.Data;

    time_cost=1;

    %%%%
    max_year=10;
    T_end_year=T_end/31536000;
    if T_end_year>max_year
        time_cost=1+(T_end-max_year);
    end
    %%%%%

%     cost=effort*T_end^0.1*time_cost^0.2;
    cost=effort*time_cost^0.2;
end








end