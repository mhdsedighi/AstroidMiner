% close all

T=out.r.Time./(24*3600);

xtick_time=0:10:T(end);
xtick_time(end+1)=T(end);
yticks_360=0:45:360;
yticks_180=-180:45:180;

r2d=180/pi;

N=length(T);

eul=out.eul.Data;
pqr=out.pqr.Data;
oe=out.oe.Data;



figure

subplot(3,1,1)
plot(T,eul(:,1))
xlabel('time (days)')
ylabel('\phi (deg)')
xticks(xtick_time)
xlim([0 T(end)])
ylim([-180 180])
yticks(yticks_180)
grid

subplot(3,1,2)
plot(T,eul(:,2))
xlabel('time (days)')
ylabel('\theta (deg)')
xlim([0 T(end)])
xticks(xtick_time)
ylim([-180 180])
yticks(yticks_180)
grid

subplot(3,1,3)
plot(T,eul(:,3))
xlabel('time (days)')
ylabel('\psi (deg)')
xlim([0 T(end)])
xticks(xtick_time)
ylim([-180 180])
yticks(yticks_180)
grid




figure

subplot(3,1,1)
plot(T,pqr(:,1))
xlabel('time (days)')
ylabel('p (rad/s)')
xlim([0 T(end)])
xticks(xtick_time)
grid

subplot(3,1,2)
plot(T,pqr(:,2))
xlabel('time (days)')
ylabel('q (rad/s)')
xlim([0 T(end)])
xticks(xtick_time)
grid

subplot(3,1,3)
plot(T,pqr(:,3))
xlabel('time (days)')
ylabel('r (rad/s)')
xlim([0 T(end)])
xticks(xtick_time)
grid






figure

subplot(3,2,1)
plot(T,oe(:,1)/133)
xlabel('time (days)')
ylabel('a (km)')
xlim([0 T(end)])
xticks(xtick_time)
grid

subplot(3,2,2)
plot(T,oe(:,2))
xlabel('time (days)')
ylabel('e')
xlim([0 T(end)])
xticks(xtick_time)
grid

subplot(3,2,3)
plot(T,oe(:,3)*r2d)
xlabel('time (days)')
ylabel('i (deg)')
xlim([0 T(end)])
xticks(xtick_time)
grid

subplot(3,2,4)
plot(T,oe(:,4)*r2d)
xlabel('time (days)')
ylabel('\omega (deg)')
xlim([0 T(end)])
xticks(xtick_time)
% ylim([0 360])
% yticks(yticks_360)
grid

subplot(3,2,5)
plot(T,oe(:,5)*r2d)
xlabel('time (days)')
ylabel('\Omega (deg)')
xlim([0 T(end)])
xticks(xtick_time)
% ylim([0 360])
% yticks(yticks_360)
grid

subplot(3,2,6)
plot(T,oe(:,6)*r2d)
xlabel('time (days)')
ylabel('\nu (deg)')
xlim([0 T(end)])
xticks(xtick_time)
ylim([0 360])
yticks(yticks_360)
grid


