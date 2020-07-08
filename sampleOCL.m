function [solution,times,ocp] = sampleOCL

clc
clear
close all
% global flag

% saved_ig=load('ig.mat');



MAX_TIME = 100000;
% % 
ocp = ocl.Problem([], @varsfun, @daefun, ...
    'gridcosts', @gridcosts,...
    'N', 10);
% 
%   ocp = ocl.Problem([], @varsfun, @daefun, ...
%     'gridcosts', @gridcosts, ...
%     'gridconstraints', @gridconstraints, ...
%     'N', 50);


mu=3.986005*10^5;
Re=6378.14;

orbit1.a=15*Re;
orbit1.e=0;
orbit1.incl=deg2rad(0);
orbit1.omega=deg2rad(0);
orbit1.RA=deg2rad(0);
orbit1.theta=deg2rad(0);


orbit2.a=11*Re;
orbit2.e=0.6;
orbit2.incl=deg2rad(25);
orbit2.omega=deg2rad(0);
orbit2.RA=deg2rad(0);
orbit2.theta=deg2rad(180);



ocp.setParameter('mu', mu);
ocp.setParameter('Re', Re);

ocp.setBounds('time', 0, MAX_TIME);

% ocp.setInitialBounds( 'x',   saved_ig.X_trajectory(1,1));
% ocp.setInitialBounds( 'y',   saved_ig.X_trajectory(2,1));
% ocp.setInitialBounds( 'z',   saved_ig.X_trajectory(3,1));
% ocp.setInitialBounds( 'xdot',   saved_ig.X_trajectory(4,1));
% ocp.setInitialBounds( 'ydot',   saved_ig.X_trajectory(5,1));
% ocp.setInitialBounds( 'zdot',   saved_ig.X_trajectory(6,1));
% 
% ocp.setEndBounds( 'x',   saved_ig.X_trajectory(1,end));
% ocp.setEndBounds( 'y',   saved_ig.X_trajectory(2,end));
% ocp.setEndBounds( 'z',   saved_ig.X_trajectory(3,end));
% ocp.setEndBounds( 'xdot',   saved_ig.X_trajectory(4,end));
% ocp.setEndBounds( 'ydot',   saved_ig.X_trajectory(5,end));
% ocp.setEndBounds( 'zdot',   saved_ig.X_trajectory(6,end));


oe1=[orbit1.a orbit1.e orbit1.incl orbit1.omega orbit1.RA orbit1.theta];
oe2=[orbit2.a orbit2.e orbit2.incl orbit2.omega orbit2.RA orbit2.theta];

mee1=oe2mee(oe1,mu);
mee2=oe2mee(oe2,mu);

ocp.setInitialBounds( 'mee1',mee1(1));
ocp.setInitialBounds( 'mee2',mee1(2));
ocp.setInitialBounds( 'mee3',mee1(3));
ocp.setInitialBounds( 'mee4',mee1(4));
ocp.setInitialBounds( 'mee5',mee1(5));
ocp.setInitialBounds( 'mee6',mee1(6));



ocp.setEndBounds( 'mee1',mee2(1));
ocp.setEndBounds( 'mee2',mee2(2));
ocp.setEndBounds( 'mee3',mee2(3));
ocp.setEndBounds( 'mee4',mee2(4));
ocp.setEndBounds( 'mee5',mee2(5));
% ocp.setEndBounds( 'mee6',mee2(6));

% initialGuess    = ocp.getInitialGuess()
% N_i=length(initialGuess.states.x.value)
% N_c=length(initialGuess.controls.dFr.value)

% initialGuess.states.x.set(-initialGuess.states.x.value*2);
% initialGuess.states.y.set(-initialGuess.states.x.value*2);
% initialGuess.states.time
% initialGuess.states.x.value
% cvec=initialGuess.controls.dFs.value;
% cvec(1)=-1;
% cvec(end-1)=1;
% initialGuess.controls.dFw.set(cvec);

