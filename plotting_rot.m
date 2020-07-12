close all


figure
hold on
plot(T,U(:,:))
% plot(T,U(:,:),'k.')
ylabel('Thrusts')
xlabel('t (s)')
legend


figure
subplot(3,1,1)
hold on
plot(T(1),pqr_0(1),'bo')
plot(T(end),pqr_f(1),'bo')
plot(T,soln.grid.state(1,:))
plot(T,soln.grid.state(1,:),'r.')
ylabel('\omega_x')
subplot(3,1,2)
hold on
plot(T(1),pqr_0(2),'bo')
plot(T(end),pqr_f(2),'bo')
plot(T,soln.grid.state(2,:))
plot(T,soln.grid.state(2,:),'r.')
ylabel('\omega_y')
subplot(3,1,3)
hold on
plot(T(1),pqr_0(3),'bo')
plot(T(end),pqr_f(3),'bo')
plot(T,soln.grid.state(3,:))
plot(T,soln.grid.state(3,:),'r.')
ylabel('\omega_z')
xlabel('t (s)')
