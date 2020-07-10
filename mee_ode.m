function ydot = mee_ode(t, y)

% first-order modified equinoctial equations of motion

% input

%  t    = current simulation time (seconds)
%  y(1) = semilatus rectum of orbit (kilometers)
%  y(2) = f equinoctial element
%  y(3) = g equinoctial element
%  y(4) = h equinoctial element
%  y(5) = k equinoctial element
%  y(6) = true longitude (radians)

% output

%  ydot(1:6) = first time derivatives of modified equinoctial elements

% Orbital Mechanics with MATLAB

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ydot=zeros(6,1);

global mu force_t force_n force_r
 
% unload current modified equinoctial orbital elements

pmee = y(1);
fmee = y(2);
gmee = y(3);
hmee = y(4);
xkmee = y(5);
xlmee = y(6);



% compute modified equinoctial elements equations of motion

sinl = sin(xlmee);

cosl = cos(xlmee);

wmee = 1.0 + fmee * cosl + gmee * sinl;

sesqr = 1.0 + hmee * hmee + xkmee * xkmee;

ydot(1) = (2.0 * pmee / wmee) * sqrt(pmee / mu) * force_t;

ydot(2) = sqrt(pmee / mu) * (force_r*sinl+((wmee + 1.0) * cosl + fmee) * (force_t / wmee) ...
    -(hmee * sinl - xkmee * cosl) * (gmee * force_n / wmee));

ydot(3) = sqrt(pmee / mu) * (-force_r*cosl+((wmee + 1.0) * sinl + gmee) * (force_t / wmee) ...
    -(hmee * sinl - xkmee * cosl) * (fmee * force_n / wmee));

ydot(4) = sqrt(pmee / mu) * (sesqr * force_n / (2.0 * wmee)) * cosl;

ydot(5) = sqrt(pmee / mu) * (sesqr * force_n / (2.0 * wmee)) * sinl;

ydot(6) = sqrt(mu * pmee) * (wmee / pmee)^2 + (1.0 / wmee) * sqrt(pmee / mu) ...
    * (hmee * sinl - xkmee * cosl) * force_n;

end