% initialGuess.states.x.set(saved_ig.X_trajectory(1,:));
% initialGuess.states.y.set(saved_ig.X_trajectory(2,:));
% initialGuess.states.z.set(saved_ig.X_trajectory(3,:));
% initialGuess.states.xdot.set(saved_ig.X_trajectory(4,:));
% initialGuess.states.ydot.set(saved_ig.X_trajectory(5,:));
% initialGuess.states.zdot.set(saved_ig.X_trajectory(6,:));
% 
% cvec=initialGuess.controls.dFr.value;
% cvec(1)=saved_ig.impulse1(1);
% cvec(end-1)=saved_ig.impulse2(1);
% initialGuess.controls.dFr.set(cvec);
% 
% cvec=initialGuess.controls.dFs.value;
% cvec(1)=saved_ig.impulse1(2);
% cvec(end-1)=saved_ig.impulse2(2);
% initialGuess.controls.dFs.set(cvec);
% 
% cvec=initialGuess.controls.dFw.value;
% cvec(1)=saved_ig.impulse1(3);
% cvec(end-1)=saved_ig.impulse2(3);
% initialGuess.controls.dFw.set(cvec);



%
%
%   initialGuess.states.x.set( [63781.4000000000,63649.0866925162,63507.3111579282,63356.1326308643,63195.6117380831,63025.8104837438,62846.7922344723,62658.6217042281,62461.3649389740,62255.0893011522,62039.8634539699,61815.7573454974,61582.8421925821,61341.1904645811,61090.8758669175,60831.9733244606,60564.5589647365,60288.7101009700,60004.5052149629,59712.0239398111,59411.3470424639,59102.5564061295,58785.7350125303,58460.9669240098,58128.3372654970,57787.9322063303,57439.8389419445,57084.1456754249,56720.9415989321,56350.3168750001,55972.3626177133,55587.1708737636,55194.8346033930,54795.4476612244,54389.1047769850,53975.9015361252,53555.9343603369,53129.3004879757,52696.0979543890,52256.4255721554,51810.3829112386,51358.0702790584,50899.5887004844,50435.0398977550,49964.5262703253,49488.1508746480,49006.0174038921,48518.2301676006,48024.8940712933,47526.1145960180,47021.9977778525]);
%   initialGuess.states.y.set([0,777.658982239087,1552.08525351513,2323.16392024137,3090.78105358399,3854.82370629364,4615.17992932101,5371.73878821418,6124.39037929505,6873.02584561279,7617.53739267185,8357.81830393221,9093.76295607979,9825.26683406470,10552.2265459054,11274.5398372561,11992.1056057367,12704.8239150211,13412.5960086843,14115.3243238048,14812.9125043206,15505.2654141382,16192.2891499907,16873.8910540458,17549.9797262597,18220.4650364768,18885.2581362731,19544.2714705420,20197.4187888203,20844.6151563537,21485.7769649009,22120.8219432731,22749.6691676099,23372.2390713885,23988.4534551660,24598.2354960538,25201.5097569225,25798.2021953357,26388.2401722137,26971.5524602238,27548.0692518983,28117.7221674775,28680.4442624791,29236.1700349909,29784.8354326878,30326.3778595722,30860.7361824365,31387.8507370478,31907.6633340541,32420.1172646116,32925.1573057326]);
%   initialGuess.states.y.value
% initialGuess.controls.dFs.set(0);
% initialGuess.controls.dFr.set(0);
% initialGuess.controls.dFw.set(0);
%

% Solve OCP
[solution,times] = ocp.solve;




% 

mee_ar=[solution.states.mee1.value;solution.states.mee2.value;solution.states.mee3.value;solution.states.mee4.value;solution.states.mee5.value;solution.states.mee6.value];
N=length(solution.states.mee1.value);
R_ar=zeros(3,N);
for i=1:N
   
    [r,v]=mee2rv(mee_ar(:,i),mu);
    R_ar(:,i)=r;
    
end

