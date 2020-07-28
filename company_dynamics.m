function dx = company_dynamics(t,x,u,params)


% u=floor(u);

lag1=0.142;
lag2=0.12;


N_times=length(t);
x_new=zeros(1,N_times);

for i=1:N_times
    
    if u(i)<=10
        lag=lag1;
    else
        lag=lag2;
    end
    
    if t(i)<lag
%         interp1(t,x,t(i)-lag)
        
        x_new(i)=0;
        
        
    else
        x_new(i)=interp1(t,u,t(i)-lag);
        
        
    end
    
    
end

dt=diff(t);

delta_x=diff(x_new);

dx=[delta_x./dt 0];

% dx=(x_new-x)./dt;
% 
% dx(end)=0;

% dx=(x_new-x);



end