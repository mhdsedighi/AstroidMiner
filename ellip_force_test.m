clc
clear
close all


a=5;
b=4;
c=2;

N_cube=20;

F_cube=1;






lb=[0*ones(1,N_cube) -90*ones(1,N_cube)];
ub=[360*ones(1,N_cube) 90*ones(1,N_cube)]; 

azimuths=rand(1,N_cube)*360;
elevations=rand(1,N_cube)*180-90;

azi_ele=[azimuths elevations];

% for i=1:N_cube
% 
% [x,y,z,R,normal_vector]=ellip_deg(a,b,c,azimuths(i),elevations(i));
% plot3(x,y,z,'b.')
% plot_vector(x,y,z,normal_vector)
% 
% end
% cost=positioning_cost(azi_ele,N_cube,a,b,c,F_cube)


x0=(lb+ub)/2;
% x0=rand*(ub-lb)+lb;

options = optimoptions('simulannealbnd');
%%% Modify options setting
options = optimoptions(options,'FunctionTolerance', 1e-3);
options = optimoptions(options,'MaxIterations', 2e3);
options = optimoptions(options,'Display', 'off');
options = optimoptions(options,'HybridInterval', 'end');
options = optimoptions(options,'PlotFcn', {  @saplotbestf @saplotbestx });
[x_opt,cost_opt,exitflag,output] = ...
simulannealbnd(@(azi_ele)positioning_cost(azi_ele,N_cube,a,b,c,F_cube),x0,lb,ub,options);



azimuths=x_opt(1:N_cube);
elevations=x_opt(N_cube+1:end);
figure
hold on
axis equal
view(25,45)
[x_surf, y_surf, z_surf] = ellipsoid(0,0,0,a,b,c,35);
surf(x_surf, y_surf,z_surf,'FaceAlpha',0.5,'EdgeColor','none');
plot3(0,0,0,'ro')
for i=1:N_cube
    
    [x,y,z,R,normal_vector]=ellip_deg(a,b,c,azimuths(i),elevations(i));
    plot3(x,y,z,'b.')
    plot_vector(x,y,z,normal_vector)
    
end






