% clc; clear; close all
% % addpath OptimTraj
% % addpath chebfun
% load('params')
% load('ref')
load('shape');
params.shape=shape;
addpath('geom3d/geom3d')
addpath('geom3d/meshes3d')
addpath('plotlib')


mu=1.3271e+11;



close all
figure
hold on
axis equal
view(-31,9);
set(gca, 'XTick', [], 'YTick', [], 'ZTick', [])
set(gca, 'xcolor', 'w', 'ycolor', 'w','zcolor', 'w') ;


[n,~]=size(shape.F);

a_0=2.1;
e_0=0.1902;
incl_0=deg2rad(15);
omega_0=deg2rad(0);
RA_0=deg2rad(0);
theta_0=deg2rad(135);
oe_0=[a_0 e_0 incl_0 omega_0 RA_0 theta_0];

oe_1=oe_0;
XYZ=[];
for theta=0:2:180

    %     if theta>270
    % break
    %     end

    oe_1(6)=deg2rad(theta);

    [r,~]=oe2rv(oe_1,mu);
    % plot3(r(1),r(2),r(3),'c.')
    XYZ=[XYZ;r'];

end

orb=fill3(XYZ(:,1),XYZ(:,2),XYZ(:,3),'k');
orb.FaceAlpha=0.1;
orb.EdgeColor='none';




% plot_line([0 0 0],r,0.1,'r-',1,'r',12)

l_axis=0.8;
plot_vec([-0.005 0 0],[1 0 0],l_axis,'k','-',2,'$X_I$',12)
plot_vec([0 -0.005 0],[0 1 0],l_axis,'k','-',2,'$Y_I$',12)
plot_vec([0 0 -0.005],[0 0 1],l_axis,'k','-',2,'$Z_I$',12)


[r,v]=oe2rv(oe_0,mu);
r=r';
v=v';
h=cross(r,v)/norm(cross(r,v));
s=v./norm(v);

alpha=deg2rad(30);
beta=deg2rad(45);
F=sin(alpha)*cos(beta)*r+cos(alpha)*cos(beta)*s+sin(beta)*h;

v_par=dot(F,h)*h;
v_per=F-v_par;

plot3(r(1),r(2),r(3),'c*')


l_axis=1.3;
plot_line([0 0 0],r,1,'k',0.5,'r',5)
plot_vec(r,r./norm(r),l_axis,'k','-',2,'$e_r$',14)
plot_vec(r,s,l_axis,'k','-',2,'$e_s$',14)
plot_vec(r,h,l_axis,'K','-',2,'$e_w$',14)

% plot_vec(r,F,l_axis,'b','-',2,'$F$',14)
arrow(r,r+F,6,'BaseAngle',60,'CrossDir',[1 0 1]);
vf=r+F;
vf=vf*1.03;
text(vf(1),vf(2),vf(3),'$\vec{F}$','FontSize',15, 'Interpreter','latex')


plot_line(r,v_per,0.7,'c:',2,' ',5)

plot_arc(r,s,v_per,0.5,'$\tau_2$')
plot_arc(r,v_per,F,0.5,'$\tau_1$')

% plot_line(r,[1 0 0],1,'r:',2,'r',5)




scale=0.1;
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
oe_xx(6)=deg2rad(70);
oe_xx(3)=deg2rad(60);

[r1,v1]=oe2rv(oe_xx,mu);
r1=r1';
v1=v1';
h1=cross(r1,v1)/norm(cross(r1,v1));
s1=v1./norm(v1);

l_axis=0.8;
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

function plot_arc(p,v1,v2,frac,name)

rot_vec=cross(v1,v2);
rot_vec=rot_vec./norm(rot_vec);



ov = frac*v1; % vector to be rotated
% ok = (Axis); % ok is the rotation axis vector
k = rot_vec; % k is the normalized rotation axis vector

start_deg=0;
end_deg=acosd(dot(v1,v2)/norm(v1)/norm(v2));
res=1;


count=0;
for theta = start_deg:res:end_deg % define the angle of rotation (right-handed CS)
    count=count+1;
    v_rot = ov*cosd(theta)+cross(k,ov)*sind(theta)+k*(dot(k,ov))*(1-cosd(theta)); % rotated vector about an axis through global origin(0,0,0)
    v_tran(count,:) = [p(1)+v_rot(1),p(2)+v_rot(2),p(3)+v_rot(3)]; % transformed vector (translate rotated vector back to initial point)
    %     plot3([P(1),v_tran(1)],[P(2),v_tran(2)],[P(3),P(3)+v_rot(3)],style);
    %     hold on;
end

idx=floor(count/2);
loc_text=v_tran(idx,:)+0.15*(v_tran(idx,:)-p)./norm(v_tran(idx,:)-p);

plot3(v_tran(:,1),v_tran(:,2),v_tran(:,3),'k');
text(loc_text(1),loc_text(2),loc_text(3),name,'FontSize',14, 'Interpreter','latex')

pp=v_tran(end-1,:);
% dir=v_tran(end,:)-v_tran(end-1,:);
pp_end=v_tran(end,:);
% d=10;
% plt=quiver3(pp(1),pp(2),pp(3),d*dir(1),d*dir(2),d*dir(3));
% plt.AutoScale=0;
% % plt.ShowArrowHead=1;
% plt.MaxHeadSize=100;
% plt.MarkerSize=100;
% plt.AlignVertexCenters='on';

arrow(pp,pp_end,6,'BaseAngle',60);% 'NormalDir',[0 0 1]);



end



