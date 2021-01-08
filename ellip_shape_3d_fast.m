function [pos,UP_vec,North_vec,Right_vec]=ellip_shape_3d_fast(params,azimuth,elevation)




pos_x = interp2(params.shape.AZI,params.shape.ELE,params.shape.pos_x,azimuth,elevation);
pos_y = interp2(params.shape.AZI,params.shape.ELE,params.shape.pos_y,azimuth,elevation);
pos_z = interp2(params.shape.AZI,params.shape.ELE,params.shape.pos_z,azimuth,elevation);

UP_vec_x = interp2(params.shape.AZI,params.shape.ELE,params.shape.UP_vec_x,azimuth,elevation);
UP_vec_y = interp2(params.shape.AZI,params.shape.ELE,params.shape.UP_vec_y,azimuth,elevation);
UP_vec_z = interp2(params.shape.AZI,params.shape.ELE,params.shape.UP_vec_z,azimuth,elevation);

North_vec_x = interp2(params.shape.AZI,params.shape.ELE,params.shape.North_vec_x,azimuth,elevation);
North_vec_y = interp2(params.shape.AZI,params.shape.ELE,params.shape.North_vec_y,azimuth,elevation);
North_vec_z = interp2(params.shape.AZI,params.shape.ELE,params.shape.North_vec_z,azimuth,elevation);


pos=[pos_x pos_y pos_z];
UP_vec=[UP_vec_x UP_vec_y UP_vec_z];
North_vec=[North_vec_x North_vec_y North_vec_z];

UP_vec=UP_vec/norm(UP_vec);
North_vec=North_vec/norm(North_vec);

%         if UP_vec==[0 0 1]
%             North_vec=[1 0 0];
%         end

Right_vec=cross(North_vec,UP_vec);
Right_vec=Right_vec/norm(Right_vec);

end

