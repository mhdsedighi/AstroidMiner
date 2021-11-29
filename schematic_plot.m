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

for i=1:n
    mark=0;
    for j=1:4

        if shape.V(shape.F(i,j),3)>0 && shape.V(shape.F(i,j),1)>0 && shape.V(shape.F(i,j),2)>0
            mark=1;
        end
    end
    if mark==0
        shape.F(i,:)=nan;
    end

end

astplt=drawMesh(shape.V, shape.F);
astplt.FaceAlpha=0.06;
astplt.EdgeAlpha=0.2;
astplt.FaceColor=[0.3020 0.1529 0.0235];
astplt.EdgeColor=[0.3020 0.1529 0];
% lighting flat
% material metal
material dull
camlight



view(30,40);
% r =1;
% phi = pi/4;
% theta = pi/4;

%% plot cartesian coordinates:




% plot3(x0+[0, x_ref, nan, 0, 0, nan, 0, 0], y0+[0, 0, nan, 0, y_ref, nan, 0, 0], z0+[0, 0, nan, 0, 0, nan, 0, z_ref],'k' )
% text([x0+.85, x0, x0], [y0, y0+.8, y0], [z0, z0, z0+.85], ['$x$';'$y$';'$z$'],'FontSize',14, 'Interpreter','latex');

lambda=10;
phi=40;
alpha=20;
beta=40;

cos_alpha=cosd(alpha);
sin_alpha=sind(alpha);
cos_beta=cosd(beta);
sin_beta=sind(beta);


[sat_pos,UP_vec,North_vec,Right_vec]=ellip_shape_3d(params.shape.V,params.shape.F,lambda,phi);
force_vec=cos_alpha*UP_vec+sin_alpha*cos_beta*North_vec+sin_beta*sin_beta*Right_vec;

plot3(0,0,0,'r.')
plot3(sat_pos(1),sat_pos(2),sat_pos(3),'r.')

p=[0 0 0];
d=sqrt(norm(sat_pos))/2;
plot_line(p,[1 0 0],d,'k','$x$',14)
plot_line(p,[0 1 0],d,'k','$y$',14)
plot_line(p,[0 0 1],d,'k','$z$',14)
plot_line(p,sat_pos,1,'r','$ $',14)
v_par=dot(sat_pos,[0 0 1])*[0 0 1];
v_per=sat_pos-v_par;
plot_line(p,v_per,0.5,'k:','$ $',14);
plot_arc(p,v_per,sat_pos,0.3,'$\phi$')
plot_arc(p,[1 0 0],v_per,0.6,'$\lambda$')


plot_line(sat_pos,UP_vec,d,'b','$n$',14)
plot_line(sat_pos,Right_vec,d,'k','$East$',7)
plot_line(sat_pos,North_vec,d,'k','$North$',7)

plot_vec(sat_pos,force_vec,2,'$F$')

F=sat_pos+force_vec;

v_par=dot(force_vec,UP_vec)*UP_vec;
v_per=force_vec-v_par;

plot_line(sat_pos,v_per,2,'k:','$ $',14)

plot_arc(sat_pos,North_vec,v_per,0.3,'$\beta$')
plot_arc(sat_pos,v_per,force_vec,1,'$\alpha$')


plot_plane(sat_pos,UP_vec,1,'b',0.4)


sin_a=sind(lambda);
cos_a=cosd(lambda);
sin_e=sind(phi);
cos_e=cosd(phi);
xd=1*cos_e*cos_a;
yd=1*cos_e*sin_a;
zd=1*sin_e;

dir   = [xd yd zd];
plot_plane(sat_pos,dir,0.5,'r',0.4)





[sat_pos,UP_vec,North_vec,Right_vec]=ellip_shape_3d(params.shape.V,params.shape.F,0,90);
plot3(sat_pos(1),sat_pos(2),sat_pos(3),'r.')
text(sat_pos(1),sat_pos(2),1.1*sat_pos(3),'\uparrow N','FontSize',14)


% v1=[1 0 0];
% v2=[1 1 1];
% plot_arc(p,v1,v2,0.3,'$r$')

