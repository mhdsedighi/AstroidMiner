function dx = rotation_dynamics(x,u,params)

% L M N p q r Ixx Iyy Izz Ixy Ixz Iyz


Ixx=100;
Iyy=100;
Izz=100;
Ixy=0;
Ixz=0;
Iyz=0;


L=u(1,:);
M=u(1,:);
N=u(1,:);


p=x(1,:);
q=x(2,:);
r=x(3,:);



% u_dot=F_x./m+r.*v-q.*w;
% v_dot=F_y./m-r.*u+p.*w;
% w_dot=F_z./m+q.*u-p.*v;



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



dx(1,:)=p_dot;
dx(2,:)=q_dot;
dx(3,:)=r_dot;

end