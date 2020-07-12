close all


figure
subplot(3,1,1)
hold on
plot(T,U(1,:),'g')
plot(T,U(1,:),'k.')
subplot(3,1,2)
hold on
plot(T,U(2,:),'g')
plot(T,U(2,:),'k.')
subplot(3,1,3)
hold on
plot(T,U(3,:),'g')
plot(T,U(3,:),'k.')

figure
subplot(3,2,1)
hold on
plot(T(1),pqr_0(1),'bo')
plot(T(end),pqr_f(1),'bo')
plot(T,soln.grid.state(1,:),'r.')
subplot(3,2,3)
hold on
plot(T(1),pqr_0(2),'bo')
plot(T(end),pqr_f(2),'bo')
plot(T,soln.grid.state(2,:),'r.')
subplot(3,2,5)
hold on
plot(T(1),pqr_0(3),'bo')
plot(T(end),pqr_f(3),'bo')
plot(T,soln.grid.state(3,:),'r.')



% subplot(3,2,2)
% hold on
% plot(T(1),pqr_0(4),'bo')
% plot(T(end),pqr_f(4),'bo')
% plot(T,soln.grid.state(4,:),'r.')
% subplot(3,2,4)
% hold on
% plot(T(1),pqr_0(5),'bo')
% plot(T(end),pqr_f(5),'bo')
% plot(T,soln.grid.state(5,:),'r.')
% subplot(3,2,6)
% hold on
% plot(T(1),pqr_0(6),'bo')
% plot(T(end),pqr_f(6),'bo')
% plot(T,soln.grid.state(6,:),'r.')