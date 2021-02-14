
clc

a=[1 1 1;1 2 -1];

fun=@(x)(a*x-[10;10]);

x0=[1 2 3]';

LB=[0 0 0]';
UB=[1000 1000 1000]';

options = optimoptions('lsqnonlin','Algorithm','levenberg-marquardt');

x_opt = lsqnonlin(fun,x0,LB,UB,options)

fun(x_opt)

a*x_opt-[10;10]




clc


N_sat=40;

azimuths=rand_gen(1,N_sat,0,360);
elevations=rand_gen(1,N_sat,-90,90);
gammas=rand_gen(1,N_sat,0,0);
lambdas=rand_gen(1,N_sat,0,0);





quat=eul2quat(deg2rad([rand_gen(1,1,-90,90) rand_gen(1,1,-90,90) rand_gen(1,1,0,360)]));


b=[-79584462.7435692;65048412.8999741;92866167.7808756;0.0729940089421569;0.0736050284089622;0.0706280985260851].*rand_gen(6,1,0.8,1.2);
b=[-7.7435692;6.8941;7.7808756;0.0729940089421569;0.0736050284089622;0.0706280985260851].*rand_gen(6,1,0.8,1.2);


[Force_Vectors,Moment_Vectors]=rigid_positioning(params,N_sat,azimuths,elevations,gammas,lambdas);
c_mat=control_mat(Force_Vectors,Moment_Vectors,quat,N_sat);

C=c_mat;

options = optimoptions('lsqnonlin','Algorithm','levenberg-marquardt','MaxIterations',10000);
LB=zeros(N_sat,1);
UB=inf*ones(N_sat,1);

% f=ones(1,N_sat);
% [x0,fval,exitflag] = linprog(f,[],[],C,b,LB,UB)
% C*x0-b


fun=@(x)(C*x-b);

x0=zeros(N_sat,1);

x_opt = lsqnonlin(fun,x0,LB,UB,options)

C*x_opt-b





