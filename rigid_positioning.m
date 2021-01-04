function [params]=rigid_positioning(N_sat,a,b,c,azimuths,elevations,gammas,lambdas)


Force_Vectors=zeros(N_sat,3);
Moment_Vectors=zeros(N_sat,3);

for i=1:N_sat
    
    [x,y,z,UP_vec,North_vec,Right_vec]=ellip_deg(a,b,c,azimuths(i),elevations(i));
    
    sat_pos=[x,y,z];
    
    cos_gamma=cosd(gammas(i));
    sin_gamma=sind(gammas(i));
    cos_lambda=cosd(lambdas(i));
    sin_lambda=sind(lambdas(i));
    force_vec=cos_gamma*UP_vec+sin_gamma*cos_lambda*North_vec+sin_lambda*sin_lambda*Right_vec;
    
    Force_Vectors(i,:)=force_vec;
    Moment_Vectors(i,:)=cross(sat_pos,force_vec);
    
end

params.N_sat=N_sat;
params.Force_Vectors=Force_Vectors;
params.Moment_Vectors=Moment_Vectors;


end