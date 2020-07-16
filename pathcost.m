function out=pathcost(t,x,u)

% [N_sat,N_time]=size(u);
% 
% delta_all=0;
% 
% for i=2:N_time-1
%     for j=1:N_sat
%         
%         delta=(u(j,i)-u(j,i-1))^2;
%         
%         if delta>delta_all
%             delta_all=delta;
%             
%         end
%     end
%     
%     
% end
% 
% delta_end=sum(u(:,N_time)-u(:,N_time-1).^2);
% 
% out=(1e10*delta_all*delta_end^5)*sum(u.^2);

out=sum(u.^2);

end