% 
% figure
% subplot(6,1,1)
% grid minor
% plot(times.states.value,solution.states.a.value/Re)
% ylabel('a')
% 
% subplot(6,1,2)
% grid minor
% plot(times.states.value,solution.states.e.value)
% ylabel('e')
% 
% subplot(6,1,3)
% grid minor
% plot(times.states.value,solution.states.incl.value)
% ylabel('i')
% 
% subplot(6,1,4)
% grid minor
% plot(times.states.value,solution.states.RA.value)
% ylabel('\Omega')
% 
% subplot(6,1,5)
% grid minor
% plot(times.states.value,solution.states.omega.value)
% ylabel('\omega')
% 
% subplot(6,1,6)
% grid minor
% plot(times.states.value,solution.states.MA.value)
% ylabel('M')
% 
% 
% 
% 
% 
% 
% 
figure
subplot(3,1,1)
grid minor
plot(times.controls.value,solution.controls.Fr.value)
subplot(3,1,2)
grid minor
plot(times.controls.value,solution.controls.Fs.value)
subplot(3,1,3)
grid minor
plot(times.controls.value,solution.controls.Fw.value)
% 
% 
figure
hold on
axis equal
grid minor
view(25,45)
plot_earth
plot3(R_ar(1,:),R_ar(2,:),R_ar(3,:),'b')





end

function varsfun(sh)

sh.addState('mee1'); 
sh.addState('mee2'); 
sh.addState('mee3'); 
sh.addState('mee4'); 
sh.addState('mee5'); 
sh.addState('mee6'); 


sh.addState('sFr');  % Force x[N]
sh.addState('sFs');  % Force y[N]
sh.addState('sFw');  % Force y[N]

sh.addState('time', 'lb', 0, 'ub', 100000);  % time [s]

sh.addControl('Fr', 'lb', -0.01, 'ub', 0.01);  % Force x[N]
sh.addControl('Fs', 'lb', -0.01, 'ub', 0.01);  % Force y[N]
sh.addControl('Fw', 'lb', -0.01, 'ub', 0.01);  % Force z[N]

sh.addParameter('mu');        % mu
sh.addParameter('Re');


end

function daefun(sh,x,~,u,p)

mu=3.986005*10^5;


pmee = x.mee1;
fmee = x.mee2;
gmee = x.mee3;
hmee = x.mee4;
kmee = x.mee5;
lmee = x.mee6;



% compute modified equinoctial elements equations of motion

sinl = sin(lmee);

cosl = cos(lmee);

wmee = 1.0 + fmee * cosl + gmee * sinl;

sesqr = 1.0 + hmee * hmee + kmee * kmee;





mu=3.986005*10^5;
Re=6378.14;

%%%%%%
smovrp = sqrt(mu / pmee);

tani2s = hmee^2 + kmee^2;

cosl = cos(lmee);

sinl = sin(lmee);

wmee = 1 + fmee * cosl + gmee * sinl;

radius = pmee / wmee;

hsmks = hmee^2 - kmee^2;

ssqrd = 1 + tani2s;

% compute eci position vector

r_1 = radius * (cosl + hsmks * cosl + 2 * hmee * kmee * sinl) / ssqrd;

r_2 = radius * (sinl - hsmks * sinl + 2 * hmee * kmee * cosl) / ssqrd;

r_3 = 2 * radius * (hmee * sinl - kmee * cosl) / ssqrd;
%%%%%%

r=sqrt(r_1^2+r_2^2+r_3^2);

c=1;
c3=0;
if r<10*Re
    if u.Fr<0
    c=-1;
    c3=1000;
    end
end


sh.setODE( 'mee1', (2.0 * pmee / wmee) * sqrt(pmee / mu) * u.Fs);
sh.setODE( 'mee2', sqrt(pmee / mu) * (c*u.Fr*sinl+((wmee + 1.0) * cosl + fmee) * (u.Fs / wmee) ...
    -(hmee * sinl - kmee * cosl) * (gmee * u.Fw / wmee)));
sh.setODE( 'mee3', sqrt(pmee / mu) * (-c*u.Fr*cosl+((wmee + 1.0) * sinl + gmee) * (u.Fs / wmee) ...
    -(hmee * sinl - kmee * cosl) * (fmee * u.Fw / wmee)));
sh.setODE( 'mee4', sqrt(pmee / mu) * (sesqr * u.Fw / (2.0 * wmee)) * cosl);
sh.setODE( 'mee5', sqrt(pmee / mu) * (sesqr * u.Fw / (2.0 * wmee)) * sinl);
sh.setODE( 'mee6', sqrt(mu * pmee) * (wmee / pmee)^2 + (1.0 / wmee) * sqrt(pmee / mu) ...
    * (hmee * sinl - kmee * cosl) * u.Fw);


