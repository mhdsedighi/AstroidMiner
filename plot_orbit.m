function plot_orbit(oe,color)


a=oe(1);
e=oe(2);
inc=oe(3);
omega=oe(4);
OMEGA=oe(5);



Rz_Omega = [ ...
    [cos(OMEGA) sin(OMEGA) 0]; ...
    [-sin(OMEGA) cos(OMEGA) 0]; ...
    [0 0 1]];
Rx_i = [ ...
    [1 0 0]; ...
    [0 cos(inc) sin(inc)]; ...
    [0 -sin(inc) cos(inc)]];
Rz_omega = [ ...
    [cos(omega) sin(omega) 0]; ...
    [-sin(omega) cos(omega) 0]; ...
    [0 0 1]];



% Rz_hour = [ ...
%     [cosd(theta) sin(theta) 0]; ...
%     [-sin(theta) cos(theta) 0]; ...
%     [0 0 1]];






Evals = 0:pi/100:2*pi; % [deg] values of the eccentric anomaly around orbit
Orbit_p = a*(cos(Evals)-e); % [m] orbit positions
Orbit_q = a*sqrt(1 - e^2)*sin(Evals); % [m] orbit positions
% % % deltaT_s = ((Evals-E_deg_epoch) - e*sin(Evals-E_deg_epoch))/n_deg_per_s; % [s] time since epoch along orbit
% r_ECR_orbit = Rz_hour*r_ECI_orbit';
% r_LLA_orbit = ecef2lla(r_ECR_orbit');
% only due one at a time... <sigh>

nn=length(Evals);
Orbit_ECI = zeros(nn,3);
% Orbit_LLA = zeros(nn,3);
for ipt = 1:nn
    r_pq = [Orbit_p(ipt) Orbit_q(ipt) 0]';
    Orbit_ECI(ipt,:) = [inv(Rz_Omega)*inv(Rx_i)*inv(Rz_omega)*r_pq]'; %[Rz_Omega*Rx_i*Rz_omega*r_pq]';
    %     lla = eci2lla(Orbit_ECI(ipt,:),datevec(datenum(Year, Month, Day, H, M, S+deltaT_s(ipt))),'IAU-2000/2006');
    %     Orbit_LLA(ipt,:) = lla;
end


plot3(Orbit_ECI(:,1),Orbit_ECI(:,2),Orbit_ECI(:,3),color)

end