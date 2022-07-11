
close all

% idx1=10;
% idx2=25;

idx1=1;
idx2=length(T_damp_arr);

Y_1=T_damp_arr(idx1:idx2)/(24*3600);
X_1=k_rot_arr(idx1:idx2);


Y_2=sum_arr(idx1:idx2)./sum_arr(idx_base);
Y_3=var_arr(idx1:idx2)./var_arr(idx_base);
Y_5=cost_arr(idx1:idx2)./cost_arr(idx_base);
Y_4=err_arr(idx1:idx2)./err_arr(idx_base);

idx_base=find(Y_5==min(Y_5));
X_1=X_1-X_1(idx_base)+1;

% figure('DefaultAxesFontSize',16,'defaultAxesFontName','Euclid','defaultTextFontName','Euclid')
figure

hold on

% yyaxis left
plot(X_1,(Y_1./Y_1(idx_base)-1)*100,'bo-')
plot(X_1,(Y_2-1)*100,'ks-')
plot(X_1,(Y_3-1)*100,'r.-','MarkerSize',12)
plot(X_1,(Y_4-1)*10,'gx-')
plot(X_1,(Y_5-1)*100,'kd')

xlim([min(X_1)-0.1 max(X_1)+0.1])
xticks(X_1)
xlabel('Multiplication factor of proportional gains of detumbling')
ylabel('% of Change')
% ss.Color='k';
% ss.
set(gca,'YColor','k')





% yyaxis right





% plot(X_2,(err_arr./err_arr(idx)-1)*100,'c.-')

ylabel('% of Change')
% set(gca,'YColor','b')

% legend('Total Energy','Variance of Energy distrubition','Time 90% damp of tumbling','% of ill consition incidence')
legend('detumbling time (90% damped)','Total energy','Variance of fuel distrubition','Number of ill conditions','Cost function value')
grid minor
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
