

clc
% C=[1 2 3 4 5 -1;0 1 3 5 -2 -1;-5 9 3 2 -3 -3;0 0 0 0 -1 0];

N_sat=40;
% C=rand_gen(6,N_sat,-10,10);
% % % 
lambdas=rand_gen(1,N_sat,0,360);
phis=rand_gen(1,N_sat,-90,90);
alphas=rand_gen(1,N_sat,0,0);
betas=rand_gen(1,N_sat,0,0);

% params.a=435*2;
% params.b=300*2;
% params.c=200*2;


% N_sat=N_sat*2;
% lambdas=[lambdas lambdas];
% phis=[phis -phis];
% alphas=[alphas alphas];
% betas=[betas betas];


% N_sat=8;
% lambdas=[-45 45 180+45   180-45   100         90       30      0 30];
% phis=[0 0    0         0     90+30      90-30    -90+30 -90-30 -90];
% alphas=lambdas*0;
% betas=alphas;

quat=eul2quat(deg2rad([rand_gen(1,1,-90,90) rand_gen(1,1,-90,90) rand_gen(1,1,0,360)]));
% b=rand_gen(6,1,-100,100);

b=[-79584462.7435692;65048412.8999741;92866167.7808756;0.0729940089421569;0.0736050284089622;0.0706280985260851].*rand_gen(6,1,0.8,1.2);


[Force_Vectors,Moment_Vectors]=rigid_positioning(params,N_sat,lambdas,phis,alphas,betas);
c_mat=control_mat(Force_Vectors,Moment_Vectors,quat,N_sat);

C=c_mat;


% C1=C(1:3,:);
% C2=C(4:6,:);
% 
% 
% 
% 
% 
% lb=zeros(N_sat,1);
% ub=ones(N_sat,1)*inf;
% [x,resnorm,residual,exitflag,output,beta] = lsqlin(C,d,A,b,[],[],lb,ub);


% C=C(1:3,:);
% b=b(1:3,:);


% b(4:6,:)=zeros(3,1);
% b(1:3,:)=zeros(3,1);

% C=C(4:6,:);
% b=b(4:6,:);


% C(4:6,:)=C(4:6,:)*0;
% b(4:6,:)=b(4:6,:)*0;


% C(1:3,:)=C(1:3,:)*0;
% b(1:3,:)=b(1:3,:)*0;


% % % 
% % % % % C=[1 2 3 4;0 1 3 5];
% % % % b=[10;20;-1;0;0;2];
% % % 

% options = optimset('TolX',1e-20);
% options.MaxIter=1e5;
% [x,resnorm,residual,exitflag,output,beta] = lsqnonneg(C,b,options);

% % [x,flag,relres,iter,resvec,lsvec] = lsqr(C,b);
% % lb=zeros(N_sat,1);
% % ub=ones(N_sat,1)*inf;
% % x = lsqlin(C,b,[],[],[],[],lb,ub);
% x=nnls(C,b)

% x
% C*x-b


f=ones(1,N_sat);
lb=zeros(N_sat,1);
ub=ones(N_sat,1)*inf;
options = optimset('TolX',1e-20);
options.MaxIter=200;
options.Display='none';
[x,fval,exitflag] = linprog(f,[],[],C,b,lb,ub,options);


if exitflag~=1
    
    out=1e5;
else
    out=0;
    
end

out

codegen -report new_linprog -args {f,C,b,lb,ub}



