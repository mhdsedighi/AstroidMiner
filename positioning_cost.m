function cost=positioning_cost(azi_ele,N_cube,a,b,c,F_cube)

azimuths=azi_ele(1:N_cube);
elevations=azi_ele(N_cube+1:end);

F=[0 0 0];
M=[0 0 0];
F_array=zeros(N_cube,3);
M_array=zeros(N_cube,3);

for i=1:N_cube
    
    [x,y,z,R,normal_vector]=ellip_deg(a,b,c,azimuths(i),elevations(i));
    
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

F_dir_cost=(sum_F_x-sum_F_minus_x)^2+(sum_F_y-sum_F_minus_y)^2+(sum_F_z-sum_F_minus_z)^2;
% cost=cost_neutral_force*F_dir_cost
% norm(F)
% norm(M)

cost=F_dir_cost;

end