% Copyright 2019 Jonas Koenemann, Moritz Diehl, University of Freiburg
% Copyright 2015-2018 Jonas Koennemanm, Giovanni Licitra
% Redistribution is permitted under the 3-Clause BSD License terms. Please
% ensure the above copyright notice is visible in any derived work.
%
function [solution,times,ocp] = racecar
  % Title: Race Car Problem Example
  %  Authors: Jonas Koenneman & Giovanni Licitra

  MAX_TIME = 1000;

  ocp = ocl.Problem([], @varsfun, @daefun, ...
    'gridcosts', @gridcosts, ...
    'gridconstraints', @gridconstraints, ...
    'N', 50);

  % parameters
  m    = 1;         % mass [kg]
  A    = 1;         % section area car [m^2]
  cd   = 0.35;      % drag coefficient [mini cooper 2008]
  rho  = 1.23;      % airdensity [kg/m^3]
  Vmax = 1;         % max velocity [m/s]
  Fmax   = 100;       % [N]
  road_bound = 0.4; % [m]
  mu=3.986005*10^5;

  ocp.setParameter('m'   , m);
  ocp.setParameter('A'   , A);
  ocp.setParameter('cd'  , cd);
  ocp.setParameter('rho' , rho);
  ocp.setParameter('Vmax', Vmax);
  ocp.setParameter('Fmax', Fmax);
  ocp.setParameter('road_bound', road_bound);
  ocp.setParameter('mu', mu);
  
  ocp.setBounds('time', 0, MAX_TIME);

  ocp.setInitialBounds( 'x',   1.2756e+04);
  ocp.setInitialBounds( 'y',   0);
  ocp.setInitialBounds( 'z',   100);
  ocp.setInitialBounds( 'xdot',   0);
  ocp.setInitialBounds( 'ydot',   5.5899);
  ocp.setInitialBounds( 'zdot',   0);
%   ocp.setInitialBounds('vx',   0.0);
%   ocp.setInitialBounds( 'y',   0.0);
%   ocp.setInitialBounds('vy',   0.0);

%   ocp.setEndBounds( 'x',  2*pi);
%   ocp.setEndBounds('vx',  0.0 );
%   ocp.setEndBounds( 'y',  0.0 );
%   ocp.setEndBounds('vy',  0.0 );

%   initialGuess    = ocp.getInitialGuess();
% 
%   % Initialize the middle lane
%   N        = length(initialGuess.states.x.value);
%   x_road   = linspace(0,2*pi,N);
%   y_center = sin(x_road);
%   initialGuess.states.x.set(x_road);
%   initialGuess.states.y.set(y_center);

  % Solve OCP
  [solution,times] = ocp.solve;
  
figure
hold on
%   plot(times.states.value,solution.states.x.value)
  plot3(0,0,0,'ro')
  plot3(solution.states.x.value,solution.states.y.value,solution.states.z.value,'k*')
  view(25,45)

% %   % Plot solution
% %   figure('units','normalized')
% %   subplot(3,2,1);hold on;grid on;
% %   plot(times.states.value,solution.states.x.value,'Color','b','LineWidth',1.5);
% %   plot(times.states.value,solution.states.y.value,'Color','r','LineWidth',1.5);
% %   ylabel('[m]');legend({'x','y'});
% % 
% %   subplot(3,2,3);hold on;grid on;
% %   vx = solution.states.vx.value;
% %   vy = solution.states.vy.value;
% %   V  = sqrt(vx.^2+vy.^2);
% % 
% %   plot(times.states.value,vx,'Color','b','LineWidth',1.5);
% %   plot(times.states.value,vy,'Color','r','LineWidth',1.5);
% %   plot(times.states.value,V,'Color','g','LineWidth',1.5);
% %   legend({'vx','vy','V'});
% %   plot(times.states.value,Vmax.*ones(1,length(times)),'Color','k','LineWidth',1.5,'LineStyle','-.')
% %   ylabel('[m/s]');
% % 
% %   subplot(3,2,5);hold on;grid on;
% %   plot(times.states.value,solution.states.Fx.value,'Color','b','LineWidth',1.5)
% %   plot(times.states.value,solution.states.Fy.value,'Color','r','LineWidth',1.5)
% %   legend({'Fx','Fy'});
% %   plot(times.states.value,-Fmax.*ones(1,length(times.states.value)),'Color','k','LineWidth',1.5,'LineStyle','-.')
% %   plot(times.states.value, Fmax.*ones(1,length(times.states.value)),'Color','k','LineWidth',1.5,'LineStyle','-.')
% %   ylabel('[N]');xlabel('time');
% % 
% %   % build street
% %   subplot(3,2,[2,4,6]);hold on;grid on;
% %   x_road   = linspace(0,2*pi,1000);
% %   y_center = sin(x_road);
% % 
% %   y_max = y_center + road_bound;
% %   y_min = y_center - road_bound;
% % 
% %   plot(x_road,y_center,'Color','k','LineWidth',0.5,'LineStyle','--');
% %   plot(x_road,y_min   ,'Color','k','LineWidth',0.5,'LineStyle','-');
% %   plot(x_road,y_max   ,'Color','k','LineWidth',0.5,'LineStyle','-');
% %   plot(solution.states.x.value,...
% %        solution.states.y.value,'Color','b','LineWidth',1.5);
% %   axis equal;xlabel('x[m]');ylabel('y[m]');
% % 
% %   % Show Animation
% %   animate(times.states.value,solution,x_road,y_center,y_min,y_max)

