function [pos,UP_vec,North_vec,Right_vec]=ellip_shape_3d(V,F,lambda,phi)



sin_a=sind(lambda);
cos_a=cosd(lambda);
sin_e=sind(phi);
cos_e=cosd(phi);

xd=1*cos_e*cos_a;
yd=1*cos_e*sin_a;
zd=1*sin_e;


dir   = [xd yd zd];

line = [0 0 0 dir];
[xcoor, ~, faceInds] =intersectLineMesh3d(line, V, F);

dir_pole=[0 0 1];


if dot(xcoor(1,:),dir)>0
    idx_front=1;
else
    idx_front=2;
end



pos=[xcoor(idx_front,1) xcoor(idx_front,2) xcoor(idx_front,3)];

idx1=F(faceInds(idx_front),1);
idx2=F(faceInds(idx_front),2);
idx3=F(faceInds(idx_front),3);


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

