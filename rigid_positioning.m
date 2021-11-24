function [Force_Vectors,Moment_Vectors]=rigid_positioning(params,N_sat,azimuths,elevations,gammas,lambdas)


Force_Vectors=zeros(N_sat,3);
Moment_Vectors=zeros(N_sat,3);

for i=1:N_sat
    
    if params.assume_ellipsoid  
        [sat_pos,UP_vec,North_vec,Right_vec]=ellip_shape(params.a,params.b,params.c,azimuths(i),elevations(i));
    else
        [sat_pos,UP_vec,North_vec,Right_vec]=ellip_shape_3d(params.shape.V,params.shape.F,azimuths(i),elevations(i));
    end
    
    cos_gamma=cosd(gammas(i));
    sin_gamma=sind(gammas(i));
    cos_lambda=cosd(lambdas(i));
    sin_lambda=sind(lambdas(i));
    force_vec=cos_gamma*UP_vec+sin_gamma*cos_lambda*North_vec-sin_lambda*sin_lambda*Right_vec;
    
    Force_Vectors(i,:)=force_vec;
    Moment_Vectors(i,:)=cross(sat_pos,force_vec);
    
end

% params.N_sat=N_sat;
% params.Force_Vectors=Force_Vectors;
% params.Moment_Vectors=Moment_Vectors;


end