end

function varsfun(sh)
    sh.addState('x');   % position x[m]
    sh.addState('xdot');   % position x[m]
    sh.addState('y');   % position x[m]
    sh.addState('ydot');   % position x[m]
    sh.addState('z');   % position x[m]
    sh.addState('zdot');   % position x[m]
%   sh.addState('vx');  % velocity vx[m/s]
%   sh.addState('y');   % position y[m]
%   sh.addState('vy');  % velocity vy[m/s]

  sh.addState('Fx');  % Force x[N]
  sh.addState('Fy');  % Force y[N]
  sh.addState('Fz');  % Force y[N]
  
  sh.addState('time', 'lb', 0, 'ub', 10);  % time [s]

  sh.addControl('dFx', 'lb', -10, 'ub', 10);  % Force x[N]
  sh.addControl('dFy', 'lb', -10, 'ub', 10);  % Force y[N]
  sh.addControl('dFz', 'lb', -10, 'ub', 10);  % Force z[N]

  sh.addParameter('m');           % mass [kg]
  sh.addParameter('A');           % section area car [m^2]
  sh.addParameter('cd');          % drag coefficient [mini cooper 2008
  sh.addParameter('rho');         % airdensity [kg/m^3]
  sh.addParameter('Vmax');        % max speed [m/s]
  sh.addParameter('road_bound');  % lane road relative to the middle lane [m]
  sh.addParameter('Fmax');        % maximal force on the car [N]
  sh.addParameter('mu');        % mu
  
end

function daefun(sh,x,~,u,p)
  sh.setODE( 'x', x.xdot);
  sh.setODE( 'y', x.ydot);
  sh.setODE( 'z', x.zdot);
  c1=-p.mu/(sqrt(x.x^2+x.y^2+x.z^2))^3;
  sh.setODE('xdot', c1*x.x+u.dFx);
  sh.setODE('ydot', c1*x.y+u.dFy);
  sh.setODE('zdot', c1*x.z+u.dFz);  
  
  sh.setODE('Fx', u.dFx);
  sh.setODE('Fy', u.dFy);
  sh.setODE('Fz', u.dFz);  
  sh.setODE('time', 1);
end

function gridcosts(ch,k,K,x,~)
%   if k==K
    ch.add((sqrt(x.x^2+x.y^2+x.z^2)-1.0843e+04)^2);
%   end
end

function gridconstraints(ch,~,~,x,p)
  % speed constraint
%   ch.add(x.vx^2+x.vy^2, '<=', p.Vmax^2);

  % force constraint
  ch.add(x.Fx^2+x.Fy^2+x.Fz^2, '<=', p.Fmax^2);

%   % road bounds
%   y_center = sin(x.x);
%   y_max = y_center + 0.5*p.road_bound;
%   y_min = y_center - 0.5*p.road_bound;
%   ch.add(x.y,'<=',y_max);
%   ch.add(x.y,'>=',y_min);
end

function animate(time,solution,x_road,y_center,y_min,y_max)

  global testRun
  isTestRun = testRun;

  ts = time(2)-time(1);
  x_car = solution.states.x.value;
  y_car = solution.states.y.value;

  %% Initialize animation
  figure('units','normalized');hold on;grid on;
  car = plot(x_car(1),y_car(1),'Marker','pentagram','MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',15);
  carLine = plot(x_car(1),y_car(1),'Color','b','LineWidth',3);
  plot(x_road,y_center,'Color','k','LineWidth',1,'LineStyle','--');
  plot(x_road,y_min   ,'Color','k','LineWidth',2.0,'LineStyle','-');
  plot(x_road,y_max   ,'Color','k','LineWidth',2.0,'LineStyle','-');
  legend('car','car trajectory');
  axis equal;xlabel('x[m]');ylabel('y[m]');
  pause(ts)
  
  snap_at = floor(linspace(2,length(time),4));
  
  %%
  for k = 2:1:length(time)
    set(carLine, 'XData' , x_car(1:k));
    set(carLine, 'YData' , y_car(1:k));
    set(car    , 'XData' , x_car(k));
    set(car    , 'YData' , y_car(k));

    if isempty(isTestRun) || (isTestRun==false)
      pause(ts);
    end
    
    % record image for docs
    if k == snap_at(1)
      snapnow;
      snap_at = snap_at(2:end);
    end
  end
end
