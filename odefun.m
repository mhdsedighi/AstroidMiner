function dxdt = odefun(t,x)
dxdt = zeros(6,1);

mu=3.986005*10^5;
c1=-mu/((sqrt(x(1)^2+x(2)^2+x(3)^2))^3);

dxdt(1) = x(4);
dxdt(2) = x(5);
dxdt(3) = x(6);
dxdt(4) = c1*x(1);
dxdt(5) = c1*x(2);
dxdt(6) = c1*x(3);

end