sh.setODE('sFr', abs(c3+u.Fr));
sh.setODE('sFs', abs(u.Fs));
sh.setODE('sFw', abs(u.Fw));
sh.setODE('time', 1);
end

function gridcosts(ch,k,K,x,~)

% global flag


% if k==1
%     
%     flag=0;
% end



% compute eci velocity vector

% v(1) = - smovrp * (sinl + hsmks * sinl - 2 * hmee * kmee * cosl + gmee ...
%        - 2 * fmee * hmee * kmee + hsmks * gmee) / ssqrd;
% 
% v(2) = - smovrp * (-cosl + hsmks * cosl + 2 * hmee * kmee * sinl - fmee ...
%        + 2 * gmee * hmee * kmee + hsmks * fmee) / ssqrd;
% 
% v(3) = 2 * smovrp * (hmee * cosl + kmee * sinl + fmee * hmee ...
%        + gmee * kmee) / ssqrd;
% %%%%
% r_=norm(r);

% if flag==0

% r_=sqrt(r_1^2+r_2^2+r_3^2);
% if r_<Re+300
%     ch.add(-sign(r_-6.67814e3)*(r_-6.67814e3)^2*1e-4);
% end
% if -sign(r_-6.67814e3)*(r_-6.67814e3)^2>0
%    flag=1; 
% end

% end

    

if k==K
    
%     R=[x.x x.y x.z];
%     R_=norm(R);
%     ch.add((R_-102050.24)^2)
%     V=[x.xdot x.ydot x.zdot];
%     V_=norm(V);
%     ch.add((V_-1.97634110924459)^2);
% 
%     fuel_cost=;
    

% ch.add(x.time)
ch.add(x.sFr^2+x.sFs^2+x.sFw^2);
    
end


end

function gridconstraints(ch,~,~,x,p)

% R=[x.x x.y x.z];
% V=[x.xdot x.ydot x.zdot];
% oe = oe_from_sv(R,V,p.mu);
% e=oe(2);
% 
% ch.add(e,'<=',0.99);
% ch.add(e,'>=',0);

mu=3.986005*10^5;
Re=6378.14;

pmee = x.mee1.value;
fmee = x.mee2.value;
gmee = x.mee3.value;
hmee = x.mee4.value;
kmee = x.mee5.value;
lmee = x.mee6.value;

% this_mee=[pmee fmee gmee hmee kmee lmee];
% [r,v]=mee2rv(this_mee,mu);
%%%%%%
smovrp = sqrt(mu / pmee);

tani2s = hmee^2 + kmee^2;

cosl = cos(lmee);

sinl = sin(lmee);

wmee = 1 + fmee * cosl + gmee * sinl;

radius = pmee / wmee;

hsmks = hmee^2 - kmee^2;

ssqrd = 1 + tani2s;

% compute eci position vector

r_1 = radius * (cosl + hsmks * cosl + 2 * hmee * kmee * sinl) / ssqrd;

r_2 = radius * (sinl - hsmks * sinl + 2 * hmee * kmee * cosl) / ssqrd;

r_3 = 2 * radius * (hmee * sinl - kmee * cosl) / ssqrd;

v_1 = - smovrp * (sinl + hsmks * sinl - 2 * hmee * kmee * cosl + gmee ...
       - 2 * fmee * hmee * kmee + hsmks * gmee) / ssqrd;

v_2 = - smovrp * (-cosl + hsmks * cosl + 2 * hmee * kmee * sinl - fmee ...
       + 2 * gmee * hmee * kmee + hsmks * fmee) / ssqrd;

v_3 = 2 * smovrp * (hmee * cosl + kmee * sinl + fmee * hmee ...
       + gmee * kmee) / ssqrd;

R=[r_1 r_2 r_3];
V=[v_1 v_2 v_3];
R_=sqrt(r_1^2+r_2^2+r_3^2);
V_=sqrt(v_1^2+v_2^2+v_3^2);

ang1=acos(dot(R,V)/R_/V_);
  
  ch.add(ang1,'<=',2.5);
  ch.add(R_,'>=',14*Re);

  
  
  
end