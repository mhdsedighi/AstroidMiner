function oe=mp2oe(mp)

%%%% note: does not support inc<0 !!!

oe=mp;

a=mp(1);
ep1=mp(2);
ep2=mp(3);
zig1=mp(4);
zig2=mp(5);
lambda=mp(6);


% % ep1=e*sin(omega+OMEGA);
% % ep2=e*cos(omega+OMEGA);
% % zig1=tan(inc/2)*sin(OMEGA);
% % zig2=tan(inc/2)*cos(OMEGA);
% % lambda=theta+omega+OMEGA;
% % 
% % mp=[a;ep1;ep2;zig1;zig2;lambda];

%%% to be optimized
e=sqrt(ep1^2+ep2^2);
inc=2*atan(sqrt(zig1^2+zig2^2));

if inc==0
    OMEGA=0;
else
    tan1=tan(inc/2);
    OMEGA=atan3(zig1/tan1,zig2/tan1);
end


% if sign(zig2)*sign(cos(OMEGA))<0 || sign(zig1)*sign(sin(OMEGA))<0 
%     inc=-inc;
% end


if OMEGA>pi
    OMEGA=OMEGA-2*pi;
end

% inc=inc*(sign(zig2)*sign(cos(OMEGA)));

if e==0
    omega=0;
else
    omega=atan3(ep1/e,ep2/e)-OMEGA;
end


theta=lambda-omega-OMEGA;
if theta<0
    theta=theta+2*pi;
end

if theta>2*pi
    theta=rem(theta,2*pi);
end

oe(1)=a;
oe(2)=e;
oe(3)=inc;
oe(4)=omega;
oe(5)=OMEGA;
oe(6)=theta;


end