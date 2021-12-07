function oe=mp2oe(mp)


oe=mp;

a=mp(1);
ep1=mp(2);
ep2=mp(3);
zig1=mp(4);
zig2=mp(5);
lambda=mp(6);

two_pi=6.283185307179586;


% % ep1=e*sin(omega+OMEGA);
% % ep2=e*cos(omega+OMEGA);
% % zig1=tan(inc/2)*sin(OMEGA);
% % zig2=tan(inc/2)*cos(OMEGA);
% % lambda=theta+omega+OMEGA;
% % 
% % mp=[a;ep1;ep2;zig1;zig2;lambda];

e=sqrt(ep1^2+ep2^2);
inc=2*atan(sqrt(zig1^2+zig2^2));

if inc==0
    OMEGA=0;
else
    tan1=tan(inc/2);
    OMEGA=atan3(zig1/tan1,zig2/tan1);
end

if OMEGA<0
    OMEGA=OMEGA+two_pi;
end


if e==0
    omega=0;
else
    omega=atan3(ep1/e,ep2/e)-OMEGA;
end

if omega<0
    omega=omega+two_pi;
end


theta=lambda-omega-OMEGA;
if theta<0
    theta=theta+two_pi;
elseif theta>two_pi
    theta=rem(theta,two_pi);
end

oe(1)=a;
oe(2)=e;
oe(3)=inc;
oe(4)=omega;
oe(5)=OMEGA;
oe(6)=theta;


end