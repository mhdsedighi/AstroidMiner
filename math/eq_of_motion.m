clc
clear
syms L M N p q r Ixx Iyy Izz Ixy Ixz Ixy Iyz

Ixy=0
Ixz=0
Iyz=0

I=[Ixx -Ixy -Ixz;-Ixy Iyy -Iyz;-Ixz -Iyz Izz];
omega=[p;q;r];
OMEGA=[0 -r q;r 0 -p;-q p 0];
m=[L;M;N];

eq1=inv(I)*(m-OMEGA*I*omega);

p_dot=eq1(1);
q_dot=eq1(2);
r_dot=eq1(3);

pretty(simplify(eq1))


% term1=Izz*Ixy^2 + 2*Ixy*Ixz*Iyz + Iyy*Ixz^2 + Ixx*Iyz^2 - Ixx*Iyy*Izz;
% term2=L + p*(Ixz*q - Ixy*r) + q*(Iyz*q + Iyy*r) - r*(Izz*q + Iyz*r);
% term3=M - p*(Ixz*p + Ixx*r) - q*(Iyz*p - Ixy*r) + r*(Izz*p + Ixz*r);
% term4=N + p*(Ixy*p + Ixx*q) - q*(Iyy*p + Ixy*q) + r*(Iyz*p - Ixz*q);
% term5=Ixz*Iyz + Ixy*Izz;
% term6=Ixy*Iyz + Ixz*Iyy;
% term7=Ixy*Ixz + Ixx*Iyz;
% 
% p_dot=(Iyz^2-Iyy*Izz*term2-term6*term4-term5*term3)/term1
% q_dot=(Ixz^2-Ixx*Izz*term3-term7*term4-term5*term2)/term1
% r_dot=(Ixy^2-Ixx*Iyy*term4-term6*term3-term6*term2)/term1
