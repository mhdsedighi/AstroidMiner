% close all
addpath('plotlib')

T=out.r.Time./(24*3600);

xtick_time=0:50:T(end);
% xtick_time(end+1)=T(end);
yticks_360=0:90:360;
yticks_180=-180:45:180;

r2d=180/pi;

N=length(T);

eul=out.eul.Data;
pqr=out.pqr.Data;
oe=out.oe.Data;


figure('DefaultAxesFontSize',16,'defaultAxesFontName','Euclid','defaultTextFontName','Euclid')
ttt = tiledlayout(3,2,'TileSpacing','compact');
bgAx = axes(ttt,'XTick',[],'YTick',[],'Box','off');
bgAx.Layout.TileSpan = [3 2];


end_point=T(end);
split_point=25;
y=eul';

ax1 = axes(ttt);
hold on
plot(ax1,T,y(1,:))
ax1.Layout.Tile = 1;
ax1.Box = 'off';
xlim(ax1,[0 end_point])
grid minor
ylabel('\phi (deg)')


ax2 = axes(ttt);
ax2.Layout.Tile = 2;
plot(ax2,T,y(1,:))
ax2.Box = 'off';
xlim(ax2,[0 split_point])
grid minor



ax1 = axes(ttt);
ax1.Layout.Tile = 3;
plot(ax1,T,y(2,:))
ax1.Box = 'off';
xlim(ax1,[0 end_point])
grid minor
ylabel('\theta (deg)')


ax2 = axes(ttt);
ax2.Layout.Tile = 4;
plot(ax2,T,y(2,:))
ax2.Box = 'off';
xlim(ax2,[0 split_point])
grid minor


ax1 = axes(ttt);
ax1.Layout.Tile =5;
plot(ax1,T,y(3,:))
ax1.Box = 'off';
xlim(ax1,[0 end_point])
grid minor
ylabel('\psi (deg)')
xlabel('Time (days)')


ax2 = axes(ttt);
ax2.Layout.Tile = 6;
plot(ax2,T,y(3,:))
ax2.Box = 'off';
xlim(ax2,[0 split_point])
grid minor
xlabel('Time (days) -zoomed')

figure('DefaultAxesFontSize',16,'defaultAxesFontName','Euclid','defaultTextFontName','Euclid')

ttt = tiledlayout(3,2,'TileSpacing','compact');
bgAx = axes(ttt,'XTick',[],'YTick',[],'Box','off');
bgAx.Layout.TileSpan = [3 2];


end_point=T(end);
split_point=40;
y=pqr';

ax1 = axes(ttt);
hold on
plot(ax1,T,y(1,:))
ax1.Layout.Tile = 1;
ax1.Box = 'off';
xlim(ax1,[0 end_point])
grid minor
ylabel('p (rad/s)')


ax2 = axes(ttt);
ax2.Layout.Tile = 2;
plot(ax2,T,y(1,:))
ax2.Box = 'off';
xlim(ax2,[0 split_point])
grid minor



ax1 = axes(ttt);
ax1.Layout.Tile = 3;
plot(ax1,T,y(2,:))
ax1.Box = 'off';
xlim(ax1,[0 end_point])
grid minor
ylabel('q (rad/s)')


ax2 = axes(ttt);
ax2.Layout.Tile = 4;
plot(ax2,T,y(2,:))
ax2.Box = 'off';
xlim(ax2,[0 split_point])
grid minor


ax1 = axes(ttt);
ax1.Layout.Tile =5;
plot(ax1,T,y(3,:))
ax1.Box = 'off';
xlim(ax1,[0 end_point])
grid minor
ylabel('r (rad/s)')
xlabel('Time (days)')


ax2 = axes(ttt);
ax2.Layout.Tile = 6;
plot(ax2,T,y(3,:))
ax2.Box = 'off';
xlim(ax2,[0 split_point])
grid minor
xlabel('Time (days) -zoomed')
figure('DefaultAxesFontSize',14,'defaultAxesFontName','Euclid','defaultTextFontName','Euclid')
% figure


ha = tight_subplot(6,1,[0.017 0.035],[.12 .04],[.1 .05]);


ii=1;
axes(ha(ii))


% subplot(3,2,1)
ii=1;
axes(ha(ii))
plot(T,oe(:,1)/133)
% xlabel('time (days)')
ylabel('a (km)')
xlim([0 T(end)])
xticks(xtick_time)
grid minor

% subplot(3,2,2)
ii=2;
axes(ha(ii))
plot(T,oe(:,2))
% xlabel('time (days)')
ylabel('e')
xlim([0 T(end)])
xticks(xtick_time)
grid minor

% subplot(3,2,3)
ii=3;
axes(ha(ii))
plot(T,oe(:,3)*r2d)
% xlabel('time (days)')
ylabel('i (deg)')
xlim([0 T(end)])
xticks(xtick_time)
grid minor

% subplot(3,2,4)
ii=4;
axes(ha(ii))
plot(T,oe(:,4)*r2d)
% xlabel('time (days)')
ylabel('\omega (deg)')
xlim([0 T(end)])
xticks(xtick_time)
% ylim([0 360])
% yticks(yticks_360)
grid minor

% subplot(3,2,5)
ii=5;
axes(ha(ii))
plot(T,oe(:,5)*r2d)
xlabel('time (days)')
ylabel('\Omega (deg)')
xlim([0 T(end)])
xticks(xtick_time)
% ylim([0 360])
% yticks(yticks_360)
grid minor

% subplot(3,2,6)
ii=6;
axes(ha(ii))
plot(T,oe(:,6)*r2d)
xlabel('time (days)')
ylabel('\nu (deg)')
xlim([0 T(end)])
xticks(xtick_time)
ylim([0 360])
yticks(yticks_360)
grid minor

set(ha(1:5),'XTickLabel','');



