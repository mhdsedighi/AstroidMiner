clc
warning('off','all')

N_sat=25;
azimuths=rand_gen(1,N_sat,0,360);
elevations=rand_gen(1,N_sat,-90,90);
gammas=zeros(1,N_sat);
lambdas=zeros(1,N_sat);
[Force_Vectors,Moment_Vectors]=rigid_positioning(params,N_sat,azimuths,elevations,gammas,lambdas);
Force_Vectors=Force_Vectors';
Moment_Vectors=Moment_Vectors';



simout=sim('model_5_exact.slx');


N_t=length(simout.F_req_B.Time);
T_vec=simout.F_req_B.Time;



FM=[simout.F_req_B.Data';simout.M_req.Data'];
C=[Force_Vectors;Moment_Vectors];
maxIter=20;
options = optimoptions('lsqnonlin','Algorithm','levenberg-marquardt','MaxIterations',maxIter,'Display','none');
LB=zeros(N_sat,1);
UB=max_f*ones(N_sat,1);

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
reach_fac=norm(simout.R.Data(1:5));
detumble_fac=simout.omega.Data;

cost_F=sum(int_Fs)*(1+var(int_Fs)/1e10)*(1+mark_err/N_t)*(1+reach_fac)^2*(1+detumble_fac)^2;


