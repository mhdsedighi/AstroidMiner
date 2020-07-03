function [solution,times,ocp] = sampleOCL

clc
clear
close all

MAX_TIME = 100000;

ocp = ocl.Problem([], @varsfun, @daefun, ...
    'gridcosts', @gridcosts,...
    'N', 200);

%   ocp = ocl.Problem([], @varsfun, @daefun, ...
%     'gridcosts', @gridcosts, ...
%     'gridconstraints', @gridconstraints, ...
%     'N', 50);


mu=3.986005*10^5;
Re=6378.14;

ocp.setParameter('mu', mu);
ocp.setParameter('Re', Re);

ocp.setBounds('time', 0, MAX_TIME);

ocp.setInitialBounds( 'x',   6.3781e+04);
ocp.setInitialBounds( 'y',   0);
ocp.setInitialBounds( 'z',   0);
ocp.setInitialBounds( 'xdot',   0);
ocp.setInitialBounds( 'ydot',   2.4999);
ocp.setInitialBounds( 'zdot',   0);

ocp.setEndBounds( 'x',   0);
ocp.setEndBounds( 'y',   5.740326e+04);
ocp.setEndBounds( 'z',   0);
ocp.setEndBounds( 'xdot',   -2.6351);
ocp.setEndBounds( 'ydot',   0);
ocp.setEndBounds( 'zdot',   0);

%   initialGuess    = ocp.getInitialGuess();
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


figure
hold on
axis equal
grid minor
%   plot(times.states.value,solution.states.x.value)
%   plot3(0,0,0,'ro')
plot_earth
plot3(solution.states.x.value,solution.states.y.value,solution.states.z.value,'k.')
view(25,45)
figure
subplot(3,1,1)
grid minor
plot(times.controls.value,solution.controls.dFr.value)
subplot(3,1,2)
grid minor
plot(times.controls.value,solution.controls.dFs.value)
subplot(3,1,3)
grid minor
plot(times.controls.value,solution.controls.dFw.value)


end

function varsfun(sh)
sh.addState('x');   % position x[m]
sh.addState('xdot');   % position x[m]
sh.addState('y');   % position x[m]
sh.addState('ydot');   % position x[m]
sh.addState('z');   % position x[m]
sh.addState('zdot');   % position x[m]

sh.addState('Fr');  % Force x[N]
sh.addState('Fs');  % Force y[N]
sh.addState('Fw');  % Force y[N]

sh.addState('time', 'lb', 0, 'ub', 100000);  % time [s]

sh.addControl('dFr', 'lb', -0.1, 'ub', 0.1);  % Force x[N]
sh.addControl('dFs', 'lb', -0.1, 'ub', 0.1);  % Force y[N]
sh.addControl('dFw', 'lb', -0.1, 'ub', 0.1);  % Force z[N]

sh.addParameter('m');           % mass [kg]
sh.addParameter('A');           % section area car [m^2]
sh.addParameter('cd');          % drag coefficient [mini cooper 2008
sh.addParameter('rho');         % airdensity [kg/m^3]
sh.addParameter('Vmax');        % max speed [m/s]
sh.addParameter('road_bound');  % lane road relative to the middle lane [m]
sh.addParameter('Fmax');        % maximal force on the car [N]
sh.addParameter('mu');        % mu
sh.addParameter('Re');

end

function daefun(sh,x,~,u,p)
sh.setODE( 'x', x.xdot);
sh.setODE( 'y', x.ydot);
sh.setODE( 'z', x.zdot);
c1=-p.mu/((sqrt(x.x^2+x.y^2+x.z^2))^3);


force_vec_cart=rsw2xyz([u.dFr;u.dFs;u.dFw],[x.x;x.y;x.z],[x.xdot;x.ydot;x.zdot]);

sh.setODE('xdot', c1*x.x+force_vec_cart(1));
sh.setODE('ydot', c1*x.y+force_vec_cart(2));
sh.setODE('zdot', c1*x.z+force_vec_cart(3));

sh.setODE('Fr', abs(u.dFr));
sh.setODE('Fs', abs(u.dFs));
sh.setODE('Fw', abs(u.dFw));
sh.setODE('time', 1);
end

function gridcosts(ch,k,K,x,~)

if k==K
    
    % R=[x.x x.y x.z];
    % V=[x.xdot x.ydot x.zdot];
    % ch.add((R_-5.740326e+04)^2*(V_-2.6351)^2);
    fuel_cost=norm([x.Fr x.Fs x.Fw]);
    ch.add(fuel_cost^2);
    
end


end

function gridconstraints(ch,~,~,x,p)

%   ch.add(sqrt(x.x^2+x.y^2+x.z^2),'<=',p.Re+100);
end