function cost=positioning_cost(x,N_sat,N_time,T,T2,quatS,fmS,params)


azimuths=x(1:N_sat);
elevations=x(N_sat+1:2*N_sat);
gammas=x(2*N_sat+1:3*N_sat);
lambdas=x(3*N_sat+1:4*N_sat);


param1=rigid_positioning(N_sat,params.a,params.b,params.c,azimuths,elevations,gammas,lambdas);
control_mat=param1.Moment_Vectors';




exitflagS=zeros(1,N_time);
sum_u=zeros(1,N_time);

for i=1:N_time
%     quat=quatS(i,:);
    fm=interp1(T,fmS,T2(i))';
    
    [u_star,~,~,exitflag,~] = lsqnonneg(control_mat,fm);
    
    exitflagS(i)=exitflag;
    sum_u(i)=sum(u_star);
end

cost=trapz(T2,sum_u);

sum_flags=sum(exitflagS);
if sum_flags<N_time
    cost=cost*(N_time-sum_flags);
end






end