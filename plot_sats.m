close all
figure
hold on
axis equal
view(25,45)
[x_surf, y_surf, z_surf] = ellipsoid(0,0,0,a,b,c,35);
surf(x_surf, y_surf,z_surf,'FaceAlpha',0.1,'EdgeColor','none');
plot3(0,0,0,'ro')
% Force_Vectors=[];
% Moment_Vectors=[];

% plot_vector(0,0,0,[1 0 0])

% plot1=quiver3([0 1],[0 1],[0 1],[1 0],[1 0],[1 1]);
% 
% lamda=30;
% gamma=50;

sat_pos=zeros(N_sat,3);
UP_vec=zeros(N_sat,3);
North_vec=zeros(N_sat,3);
Right_vec=zeros(N_sat,3);
force_vec=zeros(N_sat,3);

for i=1:N_sat
    
    [sat_pos(i,:),UP_vec(i,:),North_vec(i,:),Right_vec(i,:)]=ellip_shape(a,b,c,azimuths(i),elevations(i));
    
    
    force_vec(i,:)=cosd(gammas(i))*UP_vec(i,:)+sind(gammas(i))*cosd(lambdas(i))*North_vec(i,:)+sind(gammas(i))*sind(lambdas(i))*Right_vec(i,:);
    
    
end

scale=0.1;

UP_vec=UP_vec*scale;
North_vec=North_vec*scale;
Right_vec=Right_vec*scale;

plt0=quiver3(0,0,0,5,0,0);

plt1=quiver3(sat_pos(:,1),sat_pos(:,2),sat_pos(:,3),UP_vec(:,1),UP_vec(:,2),UP_vec(:,3));
plt2=quiver3(sat_pos(:,1),sat_pos(:,2),sat_pos(:,3),North_vec(:,1),North_vec(:,2),North_vec(:,3));
plt3=quiver3(sat_pos(:,1),sat_pos(:,2),sat_pos(:,3),Right_vec(:,1),Right_vec(:,2),Right_vec(:,3));
plt4=quiver3(sat_pos(:,1),sat_pos(:,2),sat_pos(:,3),force_vec(:,1),force_vec(:,2),force_vec(:,3));

plt1.Color=[0.6350, 0.0780, 0.1840];
plt2.Color=[0.4660, 0.6740, 0.1880];
plt3.Color=[0, 0.4470, 0.7410];
plt1.LineStyle=':';
% plt1.LineWidth=1.5
plt2.LineStyle=':';
plt3.LineStyle=':';
plt1.ShowArrowHead=0;
plt2.ShowArrowHead=0;
plt3.ShowArrowHead=0;

plt4.Color=[0.25, 0.25, 0.25];
