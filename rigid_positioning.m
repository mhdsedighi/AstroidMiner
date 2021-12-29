function [Force_Vectors,Moment_Vectors]=rigid_positioning(params,N_sat,lambdas,phis,alphas,betas)


Force_Vectors=zeros(N_sat,3);
Moment_Vectors=zeros(N_sat,3);

for i=1:N_sat
    
    if params.assume_ellipsoid  
        [sat_pos,UP_vec,North_vec,Right_vec]=ellip_shape(params.a,params.b,params.c,lambdas(i),phis(i));
    else
        [sat_pos,UP_vec,North_vec,Right_vec]=ellip_shape_3d(params.shape.V,params.shape.F,lambdas(i),phis(i));
    end
    
    cos_alpha=cosd(alphas(i));
    sin_alpha=sind(alphas(i));
    cos_beta=cosd(betas(i));
    sin_beta=sind(betas(i));
    force_vec=sin_alpha*UP_vec+cos_alpha*cos_beta*North_vec+cos_alpha*sin_beta*Right_vec;
    
    Force_Vectors(i,:)=force_vec;
    Moment_Vectors(i,:)=cross(sat_pos,force_vec);
    
end

% params.N_sat=N_sat;
% params.Force_Vectors=Force_Vectors;
% params.Moment_Vectors=Moment_Vectors;


end