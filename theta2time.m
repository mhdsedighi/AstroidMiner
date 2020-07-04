function delta_t=theta2time(theta1,theta2,orbit,mu)


%%%% mathworks.com/matlabcentral/mlc-downloads/downloads/e7aa688b-723b-476c-8d7f-46b0ad8129ee/47a9d8bc-216d-4d10-a9b0-2a1720ed8530/previews/Circular_Orbit_Plane_Change/Extra_Files/Orbit3D.m/index.html

n  = sqrt(mu/orbit.a^3);

cosE1 = (orbit.e+cos(theta1))./(1+orbit.e.*cos(theta1));               % cosine of initial eccentric anomaly
sinE1 = (sqrt(1-orbit.e^2).*sin(theta1))./(1+orbit.e.*cos(theta1));    %   sine of initial eccentric anomaly
E1 = atan2(sinE1,cosE1);                           % initial eccentric anomaly              [rad]
if (E1<0)                                          % [0,2pi]
    E1=E1+2*pi;
end
tp1 = (E1-orbit.e.*sin(E1))/n;                       % pass time at the perigee               [s]

cosE2 = (orbit.e+cos(theta2))./(1+orbit.e.*cos(theta2));               % cosine of initial eccentric anomaly
sinE2 = (sqrt(1-orbit.e^2).*sin(theta2))./(1+orbit.e.*cos(theta2));    %   sine of initial eccentric anomaly
E2 = atan2(sinE2,cosE2);                           % initial eccentric anomaly              [rad]
if (E2<0)                                          % [0,2pi]
    E2=E2+2*pi;
end
tp2 = (E2-orbit.e.*sin(E2))/n;                       % pass time at the perigee               [s]




period=2*pi/n;

if tp1<0
    tp1=tp1+period;
end
if tp2<0
    tp2=tp2+period;
end

delta_t=tp2-tp1;

if delta_t<0
    delta_t=delta_t+period;
end


end