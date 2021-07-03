close all
figure
hold on
axis equal
view(25,45)




% [x_surf, y_surf, z_surf] = ellipsoid(0,0,0,a,b,c,35);
% surf(x_surf, y_surf,z_surf,'FaceAlpha',0.1,'EdgeColor','none');

% params.shape.V=shape.V;
% params.shape.F=shape.F;

if assume_ellipsoid
    [x_surf, y_surf, z_surf] = ellipsoid(0,0,0,params.a,params.b,params.c,35);
    astplt=surf(x_surf, y_surf,z_surf,'FaceAlpha',0.1,'EdgeColor','none');
else  
    astplt=drawMesh(shape.V, shape.F);
end

astplt.FaceAlpha=0.6;
astplt.EdgeAlpha=0;
astplt.FaceColor=[0.3020 0.1529 0.0235];
astplt.EdgeColor=[0.3020 0.1529 0];
% lighting flat
% material metal
material dull
camlight

plot3(0,0,0,'ro')


sat_pos=zeros(N_sat,3);
UP_vec=zeros(N_sat,3);
North_vec=zeros(N_sat,3);
Right_vec=zeros(N_sat,3);
force_vec=zeros(N_sat,3);

for i=1:N_sat
    
    if assume_ellipsoid
        [sat_pos(i,:),UP_vec(i,:),North_vec(i,:),Right_vec(i,:)]=ellip_shape(params.a,params.b,params.c,azimuths(i),elevations(i));     
    else
        [sat_pos(i,:),UP_vec(i,:),North_vec(i,:),Right_vec(i,:)]=ellip_shape_3d(shape.V,shape.F,azimuths(i),elevations(i));
    end
    
    
    force_vec(i,:)=cosd(gammas(i))*UP_vec(i,:)+sind(gammas(i))*cosd(lambdas(i))*North_vec(i,:)+sind(gammas(i))*sind(lambdas(i))*Right_vec(i,:);
    
end

scale=1*params.a/5;

UP_vec=UP_vec*scale;
North_vec=North_vec*scale;
Right_vec=Right_vec*scale;
force_vec=force_vec*scale;

plt0=quiver3(0,0,0,params.a/4,0,0);

plt1=quiver3(sat_pos(:,1),sat_pos(:,2),sat_pos(:,3),UP_vec(:,1),UP_vec(:,2),UP_vec(:,3));
plt2=quiver3(sat_pos(:,1),sat_pos(:,2),sat_pos(:,3),North_vec(:,1),North_vec(:,2),North_vec(:,3));
plt3=quiver3(sat_pos(:,1),sat_pos(:,2),sat_pos(:,3),Right_vec(:,1),Right_vec(:,2),Right_vec(:,3));
plt4=quiver3(sat_pos(:,1),sat_pos(:,2),sat_pos(:,3),force_vec(:,1),force_vec(:,2),force_vec(:,3));

plt1.Color=[0.6350, 0.0780, 0.1840];
plt2.Color=[0.4660, 0.6740, 0.1880];
plt3.Color=[0, 0.4470, 0.7410];
plt4.Color=[0.25, 0.25, 0.25];

% plt1.LineStyle=':';
% plt2.LineStyle=':';
% plt3.LineStyle=':';
plt1.ShowArrowHead=0;
plt2.ShowArrowHead=0;
plt3.ShowArrowHead=0;
plt1.LineWidth=1.5;
plt2.LineWidth=1.5;
plt3.LineWidth=1.5;
plt4.LineWidth=3;


plt1.AutoScale=0;
plt2.AutoScale=0;
plt3.AutoScale=0;
plt4.AutoScale=0;
