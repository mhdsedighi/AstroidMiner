% clc; clear; close all
% % addpath OptimTraj
% % addpath chebfun
% load('params')
% load('ref')
load('shape');
params.shape=shape;
addpath('geom3d/geom3d')
addpath('geom3d/meshes3d')


close all
figure
hold on
axis equal
set(gca, 'XTick', [], 'YTick', [], 'ZTick', [])
set(gca, 'xcolor', 'w', 'ycolor', 'w','zcolor', 'w') ;


[n,~]=size(shape.F);

a_0=2.1;
e_0=0.1902;
incl_0=deg2rad(-40);
omega_0=deg2rad(60);
RA_0=deg2rad(70);
theta_0=deg2rad(270);
oe_0=[a_0 e_0 incl_0 omega_0 RA_0 theta_0];

oe_1=oe_0;
for theta=theta_0-pi/2:0.07:theta_0+pi/2

    oe_1(6)=theta;

[r,~]=oe2rv(oe_1,params.mu);
plot3(r(1),r(2),r(3),'c.')

end





% plot_line([0 0 0],r,0.1,'r-',1,'r',12)

l_axis=0.8;
plot_vec([-0.005 0 0],[1 0 0],l_axis,'k','-',2,'$X_I$',12)
plot_vec([0 -0.005 0],[0 1 0],l_axis,'k','-',2,'$Y_I$',12)
plot_vec([0 0 -0.005],[0 0 1],l_axis,'k','-',2,'$Z_I$',12)


[r,v]=oe2rv(oe_0,params.mu);
r=r';
v=v';
h=cross(r,v)/norm(cross(r,v));
s=v./norm(v);

plot3(r(1),r(2),r(3),'c*')


l_axis=0.7;
plot_line([0 0 0],r,1,'k',0.5,'r',5)
plot_vec(r,r./norm(r),l_axis,'k','-',2,'$e_r$',14)
plot_vec(r,s,l_axis,'k','-',2,'$e_s$',14)
plot_vec(r,h,l_axis,'K','-',2,'$e_w$',14)


% plot_line(r,[1 0 0],1,'r:',2,'r',5)



% figure
hold on
view(-29,37);
scale=0.2;
[X,Y,Z] = sphere;
% globe=surf(X*scale,Y*scale,Z*scale,'EdgeColor','none','FaceColor',[0.9290, 0.6940, 0.1250],'FaceAlpha','0.5');
globe=surf(X*scale,Y*scale,Z*scale,'EdgeColor','none','FaceColor',[0.9290, 0.6940, 0.1250]);
% plot_orbit(oe_0,'k:')

globe.FaceLighting = 'gouraud';
globe.AmbientStrength = 0.5;
globe.FaceAlpha = 0.9;




shape.V=0.05*shape.V;
shape.V=shape.V+r;


astplt=[];
astplt.faces=shape.F;
astplt.vertices=shape.V;
nfv=reducepatch(astplt,0.05);
shape.V=nfv.vertices;
shape.F=nfv.faces;


astplt=drawMesh(shape.V, shape.F);

astplt.FaceAlpha=0.2;
astplt.EdgeAlpha=0.2;
astplt.FaceColor=[0.3020 0.1529 0.0235];
astplt.EdgeColor=[0.3020 0.1529 0];
lighting flat
material metal


oe_xx=oe_0;
oe_xx(6)=deg2rad(50);
oe_xx(3)=deg2rad(30);

[r1,v1]=oe2rv(oe_xx,params.mu);
r1=r1';
v1=v1';
h1=cross(r1,v1)/norm(cross(r1,v1));
s1=v1./norm(v1);

l_axis=1;
plot_vec(r,h1,l_axis,'r','-',1,'$x_b$',14)
plot_vec(r,s1,l_axis,'g','-',1,'$y_b$',14)
plot_vec(r,cross(h1,s1),l_axis,'b','-',1,'$z_b$',14)






function plot_line(p,dir,d,style,thickness,name,font_size)

p2=p+d*dir;
XYZ=[p;p2];
plt=plot3(XYZ(:,1),XYZ(:,2),XYZ(:,3),style);
plt.LineWidth=thickness;

p2=p+1.2*d*dir;
text(p2(1),p2(2),p2(3),name,'FontSize',font_size, 'Interpreter','latex')

end

function plot_vec(p,dir,d,color,style,thickness,name,font_size)

p2=p+(d+0.15)*dir;
% XYZ=[p;p2];
plt=quiver3(p(1),p(2),p(3),d*dir(1),d*dir(2),d*dir(3));

plt.LineStyle=style;
plt.LineWidth=thickness;
plt.MaxHeadSize=0.5;
plt.Color=color;
% 
% p2=p+1.1*d*dir;
text(p2(1),p2(2),p2(3),name,'FontSize',font_size, 'Interpreter','latex')

end



