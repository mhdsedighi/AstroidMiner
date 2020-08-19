function out=cost2(t,x,u)



N=length(t);
y=zeros(1,N);
residual=zeros(1,N);


% cost1=ones(1,N)*1e-5;
% cost1=zeros(1,N);
cost_repo_limt=1;


for i=1:N
    
%     if t(i)>=20 && t(i)<=50
%         
%         y(i)=14;
%     elseif t(i)>=100 && t(i)<=110
%         
%         y(i)=20;
%         
%     else
        y(i)=5;
%     end
    
    % out=sum(u.^2)*(10+t(end))^2*sum((x-y));
    
    
end

% flag=0;

for i=2:N
    
    %     resid(i)=sum(x(1:i))-sum(y(1:i));
    
    tt=t(1:i);
    xx=x(1:i);
    yy=y(1:i);
    residual(i)=trapz(tt,xx)-trapz(tt,yy);
    %     if sum(x(1:i))<y || x(i)-y(i)>50
    %     if (flag==0) && (resid<0 || resid >50)
    %         cost1=cost1+10;
    % %         flag=1;
    % %     else
    % %         cost1=cost1-1000;
    %     end
    
    
%     if  (resid(i)<0)
%         cost1(i)=-resid(i);
%     end
%     
%     if  (resid(i)>50)
%         cost1(i)=(resid(i)-50);
%     end

    if  (residual(i)<0)
        cost_repo_limt=cost_repo_limt-10*residual(i);
    end
    
    if  (residual(i)>50)
        cost_repo_limt=cost_repo_limt+(residual(i)-50);
    end
    
    
end

%     out=u.^2+cost1;

% out=(1e3+u).*cost1;


% out=(10+u).*(resid-35).^2+cost1;

% int_cost=(u-floor(u)).^2+(x-floor(x)).^2;
% out=(10+u).*cost1.*(resid-35).^2.*(1+int_cost);


cost_repo=residual-35;
cost_repo(1)=1;

out=(1+u).*cost_repo_limt.*(cost_repo).^2;
% out=cost1.^2+(repo).^2;

% out=(1+u).*cost1;

end