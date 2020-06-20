%% INTERPLANETARY MISSION DESIGN USING THE METHOD OF PATCHED CONICS

clc;
clear;
close all;

%% CONSTANTS

%Gravitational parameter of the sun
global mu planet_id1 planet_id2
mu = 1.327124e11; %km^3/s^2
%Conversion factor between degrees and radians
deg = pi/180;
%Astronomical unit 
au = 149597871; %km

%Planets' name array
planets = ['Mercury'; 'Venus  '; 'Earth  '; 'Mars   '; ...
           'Jupiter'; 'Saturn '; 'Uranus '; 'Neptune'; 'Pluto  '];
       
planet_id1=4;
planet_id2=3;
t_start= datetime(2020,1,1);
alt_parking=10000;
alt_capture=10000;


counter1=0;
counter2=0;
samples=[];
for aft_month=0:0.5:45
    counter1=counter1+1;
    for dure_month=10:0.5:45
        counter2=counter2+1;
        
        start_hour_after_ref=30*24*aft_month;
        mission_duration_hour=30*24*dure_month;
        
        
        [delta_v_total] = test_shoot(t_start,alt_capture,start_hour_after_ref,mission_duration_hour);
        samples=[samples;aft_month,dure_month,delta_v_total];


    end
end

figure
hold on
 plot3(samples(:,1),samples(:,2),samples(:,3),'b.')
 xlabel('launch after Jan1st(months)')
 ylabel('mission duration(months)')
 zlabel('fuel cost')
 
 view(23,45)



