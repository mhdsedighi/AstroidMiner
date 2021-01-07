function dx = rot_dynamics(x,u,params)

% mu=params.mu;

% N_sat=params.N_sat;
% Force_Vectors=params.Force_Vectors;
% Moment_Vectors=params.Moment_Vectors;

% Ixx=params.Ixx;
% Iyy=params.Iyy;
% Izz=params.Izz;
% Ixy=params.Ixy;
% Ixz=params.Ixz;
% Iyz=params.Iyz;
% 
% 
% p=x(1,:);
% q=x(2,:);
% r=x(3,:);

% quat0=x(4,:);
% quat1=x(5,:);
% quat2=x(6,:);
% quat3=x(7,:);

% pmee = x(4,:);
% fmee = x(5,:);
% gmee = x(6,:);
% hmee = x(7,:);
% xkmee = x(9,:);
% xlmee = x(10,:);








%%%%%%%%%%%%%%%%%%%%%%%%%%%%% finding total force and moment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% N_time=length(p);
% L=zeros(1,N_time);
% M=zeros(1,N_time);
% N=zeros(1,N_time);
% for i=1:N_sat
%    L=L+u(i,:)*Moment_Vectors(i,1);
%    M=M+u(i,:)*Moment_Vectors(i,2);
%    N=N+u(i,:)*Moment_Vectors(i,3);
% end

% L=u(1,:);
% M=u(2,:);
% N=u(3,:);


% F_x=zeros(1,N_time);
% F_y=zeros(1,N_time);
% F_z=zeros(1,N_time);
% pert_1=zeros(1,N_time);
% pert_2=zeros(1,N_time);
% pert_3=zeros(1,N_time);
% DCM_mats=quat2dcm([quat0' quat1' quat2' quat3']);
% for i=1:N_time
%     for j=1:N_sat
%         F_x(i)=F_x(i)+u(j,i)*(DCM_mats(1,1,i)*Force_Vectors(j,1)+DCM_mats(2,1,i)*Force_Vectors(j,2)+DCM_mats(3,1,i)*Force_Vectors(j,3));
%         F_y(i)=F_y(i)+u(j,i)*(DCM_mats(1,2,i)*Force_Vectors(j,1)+DCM_mats(2,2,i)*Force_Vectors(j,2)+DCM_mats(3,2,i)*Force_Vectors(j,3));
%         F_z(i)=F_z(i)+u(j,i)*(DCM_mats(1,3,i)*Force_Vectors(j,1)+DCM_mats(2,3,i)*Force_Vectors(j,2)+DCM_mats(3,3,i)*Force_Vectors(j,3));
%     end
% end
% %%% to be optimised: F_x does not need to be an array.
% for i=1:N_time
%     this_mee=x(8:13,i);
%     [R,V] = mee2rv(this_mee,mu);
%     Force_rsw=xyz2rsw([F_x(i);F_y(i);F_z(i)],R,V);
%     pert_1(i)=Force_rsw(1);
%     pert_2(i)=Force_rsw(2);
%     pert_3(i)=Force_rsw(3);
% end

% pert_1=u(1,:);
% pert_2=u(2,:);
% pert_3=u(3,:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% p_dot=(L + Iyy.*q.*r - Izz.*q.*r)/Ixx; 
% q_dot=(M - Ixx.*p.*r + Izz.*p.*r)/Iyy; 
% r_dot=(N + Ixx.*p.*q - Iyy.*p.*q)/Izz;


% term1=Izz.*Ixy.^2 + 2.*Ixy.*Ixz.*Iyz + Iyy.*Ixz.^2 + Ixx.*Iyz.^2 - Ixx.*Iyy.*Izz;
% term2=L + p.*(Ixz.*q - Ixy.*r) + q.*(Iyz.*q + Iyy.*r) - r.*(Izz.*q + Iyz.*r);
% term3=M - p.*(Ixz.*p + Ixx.*r) - q.*(Iyz.*p - Ixy.*r) + r.*(Izz.*p + Ixz.*r);
% term4=N + p.*(Ixy.*p + Ixx.*q) - q.*(Iyy.*p + Ixy.*q) + r.*(Iyz.*p - Ixz.*q);
% term5=Ixz.*Iyz + Ixy.*Izz;
% term6=Ixy.*Iyz + Ixz.*Iyy;
% term7=Ixy.*Ixz + Ixx.*Iyz;
% 
% p_dot=(Iyz.^2-Iyy.*Izz.*term2-term6.*term4-term5.*term3)./term1;
% q_dot=(Ixz.^2-Ixx.*Izz.*term3-term7.*term4-term5.*term2)./term1;
% r_dot=(Ixy.^2-Ixx.*Iyy.*term4-term6.*term3-term6.*term2)./term1;

[~,N_time]=size(x);
pqr_dot=zeros(3,N_time);
for i=1:N_time
    
    Moment=u(:,i);
    
    pqr_dot(:,i)=params.inv_Inertia*(Moment - cross(x(1:3,i),params.Inertia*x(1:3,i)));
    
end



% quat0_dot=-0.5*(p.*quat1+q.*quat2+r.*quat3);
% quat1_dot=0.5*(p.*quat0+r.*quat2-q.*quat3);
% quat2_dot=0.5*(q.*quat0-r.*quat1+p.*quat3);
% quat3_dot=0.5*(r.*quat0+q.*quat1-p.*quat2);

%%%%%%% orbital dynamics
% smovrp = sqrt(mu ./ pmee);
% tani2s = hmee.^2 + xkmee.^2;
% cosl = cos(xlmee);
% sinl = sin(xlmee);
% wmee = 1.0 + fmee .* cosl + gmee .* sinl;
% ssqrd = 1.0 + tani2s;
% meedot_1 = 2.0 .* pmee .* pert_2 ./ (wmee .* smovrp);
% term1 = ((wmee + 1.0) .* cosl + fmee) .* pert_2;
% term2 = (hmee .* sinl - xkmee .* cosl) .* gmee .* pert_3;
% meedot_2 = (pert_1 .* sinl + (term1 - term2) ./ wmee) ./ smovrp;
% term1 = ((wmee + 1.0) .* sinl + gmee) .* pert_2;
% term2 = (hmee .* sinl - xkmee .* cosl) .* fmee .* pert_3;
% meedot_3 = (-pert_1 .* cosl + (term1 + term2) ./ wmee) ./ smovrp;
% term1 = ssqrd .* pert_3 ./ (2.0 .* wmee .* smovrp);
% meedot_4 = term1 .* cosl;
% meedot_5 = term1 .* sinl;
% meedot_6 = sqrt(mu .* pmee) .* (wmee ./ pmee).^2 ...
%     + (hmee .* sinl - xkmee .* cosl) .* pert_3./(wmee .* smovrp);

%%%%%%%

% 
% dx=[p_dot;q_dot;r_dot;quat0_dot;quat1_dot;quat2_dot;quat3_dot;meedot_1;meedot_2;meedot_3;meedot_4;meedot_5;meedot_6];


% dx=[p_dot;q_dot;r_dot];

dx=pqr_dot;


end