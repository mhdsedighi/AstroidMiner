function [cost]=lambert_cost(x,orbit1,orbit2,mu)


theta1=x(1);
theta2=x(2);
tf_days=x(3);
m=x(4);


if theta1==theta2  %%% handling lambert_pro singularity
    theta2=theta2+0.0001;
end

[R1, V01] = rv_from_oe(orbit1.a,orbit1.e,orbit1.RA,orbit1.incl,orbit1.omega,theta1,mu);

[R2, V02] = rv_from_oe(orbit2.a,orbit2.e,orbit2.RA,orbit2.incl,orbit2.omega,theta2,mu);




[V1,V2, ~,exitflag] = lambert_pro(R1',R2',tf_days,m,mu);


if exitflag~=1
    
    cost=100;
    
else
    
    deltaV1=V1'-V01;
    deltaV2=V02-V2';
    
    deltaV1_=norm(deltaV1);
    deltaV2_=norm(deltaV2);
    
    cost=deltaV1_+deltaV2_;
end


end