% %% OUTPUTS
% 
% fprintf('\n  < Results >\n');
% 
% fprintf('\nDeparture planet             ');
% disp(planets(planet_id1,:));
% fprintf('Departure calendar date      ');
% disp([t_start.Year t_start.Month t_start.Day]);
% fprintf('Departure universal time     ');
% disp([t_start.Hour t_start.Minute sec1]);
% fprintf('\nDeparture julian date        %12.6f', jd1);
% 
% fprintf('\n\nArrival planet               ');
% disp(planets(planet_id2,:));
% fprintf('Arrival calendar date        ');
% disp([t_end.Year t_end.Month t_end.Day]);
% fprintf('Arrival universal time       ');
% disp([t_end.Hour t_end.Minute sec2]);
% fprintf('\nArrival julian date          %12.6f', jd2');
% 
% fprintf('\n\nTransfer time              %12.6f  days \n ', tof);
% 
% fprintf('\n\nHeliocentric ecliptic orbital elements of the departure planet\n');
% fprintf('--------------------------------------------------------------');
% fprintf ('\n        sma (AU)              eccentricity          inclination (deg)         argper (deg)');
% fprintf ('\n %+16.14e  %+16.14e  %+16.14e  %+16.14e \n', oe1(7)/au, oe1(2), oe1(4), oe1(5));
% fprintf ('\n       raan (deg)          true anomaly (deg)       longper(deg)              period (days)');
% fprintf ('\n %+16.14e  %+16.14e  %+16.14e  %+16.14e \n', oe1(3), oe1(6), oe1(8), T1);
% 
% fprintf('\n\nHeliocentric ecliptic orbital elements of the transfer orbit\n')
% fprintf('prior to reaching the sphere of influence of the arrival planet\n');
% fprintf('---------------------------------------------------------------');
% fprintf ('\n        sma (AU)              eccentricity          inclination (deg)         argper (deg)');
% fprintf ('\n %+16.14e  %+16.14e  %+16.14e  %+16.14e \n', oe(7)/au, oe(2), oe(4)/deg, oe(5)/deg);
% fprintf ('\n       raan (deg)          true anomaly (deg)       period (min)');
% fprintf ('\n %+16.14e  %+16.14e  %+16.14e  %+16.14e \n', oe(3)/deg, oe(6)/deg, T3);
% 
% fprintf('\n\nHeliocentric ecliptic orbital elements of the transfer orbit\n')
% fprintf('prior to reaching the sphere of influence of the arrival planet\n');
% fprintf('---------------------------------------------------------------');
% fprintf ('\n        sma (AU)              eccentricity          inclination (deg)         argper (deg)');
% fprintf ('\n %+16.14e  %+16.14e  %+16.14e  %+16.14e \n', oe3(7)/au, oe3(2), oe3(4)/deg, oe3(5)/deg);
% fprintf ('\n       raan (deg)          true anomaly (deg)       period (min)');
% fprintf ('\n %+16.14e  %+16.14e  %+16.14e  %+16.14e \n', oe3(3)/deg, oe3(6)/deg, T3);
% 
% fprintf('\n\nHeliocentric ecliptic orbital elements of the arrival planet\n');
% fprintf('--------------------------------------------------------------');
% fprintf ('\n        sma (AU)              eccentricity          inclination (deg)         argper (deg)');
% fprintf ('\n %+16.14e  %+16.14e  %+16.14e  %+16.14e \n', oe2(7)/au, oe2(2), oe2(4), oe2(5));
% fprintf ('\n       raan (deg)          true anomaly (deg)       longper(deg)              period (days)');
% fprintf ('\n %+16.14e  %+16.14e  %+16.14e  %+16.14e \n', oe2(3), oe2(6), oe2(8), T2);
% 
% fprintf('\n\nDeparture velocity vector and magnitude\n');
% fprintf('\nx-component of departure velocity                          %12.6f  km/s',V1(1));
% fprintf('\ny-component of departure velocity                          %12.6f  km/s', V1(2));
% fprintf('\nz-component of departure velocity                          %12.6f  km/s', V1(3));
% fprintf('\ndeparture velocity magnitude                               %12.6f  km/s',norm(V1(3)));
% 
% fprintf('\n\nArrival velocity vector and magnitude\n');
% fprintf('\nx-component of arrival velocity                            %12.6f  km/s', V2(1));
% fprintf('\ny-component of arrival velocity                            %12.6f  km/s', V2(2));
% fprintf('\nz-component of arrival velocity                            %12.6f  km/s', V2(3));
% fprintf('\ndeparture velocity magnitude                               %12.6f  km/s',norm(V2));
% 
% fprintf('\n\nHyperbolic excess velocity vector and magnitude at departure\n');
% fprintf('\nx-component of hyperbolic excess velocity at departure     %12.6f  km/s',vinf1(1));
% fprintf('\ny-component of hyperbolic excess velocity at departure     %12.6f  km/s', vinf1(2));
% fprintf('\nz-component of hyperbolic excess velocity at departure     %12.6f  km/s', vinf1(3));
% fprintf('\nhyperbolic excess velocity at departure magnitude          %12.6f  km/s',norm(vinf1));
% 
% fprintf('\n\nHyperbolic excess velocity vector and magnitude at arrival\n');
% fprintf('\nx-component of hyperbolic excess velocity at arrival       %12.6f  km/s', vinf2(1));
% fprintf('\ny-component of hyperbolic excess velocity at arrival       %12.6f  km/s', vinf2(2));
% fprintf('\nz-component of hyperbolic excess velocity at arrival       %12.6f  km/s', vinf2(3));
% fprintf('\nhyperbolic excess velocity at arrival magnitude            %12.6f  km/s',norm(vinf2));
% 
% fprintf('\n\n<Planetary departure parameters>\n');
% 
% fprintf('\nAltitude of the parking orbit                                             %12.6f  km', alt_parking);
% fprintf('\nPeriod of the parking orbit                                               %12.6f  min', T_parking);
% fprintf('\nSpeed of the space vehicle in its circular orbit                          %12.6f  km/s', vC1);
% fprintf('\nRadius to periapsis of the departure hyperbola                            %12.6f  km', rp1);
% fprintf('\nEccentricity of the departure hyperbola                                   %12.6f', e_dep);
% fprintf('\nSpeed of the space vehicle at the periapsis of the departure hyperbola    %12.6f  km/s', vp1);
% fprintf('\nDelta_v for departure                                                     %12.6f  km/s', delta_v_departure);
% 
% fprintf('\n\n<Planetary rendezvous parameters>\n');
% 
% fprintf('\nAltitude of the capture orbit                                             %12.6f  km', alt_capture);
% fprintf('\nPeriod of the capture orbit                                               %12.6f  min', T_parking2);
% fprintf('\nSpeed of the space vehicle in its circular orbit                          %12.6f  km/s', vC2);
% fprintf('\nRadius to periapsis of the arrival hyperbola                              %12.6f  km', r_p_arrival);
% fprintf('\nEccentricity of the arrival   hyperbola                                   %12.6f', e_arrive);
% fprintf('\nSpeed of the space vehicle at the periapsis of the arrival hyperbola      %12.6f  km/s', vp2);
% fprintf('\nDelta_v for arrival                                                       %12.6f  km/s', delta_v_arrival);
% 
% fprintf('\n\nTotal delta_v for the mission                                           %12.6f  km/s\n', delta_v_total);


% %% 3D GRAPHICAL REPRESENTATION OF THE HELIOCENTRIC TRAJECTORY
% 
% oea = zeros(360,6);oeb = zeros(360,6);oec = zeros(360,6);
% ra = zeros(360,3);va = zeros(360,3);
% rb = zeros(360,3);vb = zeros(360,3);
% rc = zeros(360,3);vc = zeros(360,3);
% rxa = zeros(360,1);rya = zeros(360,1);rza = zeros(360,1);
% rxb = zeros(360,1);ryb = zeros(360,1);rzb = zeros(360,1);
% rxc = zeros(360,1);ryc = zeros(360,1);rzc = zeros(360,1);
% n=1;
% 
%  for i = 1:360
%     oea(i,:)=[oe1(1), oe1(2), oe1(3)*deg, oe1(4)*deg, oe1(5)*deg,...
%         oe1(6)*deg+i*deg];
%     oeb(i,:)=[oe2(1), oe2(2), oe2(3)*deg, oe2(4)*deg, oe2(5)*deg,...
%         oe2(6)*deg+i*deg];
%     oec(i,:)=[oe(1), oe(2), oe(3), oe(4), oe(5), oe(6)+i*deg];
%     
%     [ra(i,:), va(i,:)] = sv_from_oe(oea(i,:), mu);
%     [rb(i,:), vb(i,:)] = sv_from_oe(oeb(i,:), mu);
%     [rc(i,:), vc(i,:)] = sv_from_oe(oec(i,:), mu);
%     
%     rxa(n) = ra(i,1);
%     rya(n) = ra(i,2);
%     rza(n) = ra(i,3);
%     
%     rxb(n) = rb(i,1);
%     ryb(n) = rb(i,2);
%     rzb(n) = rb(i,3);
%     
%     rxc(n) = rc(i,1);
%     ryc(n) = rc(i,2);
%     rzc(n) = rc(i,3);
%     
%     n = n+1;
%  end
% 
% %Set color to black 
% colordef black;
% 
% hold on
% grid on
% axis equal
% %Initial orbit
% plot3(rxa/au,rya/au,rza/au,'-r','LineWidth', 1.5);
% %Final orbit
% plot3(rxb/au,ryb/au,rzb/au,'-g','LineWidth', 1.5);
% %Transfer orbit
% if oe(6) > oe3(6)
%     a = (floor(oe3(6)/deg)+(360-floor(oe(6)/deg)));
% else
%     a = floor(oe3(6)/deg - oe(6)/deg);
% end
% plot3(rxc(1:a)/au,ryc(1:a)/au,rzc(1:a)/au,'-b','LineWidth', 1.5);
% plot3(rxc(a:end)/au,ryc(a:end)/au,rzc(a:end)/au,'--b','LineWidth', 1.5);
% %Intial and final positions of the planets
% plot3(r1(1)/au,r1(2)/au,r1(3)/au,'ok','MarkerSize',7,'MarkerFaceColor','c');
% plot3(r1_prime(1)/au,r1_prime(2)/au,r1_prime(3)/au,'ok','MarkerSize',7,...
%     'MarkerFaceColor','r');
% plot3(r2_prime(1)/au,r2_prime(2)/au,r2_prime(3)/au,'ok','MarkerSize',7,...
%     'MarkerFaceColor','c');
% plot3(r2(1)/au,r2(2)/au,r2(3)/au,'ok','MarkerSize',7,'MarkerFaceColor','r');
% %Draw sun
% plot3(0,0,0,'oy', 'MarkerSize',18,'MarkerFaceColor','y');
% %Plot and label vernal equinox line
%     x_vernal = oe1(7)/au;
% if oe1(7) < oe2(7)
%     x_vernal = oe2(7)/au;
% end    
% line ([0.06, x_vernal], [0, 0], 'Color', 'w');
% text(1.05 * x_vernal, 0, '\Upsilon');
% %Label plot and axes
% title('Heliocentric Trajectory', 'FontSize', 16);
% xlabel('X coordinate (AU)', 'FontSize', 14);
% ylabel('Y coordinate (AU)', 'FontSize', 14);
% %Legend 
% lgd = legend(strcat(planets(planet_id1,:),' orbit'),...
%              strcat(planets(planet_id2,:),' orbit'),...
%              'Transfer trajectory','Transfer orbit',...
%              ['Initial position of ' planets(planet_id1,:)],...
%              ['Final position of ' planets(planet_id1,:)],...
%              ['Initial position of ' planets(planet_id2,:)], ...
%              ['Final position of ' planets(planet_id2,:)],...
%              'Sun','Vernal equinox direction');
% lgd.FontSize = 12;
% pos = get(lgd,'position');
% set(lgd,'position',[0.65 0.5 pos(3:4)]);
% %Enlarge figure to full screen.
% set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
% %Enable 3d rotation
% rotate3d on;