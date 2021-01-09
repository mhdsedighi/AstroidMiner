function [pos,UP_vec,North_vec,Right_vec]=ellip_shape_3d(V,F,azimuth,elevation)



sin_a=sind(azimuth);
cos_a=cosd(azimuth);
sin_e=sind(elevation);
cos_e=cosd(elevation);

xd=1*cos_e*cos_a;
yd=1*cos_e*sin_a;
zd=1*sin_e;


dir   = [xd yd zd];

line = [0 0 0 dir];
[xcoor, ~, faceInds] =intersectLineMesh3d(line, V, F);

dir_pole=[0 0 1];
for i=1:2
    
    if sign(xcoor(i,3))==sign(dir(3))
        pos=[xcoor(i,1) xcoor(i,2) xcoor(i,3)];
        
        idx1=F(faceInds(i),1);
        idx2=F(faceInds(i),2);
        idx3=F(faceInds(i),3);
        
        
        X1=V(idx1,:);
        X2=V(idx2,:);
        X3=V(idx3,:);
        
        vec1=X2-X1;
        vec2=X3-X1;
        
        UP_vec=cross(vec1,vec2);
        if dot (UP_vec,dir)<0
            UP_vec=-UP_vec;
        end
        UP_vec=UP_vec/norm(UP_vec);
        
        North_vec=cross(UP_vec,cross(dir_pole,UP_vec));
        North_vec=North_vec/norm(North_vec);
        
        if North_vec(3)<0
            North_vec=-North_vec;
        end
        
        if abs(UP_vec(3)-1)<1e-5
            North_vec=[1 0 0];
        end
        
        Right_vec=cross(North_vec,UP_vec);
        Right_vec=Right_vec/norm(Right_vec);
        
    end
end




end

