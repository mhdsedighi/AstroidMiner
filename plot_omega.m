close all
addpath(genpath(pwd))
addpath('plotlib')


figure
plot(T,out.omega.Data)
ylim([-1e-3 1e-4])
grid minor
zp=BaseZoom();
zp.plot;
% zp.plot;





% 
% 
% 
% spin_reduction=out.omega.Data/out.omega.Data(1)*100;
% idxs=find(spin_reduction<1);
% idxs=find(T>5);
% idx=idxs(1);
% 
% T_cut=5;
% 
% xtick_time_1=0:0.5:T_cut;
% xtick_time_1(end)=T_cut;
% xtick_time_2=floor(T_cut):10:T(end);
% xtick_time_2(1)=T_cut;
% xtick_time_2(end)=T(end);
% 
% close all
% figure
% 
% 
% ha = tight_subplot(3,2,[0.05 0.02],[.1 .1],[.03 .01]);
% 
% 
% % % % 
% 
% 
% ii=1;
% axes(ha(ii))
% plot(T(1:idx),pqr(1:idx,1))
% ylabel('p (rad/s)')
% xlim([0 T_cut])
% grid
% xticks(xtick_time_1)
% ii=2;
% axes(ha(ii))
% plot(T(idx:end),pqr(idx:end,1))
% % xlim([T(idx) T(end)])
% grid
% xticks(xtick_time_2)
% 
% 
% ii=3;
% axes(ha(ii))
% plot(T(1:idx),pqr(1:idx,2))
% ylabel('q (rad/s)')
% xlim([0 T_cut])
% grid
% xticks(xtick_time_1)
% ii=4;
% axes(ha(ii))
% plot(T(idx:end),pqr(idx:end,2))
% % xlim([T(idx) T(end)])
% grid
% xticks(xtick_time_2)
% 
% 
% ii=5;
% axes(ha(ii))
% plot(T(1:idx),pqr(1:idx,3))
% ylabel('q (rad/s)')
% xlim([0 T_cut])
% grid
% xticks(xtick_time_1)
% xlabel('time (days)')
% ii=6;
% axes(ha(ii))
% plot(T(idx:end),pqr(idx:end,3))
% % xlim([T(idx) T(end)])
% grid
% % xlabel('time (days)-continued')
% xticks(xtick_time_2)
% 
% 
% 
% 
% set(ha(1:4),'XTickLabel','');
% 
