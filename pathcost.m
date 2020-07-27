function out=pathcost(t,x,u)

% u=floor(u);
% x=floor(x);

N=length(t);
y=zeros(1,N);


cost1=0;

for i=1:N
    
    if t(i)>20 && t(i)<50
        
        y(i)=14;
    elseif t(i)>100 && t(i)<110
        
        y(i)=20;
        
    else
        y(i)=5;
    end
    
    % out=sum(u.^2)*(10+t(end))^2*sum((x-y));
    
    
end

flag=0;

for i=1:N
    
    resid=sum(x(1:i))-sum(y(1:i));
    %     if sum(x(1:i))<y || x(i)-y(i)>50
%     if (flag==0) && (resid<0 || resid >50)
%         cost1=cost1+10;
% %         flag=1;
% %     else
% %         cost1=cost1-1000;
%     end


    if  (resid<0)
        cost1=cost1-resid;
    end
    
    if  (resid>50)
        cost1=cost1+(resid-50);
    end
    
    
end

%     out=u.^2+cost1;

% out=(1e3+u).*cost1;


out=(10+u).*cost1;

end