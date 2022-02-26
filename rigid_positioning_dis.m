function [sat_pos,Force_Vectors,Moment_Vectors,min_dis]=rigid_positioning_dis(params,N_sat,lambdas,phis,alphas,betas)

sat_pos=zeros(N_sat,3);
Force_Vectors=zeros(N_sat,3);
Moment_Vectors=zeros(N_sat,3);


for idx=1:N_sat


    [sat_pos(idx,:),UP_vec,North_vec,Right_vec]=ellip_shape_3d(params.shape.V,params.shape.F,lambdas(idx),phis(idx));

    cos_alpha=cosd(alphas(idx));
    sin_alpha=sind(alphas(idx));
    cos_beta=cosd(betas(idx));
    sin_beta=sind(betas(idx));
    force_vec=sin_alpha*UP_vec+cos_alpha*cos_beta*North_vec+cos_alpha*sin_beta*Right_vec;

    Force_Vectors(idx,:)=force_vec;
    Moment_Vectors(idx,:)=cross(sat_pos(idx,:),force_vec);

end


min_dis=180;
for idx=1:N_sat-1
    for j=idx+1:N_sat
        dis=norm(sat_pos(idx,:)-sat_pos(j,:));
        if dis<min_dis
            min_dis=dis;
        end
    end
end

end