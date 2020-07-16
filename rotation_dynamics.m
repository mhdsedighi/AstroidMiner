function dx = rotation_dynamics(x,u,params)


N_sat=params.N_sat;
% Force_Vectors=params.Force_Vectors;
Moment_Vectors=params.Moment_Vectors;

Ixx=1000;
Iyy=1000;
Izz=1000;
Ixy=0;
Ixz=0;
Iyz=0;


p=x(1,:);
q=x(2,:);
r=x(3,:);

quat0=x(4,:);
quat1=x(5,:);
quat2=x(6,:);
quat3=x(7,:);

n_time=length(p);






%%%%%%%%%%%%%%%%%%%%%%%%%%%%% finding total force and moment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L=zeros(1,n_time);
M=zeros(1,n_time);
N=zeros(1,n_time);
for i=1:N_sat
   L=L+u(i,:)*Moment_Vectors(i,1);
   M=M+u(i,:)*Moment_Vectors(i,2);
   N=N+u(i,:)*Moment_Vectors(i,3);
end




% F_x=zeros(1,n_time);
% F_y=zeros(1,n_time);
% F_z=zeros(1,n_time);
% DCM_mats=quat2dcm([quat0' quat1' quat2' quat3']);
% for i=1:n_time
%     for j=1:N_sat
%         F_x(i)=F_x(i)+u(j,i)*(DCM_mats(1,1,i)*Force_Vectors(j,1)+DCM_mats(2,1,i)*Force_Vectors(j,2)+DCM_mats(3,1,i)*Force_Vectors(j,3));
%         F_y(i)=F_y(i)+u(j,i)*(DCM_mats(1,2,i)*Force_Vectors(j,1)+DCM_mats(2,2,i)*Force_Vectors(j,2)+DCM_mats(3,2,i)*Force_Vectors(j,3));
%         F_z(i)=F_z(i)+u(j,i)*(DCM_mats(1,3,i)*Force_Vectors(j,1)+DCM_mats(2,3,i)*Force_Vectors(j,2)+DCM_mats(3,3,i)*Force_Vectors(j,3));
%     end
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




term1=Izz.*Ixy.^2 + 2.*Ixy.*Ixz.*Iyz + Iyy.*Ixz.^2 + Ixx.*Iyz.^2 - Ixx.*Iyy.*Izz;
term2=L + p.*(Ixz.*q - Ixy.*r) + q.*(Iyz.*q + Iyy.*r) - r.*(Izz.*q + Iyz.*r);
term3=M - p.*(Ixz.*p + Ixx.*r) - q.*(Iyz.*p - Ixy.*r) + r.*(Izz.*p + Ixz.*r);
term4=N + p.*(Ixy.*p + Ixx.*q) - q.*(Iyy.*p + Ixy.*q) + r.*(Iyz.*p - Ixz.*q);
term5=Ixz.*Iyz + Ixy.*Izz;
term6=Ixy.*Iyz + Ixz.*Iyy;
term7=Ixy.*Ixz + Ixx.*Iyz;

p_dot=(Iyz.^2-Iyy.*Izz.*term2-term6.*term4-term5.*term3)./term1;
q_dot=(Ixz.^2-Ixx.*Izz.*term3-term7.*term4-term5.*term2)./term1;
r_dot=(Ixy.^2-Ixx.*Iyy.*term4-term6.*term3-term6.*term2)./term1;

quat0_dot=-0.5*(p.*quat1+q.*quat2+r.*quat3);
quat1_dot=0.5*(p.*quat0+r.*quat2-q.*quat3);
quat2_dot=0.5*(q.*quat0-r.*quat1+p.*quat3);
quat3_dot=0.5*(r.*quat0+q.*quat1-p.*quat2);





dx(1,:)=p_dot;
dx(2,:)=q_dot;
dx(3,:)=r_dot;
dx(4,:)=quat0_dot;
dx(5,:)=quat1_dot;
dx(6,:)=quat2_dot;
dx(7,:)=quat3_dot;


end