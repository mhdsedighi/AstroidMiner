function [vector_cart] = spherical2cartesian(vector_sph,x,y,z)

% vector_sph= e_r e_theta e_phi

e_r=vector_sph(1);  %e_r
e_theta=-vector_sph(3); %e_up
e_phi=vector_sph(2); %e_s


% schematic from: https://en.wikipedia.org/wiki/Spherical_coordinate_system

r=sqrt(x^2+y^2+z^2);
azimuth=atan2(y,x);
elevation=acos(z/r);


% x=r*sin(elevation)*cos(azimuth);
% y=r*sin(elevation)*sin(azimuth);
% z=r*cos(elevation);


st=sin(elevation);
ct=cos(elevation);
sp=sin(azimuth);
cp=cos(azimuth);

T=[st*cp st*sp ct;
    ct*cp ct*sp -st;
    -sp cp 0];


vector_cart=T'*[e_r;e_theta;e_phi];


end

