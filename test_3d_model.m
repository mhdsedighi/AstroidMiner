close all

addpath('geom3d/geom3d')
addpath('geom3d/meshes3d')
addpath('3dmodels')

clear
obj = readObj('10464_Asteroid_v1_Iterations-2.obj');

x=obj.v(:,1);
y=obj.v(:,2);
z=obj.v(:,3);
Np=length(x);

xc=(max(x)+min(x))/2;
yc=(max(y)+min(y))/2;
zc=(max(z)+min(z))/2;
x=x-xc;
y=y-yc;
z=z-zc;

V=[x y z];
F=obj.f.v;

lambda=40;
phi=80;

sin_a=sind(lambda);
cos_a=cosd(lambda);
sin_e=sind(phi);
cos_e=cosd(phi);

xd=cos_e*cos_a;
yd=cos_e*sin_a;
zd=sin_e;

xd=-227.4;
yd=-80.2;
zd=497.1;

dir   = [xd yd zd];                        % ray's destination
% % % N=length(faces);

line = [0 0 0 dir];
[xcoor, ~, faceInds] =intersectLineMesh3d(line, V, F);
% % %
dir_pole=[0 0 1];
for i=1:2
    
    if sign(xcoor(i,3))==sign(dir(3))
        pos=[xcoor(i,1) xcoor(i,2) xcoor(i,3)];
        
        p1=F(faceInds(i),1);
        p2=F(faceInds(i),2);
        p3=F(faceInds(i),3);
        
        
        X1=[x(p1) y(p1) z(p1)];
        X2=[x(p2) y(p3) z(p2)];
        X3=[x(p3) y(p3) z(p3)];
        
        vec1=X2-X1;
        vec2=X3-X1;
        
        normal=cross(vec1,vec2);
        if dot (normal,dir)<0
            normal=-normal;
        end
        normal=normal/norm(normal);
        
        north=cross(normal,cross(dir_pole,normal));
        north=north/norm(north);
        
        if north(3)<0
            north=-north;
        end
        
        right=cross(north,normal);
        right=right/norm(right);
        
    end
end

% 
figure
hold on
axis equal
view([3 1 1])
plot3(x,y,z,'k.')
plot3(pos(1),pos(2),pos(3),'r*')

xx=[X1;X2;X3];
plot3(xx(:,1),xx(:,2),xx(:,3),'go')


figure
hold on
axis equal
view([3 1 1])
aa=drawMesh(V, F);
aa.FaceAlpha=0.5;
aa.EdgeAlpha=0.9;


