function dx = dynamics(x,u,p)


mu=p.mu;



X = x(1,:);
Y = x(2,:);
Z = x(3,:);
Xdot = x(4,:);
Ydot = x(5,:);
Zdot = x(6,:);

force_r=u(1,:);
force_s=u(2,:);
force_w=u(3,:);

r=sqrt(X.^2+Y.^2+Z.^2);

dir_r=[X;Y;Z]./r;

c1=-mu./r.^3;

dX = Xdot;
dY = Ydot;
dZ = Zdot;
dXdot = c1.*X+dir_r(1,:).*force_r;
dYdot = c1.*Y+dir_r(2,:).*force_r;
dZdot = c1.*Z+dir_r(3,:).*force_r;


dx=[dX;dY;dZ;dXdot;dYdot;dZdot];

end