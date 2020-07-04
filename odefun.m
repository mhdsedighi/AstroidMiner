function dxdt = odefun(t,x)


% global control_plan


dxdt = zeros(6,1);

mu=3.986005*10^5;
c1=-mu/((sqrt(x(1)^2+x(2)^2+x(3)^2))^3);


% df_x=0;
% df_y=0;
% df_z=0;
% 
% if control_plan.N<=control_plan.N_max
%     if t>control_plan.times(control_plan.N)
%         df_x=control_plan.impulses(1,control_plan.N);
%         df_y=control_plan.impulses(2,control_plan.N);
%         df_z=control_plan.impulses(3,control_plan.N);
%         %         df_z=1;
%         if t>control_plan.times(control_plan.N)+1
%             control_plan.N=control_plan.N+1;
%         end
%     end
% end
% 
% dxdt(1) = x(4);
% dxdt(2) = x(5);
% dxdt(3) = x(6);
% dxdt(4) = c1*x(1)+df_x;
% dxdt(5) = c1*x(2)+df_y;
% dxdt(6) = c1*x(3)+df_z;



dxdt(1) = x(4);
dxdt(2) = x(5);
dxdt(3) = x(6);
dxdt(4) = c1*x(1);
dxdt(5) = c1*x(2);
dxdt(6) = c1*x(3);

end