

a_dot=2*e*sin(theta)/(n*x)*F_r+2*a*x/(n*r)*F_s;
e_dot=x*sin(theta)/(n*a)*F_r+x/(n*a^2*e)*((a^2*x^2)/r-r)*F_s;
i_dot=r*cos(u)/(n*a^2*x)*F_w;
OMEGA_dot=r*sin(u)/(n*a^2*x*sin(i))*F_w;
omega_dot=-x*cos(theta)/(n*a*e)*F_r+(p/(e*h))*(sin(theta)*(1+(1/(1+e*cos(theta)))))*F_s-r*cot(i)*sin(u)/(n*a^2*x)*F_w;
M_dot=n-1/(n*a)*(2*r/a-(x^2)/e*cos(theta))*F_r-x^2/(n*a*e)*(1+r/(a*x^2))*sin(theta)*F_s;
