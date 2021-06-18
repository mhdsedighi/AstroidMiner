clc; clear; close all
% addpath OptimTraj
% addpath chebfun
load('params')



% % % 10 8 6 m
% % % nickel density
% % % around sun
% % % 10-1 rad/s
% % % 
% % % 169581 kg
% % % 4.5 3.45 1.5 m
% % % Ixx 480e3
% % % Iyy 763116
% % % Izz 1090492
% % % 12 cube sast min 8
% % % omega=0.06 0.04 0.03 rad/s
% % % thrusters 0.3N 0.25N 0.2N (0.5 N)



%parameters
% params.mu = 3.986005*10^5;
% params.mu = 1.32712440018 *10^11;
% Re=6378.14;


c_rad2deg=180/pi;


%%%%%%%%%%%%%%%%%%%
AU=1.496e+8;

a_0=1.1896*AU;
e_0=0.1902;
incl_0=deg2rad(5.8837);
omega_0=deg2rad(211.43);
RA_0=deg2rad(251.62);
theta_0=deg2rad(0);


% a_0=1.1896*AU;
% e_0=0;
% incl_0=deg2rad(0);
% omega_0=deg2rad(0);
% RA_0=deg2rad(0);
% theta_0=deg2rad(0);

a_f=149598023;
e_f=0.0167086;
incl_f=deg2rad(7.155);
omega_f=deg2rad(114.20783);
RA_f=deg2rad(-11.26064);
theta_f=deg2rad(0);

min_revolution=1;
max_revolution=10;

min_days=0;
max_days=700;

oe_0=[a_0 e_0 incl_0 omega_0 RA_0 theta_0];
oe_f=[a_f e_f incl_f omega_f RA_f theta_f];
mee_0=oe2mee(oe_0,params.mu)';
mee_f=oe2mee(oe_f,params.mu)';


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

eul_0=deg2rad([20 30 40]);
rotation_period=7.627; %hours
spin_speed=(2*pi)/(7.63*3600);
spin_vector=[2;1;0.3];
pqr_0=spin_speed*spin_vector/norm(spin_vector)';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% N_sat=8;
% azimuths=[-45 45 180+45   180-45   90         90       0      0 30];
% elevations=[0 0    0         0     90+30      90-30    -90+30 -90-30 -90];
% gammas=zeros(1,N_sat);
% lambdas=zeros(1,N_sat);



%%%%%%
N_sat=30;
azimuths=rand_gen(1,N_sat,0,360);
elevations=rand_gen(1,N_sat,-90,90);
gammas=zeros(1,N_sat);
lambdas=zeros(1,N_sat);


%%%%%%

[Force_Vectors,Moment_Vectors]=rigid_positioning(params,N_sat,azimuths,elevations,gammas,lambdas);
Force_Vectors=Force_Vectors';
Moment_Vectors=Moment_Vectors';



gain1=1;
gain2=1;
gain3=1;
gain4=1;
gain5=1;


load solve_path

mee_his=soln(end).grid.state;
% mee_end=mee_his(:,end);

mee1_span=[mee_his(1,end) mee_his(1,1)];
gain_span_mat=ones(5,2);


% oe = mee2oe(mee_end',params.mu)

t_f=T(end);
% 
T=[T T(end)+1000 T(end)+2000];
mee_his=[mee_his mee_his(:,end) mee_his(:,end)];
% 
% mee_his_stop=mee_his(:,2);
% 
% [~,n_time]=size(mee_his);
% for i=2:n_time
% mee_his(:,i)=mee_his_stop;
% end
% m6_after=mee_his(6,end)+(mee_his(6,end)-mee_his(6,end-1))*1000/(T(end)-T(end-1));


% T=[T T(end)+1000];
% 
% mee_his=[mee_his mee_his(:,end)];

% mee_his(6,end)=m6_after;



% set_param('test_pid_exact_1', 'MinimalZcImpactIntegration', 'on')
% set_param('test_pid7', 'MinimalZcImpactIntegration', 'on')


Thrust_max=1e-5;
max_f=Thrust_max*1e11;

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

max_F_available=max_F_available*0.8
max_M_available=max_M_available*0.8








