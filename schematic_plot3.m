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



a_0=2;
e_0=0.1902;
incl_0=deg2rad(-40);
omega_0=deg2rad(60);
RA_0=deg2rad(70);
theta_0=deg2rad(260);
oe_0=[a_0 e_0 incl_0 omega_0 RA_0 theta_0];

oe_1=oe_0;
for theta=theta_0-pi/2:0.03:theta_0+pi/2

    oe_1(6)=theta;

[r,~]=oe2rv(oe_1,params.mu);
plot3(r(1),r(2),r(3),'c.')

end

% plot_line([0 0 0],r,0.1,'r-',1,'r',12)

l_axis=0.8;
plot_line([0 0 0],[1 0 0],l_axis,'k-',2,'$X_I$',15)
plot_line([0 0 0],[0 1 0],l_axis,'k-',2,'$Y_I$',15)
plot_line([0 0 0],[0 0 1],l_axis,'k-',2,'$Z_I$',15)


[r,v]=oe2rv(oe_0,params.mu);
r=r';
v=v';
h=cross(r,v)/norm(cross(r,v));
s=v./norm(v);

plot3(r(1),r(2),r(3),'c*')


l_axis=0.6;
plot_line([0 0 0],r,1,'r:',2,'r',5)
plot_line(r,r./norm(r),l_axis,'k-',4,'$x_r$',14)
plot_line(r,s,l_axis,'k-',4,'$x_s$',14)
plot_line(r,h,l_axis,'K-',4,'$x_w$',14)


% plot_line(r,[1 0 0],1,'r:',2,'r',5)



% figure
hold on
view(-19,41);
plot_planet(a_0/10)
% plot_orbit(oe_0,'k:')







% % % % % % 
% % % % % % 
% % % % % % 
% % % % % % for i=1:n
% % % % % %     mark=0;
% % % % % %     for j=1:4
% % % % % % 
% % % % % %         if shape.V(shape.F(i,j),3)>0 && shape.V(shape.F(i,j),1)>0 && shape.V(shape.F(i,j),2)>0
% % % % % %             mark=1;
% % % % % %         end
% % % % % %     end
% % % % % %     if mark==0
% % % % % %         shape.F(i,:)=nan;
% % % % % %     end
% % % % % % 
% % % % % % end
% % % % % % 

shape.V=0.02*shape.V;
shape.V=shape.V+r;


astplt=[];
astplt.faces=shape.F;
astplt.vertices=shape.V;
nfv=reducepatch(astplt,0.05);
shape.V=nfv.vertices;
shape.F=nfv.faces;


astplt=drawMesh(shape.V, shape.F);

astplt.FaceAlpha=0.3;
astplt.EdgeAlpha=0.2;
astplt.FaceColor=[0.3020 0.1529 0.0235];
astplt.EdgeColor=[0.3020 0.1529 0];
lighting flat
material metal


oe_xx=oe_0;
oe_xx(6)=deg2rad(30);
oe_xx(3)=deg2rad(10);

[r1,v1]=oe2rv(oe_xx,params.mu);
r1=r1';
v1=v1';
h1=cross(r1,v1)/norm(cross(r1,v1));
s1=v1./norm(v1);

l_axis=0.7;
plot_line(r,h1,l_axis,'b-',1,'$x_b$',20)
plot_line(r,s1,l_axis,'b-',1,'$y_b$',20)
plot_line(r,cross(h1,s1),l_axis,'b-',1,'$z_b$',20)





