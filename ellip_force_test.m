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
F_array=[];
M_array=[];

figure
hold on
axis equal
view(25,45)
[x_surf, y_surf, z_surf] = ellipsoid(0,0,0,a,b,c,35);
surf(x_surf, y_surf,z_surf,'FaceAlpha',0.5,'EdgeColor','none');
plot3(0,0,0,'ro')

azimuths=rand(1,N_cube)*360;
elevations=rand(1,N_cube)*180-90;

for i=1:N_cube

[x,y,z,R,normal_vector]=ellip_deg(a,b,c,azimuths(i),elevations(i));
plot3(x,y,z,'b.')
plot_vector(x,y,z,normal_vector)

F=F+normal_vector*F_cube;
M=M+cross([x y z],F);
F_array=[F_array;F];
M_array=[M_array;M];

end

% F_x=sum(F_array(:,1));
% F_y=sum(F_array(:,2));
% F_z=sum(F_array(:,3));
% M_x=sum(M_array(:,1));
% M_y=sum(M_array(:,2));
% M_z=sum(M_array(:,3));

sum_F_x=available_F_at_dir(F_array,[1 0 0]);
sum_F_minus_x=available_F_at_dir(F_array,[-1 0 0]);
sum_F_y=available_F_at_dir(F_array,[0 1 0]);
sum_F_minus_y=available_F_at_dir(F_array,[0 -1 0]);
sum_F_z=available_F_at_dir(F_array,[0 0 1]);
sum_F_minus_z=available_F_at_dir(F_array,[0 0 -1]);

% cost_neutral_force=0;
% for i=1:N_cube
%     for j=1:N_cube
%         if i~=j
%             neutral_factor=dot(F_array(i,:),F_array(j,:));
% %             if neutral_factor<0
%                 cost_neutral_force=cost_neutral_force+sign(neutral_factor)*(neutral_factor)^2;
% %             end
%         end
%     end
% end
% cost_neutral_force

F_dir_cost=(sum_F_x-sum_F_minus_x)^2+(sum_F_y-sum_F_minus_y)^2+(sum_F_z-sum_F_minus_z)^2
% cost=cost_neutral_force*F_dir_cost
% norm(F)
% norm(M)






