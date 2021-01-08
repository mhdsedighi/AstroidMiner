% clear
% close all

length_real=10;

addpath('geom3d/geom3d')
addpath('geom3d/meshes3d')
addpath('3dmodels')

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

scale=length_real/(max(x)-min(x));
x=x*scale;
y=y*scale;
z=z*scale;

params.V=[x y z];
params.F=obj.f.v;



% azimuth=0;
% elevation=10;
% [pos,UP_vec,North_vec,Right_vec]=ellip_shape_3d(V,F,azimuth,elevation)