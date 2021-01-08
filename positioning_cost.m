function cost=positioning_cost(x,N_sat,N_time,T_quats,quats,fms,params)


azimuths=x(1:N_sat);
elevations=x(N_sat+1:2*N_sat);
gammas=x(2*N_sat+1:3*N_sat);
lambdas=x(3*N_sat+1:4*N_sat);


% params=rigid_positioning(N_sat,params.a,params.b,params.c,azimuths,elevations,gammas,lambdas);
% % control_mat=param1.Moment_Vectors';
% params=control_mat(params,quat);




exitflagS=zeros(1,N_time);
sum_u=zeros(1,N_time);

for i=1:N_time
    quat=quats(:,i)';
    fm=fms(:,i);
    
    [Force_Vectors,Moment_Vectors]=rigid_positioning(params,N_sat,azimuths,elevations,gammas,lambdas);
    c_mat=control_mat(Force_Vectors,Moment_Vectors,quat,N_sat);
    
    [u_star,~,~,exitflag,~] = lsqnonneg(c_mat,fm);
    
    exitflagS(i)=exitflag;
    sum_u(i)=sum(u_star);
end

cost=trapz(T_quats,sum_u);

sum_flags=sum(exitflagS);
if sum_flags<N_time
    cost=cost*(N_time-sum_flags);
end






end