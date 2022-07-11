
close all
addpath('plotlib')

idx1=1;
idx2=20;

% idx1=1;
% idx2=length(T_damp_arr);


X_1=k_rot_arr(idx1:idx2);

idx_base=find(cost_arr==min(cost_arr));

Y_1=T_damp_arr(idx1:idx2)./T_damp_arr(idx_base);
Y_2=sum_arr(idx1:idx2)./sum_arr(idx_base);
Y_3=var_arr(idx1:idx2)./var_arr(idx_base);
Y_5=cost_arr(idx1:idx2)./cost_arr(idx_base);
Y_4=err_arr(idx1:idx2)./err_arr(idx_base);


% X_1=X_1-k_rot_arr(idx_base)+1;
X_1=round(X_1./k_rot_arr(idx_base),2);

figure('DefaultAxesFontSize',16,'defaultAxesFontName','Euclid','defaultTextFontName','Euclid')

ha = tight_subplot(2,1,[0.017 0.035],[.12 .04],[.1 .05]);


ii=1;
axes(ha(ii))
% figure

% hold on

% yyaxis left
% plot(X_1,(Y_1-1)*100,'bo-')
% hold on
plot(X_1,(Y_2-1)*100,'ks-')

axes(ha(ii))
hold on
plot(X_1,(Y_3-1)*100,'r.-','MarkerSize',12)
% plot(X_1,(Y_4-1)*100,'gx-')
axes(ha(ii))
hold on
plot(X_1,(Y_5-1)*100,'bd','MarkerSize',12)
% hold off
% xlim([min(X_1) max(X_1)])
% xticks(X_1)
% xlabel('Multiplication factor of proportional gains of detumbling')
ylabel('% of Change')
legend('Total energy','Variance of fuel distrubition','Cost function value');
% ss.Color='k';
% ss.
% set(gca,'YColor','k')

grid minor


ii=2;
axes(ha(ii))
% hold on

% yyaxis right

plot(X_1,(Y_1-1)*100,'bo-')
axes(ha(ii))
hold on
plot(X_1,(Y_4-1)*100,'gx-')

% hold off

% set(ha(2),'XTickLabel',[0:0.1:10]);
% set(ha(1),'YTickLabel',[-5:1:5]);
set(ha(1),'XTickLabel','');

% set(gca,'YColor','b')
% yticks([-100:20:100])


% plot(X_2,(err_arr./err_arr(idx)-1)*100,'c.-')
% xlim([min(X_1) max(X_1)])
% xticks([min(X_1):0.1:max(X_1)])
grid minor
ylabel('% of Change')
xlabel('Multiplication factor of proportional gains of detumbling')
legend('Detumbling time (90% damped)','Number of ill conditions')
% set(gca,'YColor','b')

% legend('Total Energy','Variance of Energy distrubition','Time 90% damp of tumbling','% of ill consition incidence')
% legend('Detumbling time (90% damped)','Total energy','Variance of fuel distrubition','Number of ill conditions','Cost function value')
% legend('Total energy-left axis','Variance of fuel distrubition-left axis','Cost function value-left axis','Detumbling time (90% damped)-right axis','Number of ill conditions-right axis')
% grid minor
% axis tight

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