% material dull
% camlight
% % % % % % 
% % % % % % 
% % % % % % 
% % % % % % view(59,11);
% % % % % % % r =1;
% % % % % % % phi = pi/4;
% % % % % % % theta = pi/4;
% % % % % % 
% % % % % % %% plot cartesian coordinates:
% % % % % % 
% % % % % % 
% % % % % % 
% % % % % % 
% % % % % % % plot3(x0+[0, x_ref, nan, 0, 0, nan, 0, 0], y0+[0, 0, nan, 0, y_ref, nan, 0, 0], z0+[0, 0, nan, 0, 0, nan, 0, z_ref],'k' )
% % % % % % % text([x0+.85, x0, x0], [y0, y0+.8, y0], [z0, z0, z0+.85], ['$x$';'$y$';'$z$'],'FontSize',14, 'Interpreter','latex');
% % % % % % 
% % % % % % lambda=30;
% % % % % % phi=40;
% % % % % % alpha=25;
% % % % % % beta=40;
% % % % % % 
% % % % % % cos_alpha=cosd(alpha);
% % % % % % sin_alpha=sind(alpha);
% % % % % % cos_beta=cosd(beta);
% % % % % % sin_beta=sind(beta);
% % % % % % 
% % % % % % 
% % % % % % [sat_pos,UP_vec,North_vec,Right_vec]=ellip_shape_3d(params.shape.V,params.shape.F,lambda,phi);
% % % % % % force_vec=cos_alpha*UP_vec+sin_alpha*cos_beta*North_vec+sin_alpha*sin_beta*Right_vec;
% % % % % % 
% % % % % % force_vec=force_vec*0.5;
% % % % % % 
% % % % % % plot3(0,0,0,'r.')
% % % % % % plot3(sat_pos(1),sat_pos(2),sat_pos(3),'r.')
% % % % % % 
% % % % % % p=[0 0 0];
% % % % % % d=sqrt(norm(sat_pos))/1.5;
% % % % % % thickness=1;
% % % % % % plot_line(p,[1 0 0],d,'k',thickness,'$x_b$',14)
% % % % % % plot_line(p,[0 1 0],d,'k',thickness,'$y_b$',14)
% % % % % % plot_line(p,[0 0 1],d,'k',thickness,'$z_b$',14)
% % % % % % plot_line(p,sat_pos,1,'r',thickness,'$ $',14)
% % % % % % text(0.5*sat_pos(1),0.5*sat_pos(2),0.6*sat_pos(3),'$r_i$','FontSize',14,'Interpreter','latex')
% % % % % % plot_line(sat_pos,sat_pos*0.5,1,'r:',thickness,'$ $',14)
% % % % % % 
% % % % % % v_par=dot(sat_pos,[0 0 1])*[0 0 1];
% % % % % % v_per=sat_pos-v_par;
% % % % % % plot_line(p,v_per,0.5,'k:',thickness,'$ $',14);
% % % % % % plot_arc(p,v_per,sat_pos,0.3,'$\phi_i$')
% % % % % % plot_arc(p,[1 0 0],v_per,0.6,'$\lambda_i$')
% % % % % % 
% % % % % % 
% % % % % % plot_line(sat_pos,UP_vec,d,'b',thickness,'$n$',14)
% % % % % % plot_line(sat_pos,Right_vec,d,'b',thickness,'$East$',10)
% % % % % % plot_line(sat_pos,North_vec,d,'b',thickness,'$North$',10)
% % % % % % 
% % % % % % plot_vec(sat_pos,force_vec,3,3,'$F_i$')
% % % % % % 
% % % % % % F=sat_pos+force_vec;
% % % % % % 
% % % % % % v_par=dot(force_vec,UP_vec)*UP_vec;
% % % % % % v_per=force_vec-v_par;
% % % % % % 
% % % % % % plot_line(sat_pos,v_per,3,'c:',thickness*2,'$ $',14)
% % % % % % 
% % % % % % plot_arc(sat_pos,North_vec,v_per,0.6,'$\beta_i$')
% % % % % % plot_arc(sat_pos,UP_vec,force_vec,0.6,'$\alpha_i$')
% % % % % % 
% % % % % % 
% % % % % % % plot_plane(sat_pos,UP_vec,1,'b',0.4)
% % % % % % 
% % % % % % plot_plane_2vec(sat_pos,Right_vec,North_vec,1,'b',0.4)
% % % % % % 
% % % % % % 
% % % % % % sin_a=sind(lambda);
% % % % % % cos_a=cosd(lambda);
% % % % % % sin_e=sind(phi);
% % % % % % cos_e=cosd(phi);
% % % % % % xd=1*cos_e*cos_a;
% % % % % % yd=1*cos_e*sin_a;
% % % % % % zd=1*sin_e;
% % % % % % 
% % % % % % dir   = [xd yd zd];
% % % % % % % plot_plane(sat_pos,dir,0.5,'r',0.4)
% % % % % % 
% % % % % % 
% % % % % % 
% % % % % % 
% % % % % % 
% % % % % % [sat_pos,UP_vec,North_vec,Right_vec]=ellip_shape_3d(params.shape.V,params.shape.F,0,90);
% % % % % % plot3(sat_pos(1),sat_pos(2),sat_pos(3),'r.')
% % % % % % text(sat_pos(1),sat_pos(2),1.1*sat_pos(3),'\uparrow N','FontSize',14)


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


function plot_line(p,dir,d,style,thickness,name,font_size)

p2=p+d*dir;
XYZ=[p;p2];
plt=plot3(XYZ(:,1),XYZ(:,2),XYZ(:,3),style);
plt.LineWidth=thickness;

p2=p+1.2*d*dir;
text(p2(1),p2(2),p2(3),name,'FontSize',font_size, 'Interpreter','latex')

end

function plot_vec(p,dir,d,thickness,name)

p2=p+d*dir;
% XYZ=[p;p2];
plt=quiver3(p(1),p(2),p(3),d*dir(1),d*dir(2),d*dir(3));

plt.LineWidth=thickness;
plt.MaxHeadSize=1;
plt.Color='c';
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

function plot_plane_2vec(p0,vec1,vec2,plane_size,color,face_alpha)

% w = null(normal_vec); % Find two orthonormal vectors which are orthogonal to v
w=[vec1' vec2'];
[P,Q] = meshgrid(-plane_size:plane_size); % Provide a gridwork (you choose the size)
X = p0(1)+w(1,1)*P+w(1,2)*Q; % Compute the corresponding cartesian coordinates
Y = p0(2)+w(2,1)*P+w(2,2)*Q; %   using the two vectors in w
Z = p0(3)+w(3,1)*P+w(3,2)*Q;
plt_pln=surf(X,Y,Z,FaceColor=color,FaceAlpha=face_alpha,EdgeColor='none');

end