clc
% clear
close all


a=5;
b=4;
c=2;

N_sat=12;

F_cube=1;






lb=[0*ones(1,N_sat) -90*ones(1,N_sat)];
ub=[360*ones(1,N_sat) 90*ones(1,N_sat)]; 

lambdas=rand(1,N_sat)*360;
phis=rand(1,N_sat)*180-90;

azi_ele=[lambdas phis];

% for i=1:N_cube
% 
% [x,y,z,R,normal_vector]=ellip_deg(a,b,c,lambdas(i),phis(i));
% plot3(x,y,z,'b.')
% plot_vector(x,y,z,normal_vector)
% 
% end
% cost=positioning_cost(azi_ele,N_cube,a,b,c,F_cube)


% x0=(lb+ub)/2;
x0=rand(1,2*N_sat).*(ub-lb)+lb;

% options = optimoptions('simulannealbnd');
% %%% Modify options setting
% options = optimoptions(options,'FunctionTolerance', 1e-3);
% options = optimoptions(options,'MaxIterations', 2e3);
% options = optimoptions(options,'Display', 'off');
% options = optimoptions(options,'HybridInterval', 'end');
% options = optimoptions(options,'PlotFcn', {  @saplotbestf @saplotbestx });
% [x_opt,cost_opt,exitflag,output] = ...
% simulannealbnd(@(azi_ele)positioning_cost(azi_ele,N_sat,a,b,c,F_cube),x0,lb,ub,options);


lambdas=[-45 45 180+45   180-45   90         90       0      0 30]
phis=[0 0    0         0     90+30      90-30    -90+30 -90-30 -90]

% lambdas=[0]
% phis=[45]





N_sat=length(lambdas);
figure
hold on
axis equal
view(25,45)
[x_surf, y_surf, z_surf] = ellipsoid(0,0,0,a,b,c,35);
surf(x_surf, y_surf,z_surf,'FaceAlpha',0.1,'EdgeColor','none');
plot3(0,0,0,'ro')
Force_Vectors=[];
Moment_Vectors=[];

plot_vector(0,0,0,[1 0 0])

lamda=30;
alpha=50;

for i=1:N_sat
    
    [x,y,z,UP_vec,North_vec,Right_vec]=ellip_deg(a,b,c,lambdas(i),phis(i));
    plot3(x,y,z,'b.')
    plot_vector(x,y,z,UP_vec*2)
    plot_vector(x,y,z,North_vec*2)
    
    
    force_vec=cosd(alpha)*UP_vec+sind(alpha)*cosd(lamda)*North_vec+sind(alpha)*sind(lamda)*Right_vec;
    plot_vector(x,y,z,Right_vec*2)
    plot_vector(x,y,z,force_vec*3)
    
    
    Force_Vectors=[Force_Vectors;force_vec];
    Moment_Vectors=[Moment_Vectors;cross([x y z],force_vec)];
    
end


params.Force_Vectors=Force_Vectors;
params.Moment_Vectors=Moment_Vectors;
params.N_sat=N_sat;


save params params




