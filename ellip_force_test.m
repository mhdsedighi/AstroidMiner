clc
clear
close all


a=5;
b=4;
c=2;

N_cube=20;

F_cube=1;


F=[0 0 0];
M=[0 0 0];

figure
hold on
axis equal
view(25,45)
[x_surf, y_surf, z_surf] = ellipsoid(0,0,0,a,b,c,35);
surf(x_surf, y_surf,z_surf,'FaceAlpha',0.5,'EdgeColor','none');
plot3(0,0,0,'ro')

for i=1:N_cube
azimuth=rand*360;
elevation=rand*180-90;

[x,y,z,R,normal_vector]=ellip_deg(a,b,c,azimuth,elevation);
plot3(x,y,z,'b.')
plot_vector(x,y,z,normal_vector)

F=F+normal_vector*F_cube;
M=M+cross([x y z],F);

end

norm(F)
norm(M)






