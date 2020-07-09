function [solution,times,ocp] = sampleOCL

clc
clear
close all

saved_ig=load('ig.mat');

MAX_TIME = 100000;
% 
ocp = ocl.Problem([], @varsfun, @daefun, ...
    'gridcosts', @gridcosts,...
    'N', 30);

%   ocp = ocl.Problem([], @varsfun, @daefun, ...
%     'gridcosts', @gridcosts, ...
%     'gridconstraints', @gridconstraints, ...
%     'N', 50);


mu=3.986005*10^5;
Re=6378.14;

ocp.setParameter('mu', mu);
ocp.setParameter('Re', Re);

ocp.setBounds('time', 0, MAX_TIME);

ocp.setInitialBounds( 'x',   saved_ig.X_trajectory(1,1));
ocp.setInitialBounds( 'y',   saved_ig.X_trajectory(2,1));
ocp.setInitialBounds( 'z',   saved_ig.X_trajectory(3,1));
ocp.setInitialBounds( 'xdot',   saved_ig.X_trajectory(4,1));
ocp.setInitialBounds( 'ydot',   saved_ig.X_trajectory(5,1));
ocp.setInitialBounds( 'zdot',   saved_ig.X_trajectory(6,1));

% ocp.setEndBounds( 'x',   saved_ig.X_trajectory(1,end));
% ocp.setEndBounds( 'y',   saved_ig.X_trajectory(2,end));
% ocp.setEndBounds( 'z',   saved_ig.X_trajectory(3,end));
% ocp.setEndBounds( 'xdot',   saved_ig.X_trajectory(4,end));
% ocp.setEndBounds( 'ydot',   saved_ig.X_trajectory(5,end));
% ocp.setEndBounds( 'zdot',   saved_ig.X_trajectory(6,end));

initialGuess    = ocp.getInitialGuess();
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

initialGuess.states.x.set(saved_ig.X_trajectory(1,:));
initialGuess.states.y.set(saved_ig.X_trajectory(2,:));
initialGuess.states.z.set(saved_ig.X_trajectory(3,:));
initialGuess.states.xdot.set(saved_ig.X_trajectory(4,:));
initialGuess.states.ydot.set(saved_ig.X_trajectory(5,:));
initialGuess.states.zdot.set(saved_ig.X_trajectory(6,:));

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
[solution,times] = ocp.solve(initialGuess);


figure
hold on
axis equal
grid minor
%   plot(times.states.value,solution.states.x.value)
  plot3(0,0,0,'ro')
% plot_earth
plot3(solution.states.x.value,solution.states.y.value,solution.states.z.value,'b')
plot3(solution.states.x.value,solution.states.y.value,solution.states.z.value,'k.')
view(25,45)
% figure
% subplot(3,1,1)
% grid minor
% plot(times.controls.value,solution.controls.dFr.value)
% subplot(3,1,2)
% grid minor
% plot(times.controls.value,solution.controls.dFs.value)
% subplot(3,1,3)
% grid minor
% plot(times.controls.value,solution.controls.dFw.value)

figure
grid minor
plot(times.controls.value,solution.controls.psi.value)



T=times.states.value;
X=solution.states.x.value;
Y=solution.states.y.value;
Z=solution.states.z.value;
Xdot=solution.states.xdot.value;
Ydot=solution.states.ydot.value;
Zdot=solution.states.ydot.value;
N=length(X);

for i=1:N
   r=[X(i) Y(i) Z(i)];
   v=[Xdot(i) Ydot(i) Zdot(i)];
   r_(i)=norm(r);
   v_(i)=norm(v);
%    indicator(i)=norm(cross(r,v));
indicator(i)=acosd(-dot(r,v)/(norm(r))/norm(v));
end




figure
subplot(3,1,1)
grid
plot(T,r_/Re)
subplot(3,1,2)
grid
plot(T,v_)
subplot(3,1,3)
grid
plot(T,indicator)

end

function varsfun(sh)
sh.addState('x');   % position x[m]
sh.addState('xdot');   % position x[m]
sh.addState('y');   % position x[m]
sh.addState('ydot');   % position x[m]
sh.addState('z');   % position x[m]
sh.addState('zdot');   % position x[m]

% sh.addState('Fr');  % Force x[N]
% sh.addState('Fs');  % Force y[N]
% sh.addState('Fw');  % Force y[N]

sh.addState('time', 'lb', 0, 'ub', 100000);  % time [s]

sh.addControl('psi', 'lb', -0.1745, 'ub', 0.1745);  % Force x[N]


sh.addParameter('mu');        % mu
sh.addParameter('Re');


end

function daefun(sh,x,~,u,p)
sh.setODE( 'x', x.xdot);
sh.setODE( 'y', x.ydot);
sh.setODE( 'z', x.zdot);
c1=-p.mu/((sqrt(x.x^2+x.y^2+x.z^2))^3);

% r=sqrt(x.x^2+x.y^2+x.z^2);



% R_=sqrt(x.x^2+x.y^2+x.z^2);
% V_=sqrt(x.xdot^2+x.ydot^2+x.zdot^2);
% dot_RV=x.x*x.xdot+x.y*x.ydot+x.z*x.zdot;
% ang1=acos(-dot_RV/R_/V_);
% 
% if ang1<0.78539
%     c=-10;
% end

Thrust=0.01;
u_Fr=sin(u.psi)*Thrust;
u_Fs=cos(u.psi)*Thrust;
u_Fw=0;

force_vec_cart=rsw2xyz([u_Fr;u_Fs;u_Fw],[x.x;x.y;x.z],[x.xdot;x.ydot;x.zdot]);




sh.setODE('xdot', c1*x.x+force_vec_cart(1));
sh.setODE('ydot', c1*x.y+force_vec_cart(2));
sh.setODE('zdot', c1*x.z+force_vec_cart(3));

% sh.setODE('Fr', abs(u.dFr));
% sh.setODE('Fs', abs(u.dFs));
% sh.setODE('Fw', abs(u.dFw));
sh.setODE('time', 1);
end

function gridcosts(ch,k,K,x,~)





if k==K
%     mu=3.986005*10^5;
Re=6378.14;
%     
%     r=[x.x x.y x.z];
% v=[x.xdot x.ydot x.zdot];
% 
% 
% 
% 
rmag = sqrt(x.x^2+x.y^2+x.z^2);
% 
% vmag = sqrt(x.xdot^2+x.ydot^2+x.zdot^2);
% 
%     fuel_cost=x.Fr^2+x.Fs^2+x.Fw^2;
%     ch.add(fuel_cost);
%     
%     ch.add((vmag-x.ydot)^2+(2.499895-x.ydot)^2);
    ch.add((rmag-10*Re)^2);

% ch.add(x.time)

end


end

function gridconstraints(ch,~,~,x,p)
Re=6378.14;
% R=[x.x x.y x.z];
% V=[x.xdot x.ydot x.zdot];
% oe = oe_from_sv(R,V,p.mu);
% e=oe(2);
% 
% ch.add(e,'<=',0.99);
% ch.add(e,'>=',0);
% 
% ch.add(sqrt(x.x^2+x.y^2+x.z^2),'>=',10*Re);

R=[x.x x.y x.z];
V=[x.xdot x.ydot x.zdot];
R_=sqrt(x.x^2+x.y^2+x.z^2);
V_=sqrt(x.xdot^2+x.ydot^2+x.zdot^2);
dot_RV=x.x*x.xdot+x.y*x.ydot+x.z*x.zdot;
ang1=acos(dot_RV/R_/V_);
  
  ch.add(ang1,'<=',2.5);
  
end