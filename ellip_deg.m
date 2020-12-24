function [x,y,z,normal_vector]=ellip_deg(a,b,c,azimuth,elevation)

%%% https://en.wikipedia.org/wiki/Ellipsoid
%%%https://www.scielo.br/scielo.php?script=sci_arttext&pid=S1982-21702014000400970


sin_a=sind(azimuth);
cos_a=cosd(azimuth);
sin_e=sind(elevation);
cos_e=cosd(elevation);

x=a*cos_e*cos_a;
y=b*cos_e*sin_a;
z=c*sin_e;

% R=sqrt(x^2+y^2+z^2);

normal_vector=[x/a^2 y/b^2 z/c^2];

%%%could be optimized
normal_vector=normal_vector/norm(normal_vector);


end

