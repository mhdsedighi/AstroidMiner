
params.final_test=1;
params.max_f=max_f;
params.mee_0=mee_0;
params.strategy=strategy;

maxIter=20;
params.options = optimoptions('lsqnonlin','Algorithm','levenberg-marquardt','MaxIterations',maxIter,'Display','none');
params.LB=zeros(N_sat,1);
params.UB=params.max_f*ones(N_sat,1);


k_rot_arr=[0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1 1.05 1.1 1.15 1.2 1.25 1.3 1.35 1.4 1.45 1.5];
% k_rot_arr=[0.7 0.75 0.8 0.85 0.9 0.95 1 1.05 1.1 1.15 1.2];
sum_arr=[];
var_arr=[];
T_damp_arr=[];


for i=1:length(k_rot_arr)
    i
    k_rot=k_rot_arr(i);

    x_test=x_opt;
    x_test(4*N_sat+6:4*N_sat+8)=x_test(4*N_sat+6:4*N_sat+8)*k_rot;
    %
    cost_opt=sim_cost(x_test,N_sat,params);
    sum_arr=[sum_arr sum_int_Fs];
    var_arr=[var_arr std_int_Fs];
mark_err

    T=out.omega.Time;
    spin_reduction=out.omega.Data/out.omega.Data(1)*100;
    idxs=find(spin_reduction<10);
    T_damp_arr=[T_damp_arr T(idxs(1))];

end




idx=find(k_rot_arr==1);
X_1=T_damp_arr/(24*3600);
X_2=k_rot_arr;
Y_1=sum_arr./sum_arr(idx);
Y_2=var_arr./var_arr(idx);


close all

figure
hold on

yyaxis left
plot(X_2,Y_1,'ks')
plot(X_2,Y_2,'r.')
xlim([min(X_2)-0.1 max(X_2)+0.1])
xticks(X_2)
xlabel('Factor of Spin Dampling Gain Multiplication')
ylabel('Factor of Change')
% ss.Color='k';
% ss.
set(gca,'YColor','k')

yyaxis right
plot(X_2,X_1./X_1(idx),'bo')
ylabel('Factor of Change')
set(gca,'YColor','b')

legend('Total Energy (left)','Variance of Energy distrubition (left)','Time 90% damp of tumbling (Right)')
grid minor

% figure
% hold on
% plot(X_1,Y_1,'ks')
% plot(X_1,Y_2,'r.')
% xlabel('t_{damp90%} (days)')
% legend('Total Energy','Variance of Energy distrubition')
% grid



% close all
% figure;
% b=axes('Position',[.1 .1 .8 1e-12]);
% set(b,'Units','normalized');
% set(b,'Color','none');
% 
% % axis for km/h with stem-plot
% a=axes('Position',[.1 .2 .8 .7]);
% set(a,'Units','normalized');
% plot(a,X_1, Y_1,'ks');
% hold on
% plot(a,X_1, Y_2,'r.');
% 
% % set limits and labels
% set(a,'xlim',[0 max(X_1)]);
% set(b,'xlim',[0 max(X_2)]);
% set(b,'XTick',[0:0.1:max(X_2)])
% xlabel(a,'t_{damp90%} (days)')
% xlabel(b,'rotation gain multiplication')
% ylabel(a,'ratio');
% legend('total Energy','Variance thrusters')
% grid


% n_poly=1;
% 
% [curve,gof]=poly_fit(X_2,Y_2,n_poly);
% plot(curve)
% 
% [curve,gof]=poly_fit(T_damp_arr,var_arr./var_arr(4),n_poly);
% plot(curve)