% % % %% plot the ball
% % % line('xdata',sphcart(r,theta,phi,'x'),'ydata',sphcart(r,theta,phi,'y'),'zdata',sphcart(r,theta,phi,'z'),'marker','.','markersize',5);
% % %
% % % %% Plot the arm
% % % line('xdata',[0 sphcart(r,theta,phi,'x')],'ydata',[0 sphcart(r,theta,phi,'y')],'zdata',[0 sphcart(r,theta,phi,'z')]);
% % %
% % % %% Plot the projections
% % % line('xdata',[0 sphcart(r,theta,phi,'x')],'ydata',[0 sphcart(r,theta,phi,'y')],'zdata',[0 0],'linestyle','--');
% % %
% % % %% Line from xy plane to point
% % % line('xdata',[sphcart(r,theta,phi,'x') sphcart(r,theta,phi,'x')],'ydata',[sphcart(r,theta,phi,'y') sphcart(r,theta,phi,'y')],'zdata',[0 sphcart(r,theta,phi,'z')],'linestyle','--')
% % %
% % % %% label r
% % % text(.5,.5,.8,'$r$','FontSize',14, 'Interpreter','latex')
% % %
% % % %% change view point
% % % az = 100;
% % % el = 45;
% % % view(az,el)
% % %
% % % %% get rid of axis labels
% % % set(gca, 'XTick', [], 'YTick', [], 'ZTick', [])
% % % set(gca, 'xcolor', 'w', 'ycolor', 'w','zcolor', 'w') ;
% % % %% arc (xy)
% % % theta = [0: pi/4*0.0001 :pi/4];
% % % phi = linspace(0,0,10001);
% % % r = linspace(0.25,0.25,10001);
% % %
% % % [X,Y,Z]=sph2cart(theta,phi,r);
% % %
% % % plot3(X,Y,Z,'Color','k');
% % %
% % % % label arc
% % % text(.3,0.08,0,'$\theta$','FontSize',14,'Interpreter','latex')
% % %
% % %
% % % %% arc down from z
% % % phi = [pi/4: pi/4*0.0001 :pi/2];
% % % theta = linspace(pi/4,pi/4,10001);
% % % r = linspace(0.25,0.25,10001);
% % % [X,Y,Z]=sph2cart(theta,phi,r);
% % %
% % % plot3(X,Y,Z,'Color','k');
% % %
% % % % label arc
% % % text(.1,.08,0.4,'$\phi$','FontSize',14,'Interpreter','latex')
% % %
% % %
% % %
% % %
% % %
% % %
% % %
% % %
% % %
% % %
% % %
% % %




function[OUT]=sphcart(R,THETA,PHI,COORD)
if strcmpi(COORD,'x')
    OUT=R.*cos(THETA).*cos(PHI);
elseif strcmpi(COORD,'y')
    OUT=R.*cos(THETA).*sin(PHI);
elseif strcmpi(COORD,'z')
    OUT=R.*sin(THETA);
else
    disp('Wrong coordinate!');
    OUT=nan;
end
end


function plot_line(p,dir,d,style,name,font_size)

p2=p+d*dir;
XYZ=[p;p2];
plot3(XYZ(:,1),XYZ(:,2),XYZ(:,3),style);

p2=p+1.1*d*dir;
text(p2(1),p2(2),p2(3),name,'FontSize',font_size, 'Interpreter','latex')

end

function plot_vec(p,dir,d,name)

p2=p+d*dir;
% XYZ=[p;p2];
plt=quiver3(p(1),p(2),p(3),d*dir(1),d*dir(2),d*dir(3));

% plt.LineWidth=1.5;
% 
% p2=p+1.1*d*dir;
text(p2(1),p2(2),p2(3),name,'FontSize',14, 'Interpreter','latex')

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
loc_text=v_tran(idx,:)+0.1*(v_tran(idx,:)-p)./norm(v_tran(idx,:)-p);

plot3(v_tran(:,1),v_tran(:,2),v_tran(:,3),'k');
text(loc_text(1),loc_text(2),loc_text(3),name,'FontSize',14, 'Interpreter','latex')




end


function plot_plane(p0,normal_vec,plane_size,color,face_alpha)

w = null(normal_vec); % Find two orthonormal vectors which are orthogonal to v
   [P,Q] = meshgrid(-plane_size:plane_size); % Provide a gridwork (you choose the size)
   X = p0(1)+w(1,1)*P+w(1,2)*Q; % Compute the corresponding cartesian coordinates
   Y = p0(2)+w(2,1)*P+w(2,2)*Q; %   using the two vectors in w
   Z = p0(3)+w(3,1)*P+w(3,2)*Q;
   plt_pln=surf(X,Y,Z,FaceColor=color,FaceAlpha=face_alpha,EdgeColor='none');

end