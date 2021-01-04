function [x,y,z,UP_vec,North_vec,Right_vec]=ellip_deg(a,b,c,azimuth,elevation)

%%% https://en.wikipedia.org/wiki/Ellipsoid
%%%https://www.scielo.br/scielo.php?script=sci_arttext&pid=S1982-21702014000400970


sin_a=sind(azimuth);
cos_a=cosd(azimuth);
sin_e=sind(elevation);
cos_e=cosd(elevation);

x=a*cos_e*cos_a;
y=b*cos_e*sin_a;
z=c*sin_e;


UP_vec=[ (cos_a*cos_e)/a, (cos_e*sin_a)/b, sin_e/c];

North_vec=[ -a*cos_a*sin_e, -b*sin_a*sin_e, c*cos_e];

if North_vec(3)<0
    North_vec=-North_vec;
end

if abs(cos_e)<1e-4
    North_vec=[1 0 0];
end

UP_vec=UP_vec/norm(UP_vec);
North_vec=North_vec/norm(North_vec);
Right_vec=cross(North_vec,UP_vec);

% R=sqrt(x^2+y^2+z^2);


end

