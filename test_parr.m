
%
% parfor i=1:5
% simOut = sim('model_1');
% end

% mypool

poolobj = gcp;
% addAttachedFiles(poolobj,{'myFun1.m','myFun2.m'})

addAttachedFiles(poolobj,{'model_1.slx'});
parfevalOnAll(@load_system,0,'model_1');
% parfevalOnAll(@addpath);

rec=zeros(1,10);
parfor idx=1:10
    
    assignin('base','params',params);
    assignin('base','mee_0',mee_0);
    assignin('base','pqr_0',pqr_0);
    assignin('base','eul_0',eul_0);
    
    
    assignin('base','N_sat',N_sat);
    assignin('base','max_f',max_f);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    lambdas=rand_gen(1,N_sat,0,360);
    phis=rand_gen(1,N_sat,-90,90);
    alphas=zeros(1,N_sat);
    betas=zeros(1,N_sat);
    [Force_Vectors,Moment_Vectors]=rigid_positioning(params,N_sat,lambdas,phis,alphas,betas);
    Force_Vectors=Force_Vectors';
    Moment_Vectors=Moment_Vectors';
    
    max_F_available=[0 0;0 0;0 0];
    max_M_available=[0 0;0 0;0 0];
    
    
    for j=1:3
        for i=1:N_sat
            if Force_Vectors(j,i)>0
                max_F_available(j,1)=max_F_available(j,1)+max_f*Force_Vectors(j,i);
            else
                max_F_available(j,2)=max_F_available(j,2)+max_f*Force_Vectors(j,i);
            end
        end
    end
    
    for j=1:3
        for i=1:N_sat
            if Moment_Vectors(j,i)>0
                max_M_available(j,1)=max_M_available(j,1)+max_f*Moment_Vectors(j,i);
            else
                max_M_available(j,2)=max_M_available(j,2)+max_f*Moment_Vectors(j,i);
            end
        end
    end
    
    max_F_available=max_F_available*0.7
    max_M_available=max_M_available*0.7
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    assignin('base','Force_Vectors',Force_Vectors);
    assignin('base','Moment_Vectors',Moment_Vectors);
    assignin('base','max_F_available',max_F_available);
    assignin('base','max_M_available',max_M_available);
    
    
    simIn= Simulink.SimulationInput('model_1');
    simIn.setBlockParameter('asteroid/gain13','Gain',1);
    simOut = sim(simIn);
    
    rec(idx)=simOut.Ucost.Data;
    
end