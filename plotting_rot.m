close all



N=length(T);
EUL=zeros(3,N);
for i=1:N
    quat=soln(end).grid.state(4:7,i);
    EUL(:,i)=quat2eul(quat')';
end
EUL=rad2deg(EUL);


figure
hold on
plot(T,U(:,:))
% plot(T,U(:,:),'k.')
ylabel('Thrusts')
xlabel('t (s)')
legend


figure
subplot(3,2,1)
hold on
plot(T(1),state_0(1),'bo')
plot(T(end),state_f(1),'bo')
plot(T,soln(end).grid.state(1,:))
plot(T,soln(end).grid.state(1,:),'r.')
ylabel('\omega_x')
subplot(3,2,3)
hold on
plot(T(1),state_0(2),'bo')
plot(T(end),state_f(2),'bo')
plot(T,soln(end).grid.state(2,:))
plot(T,soln(end).grid.state(2,:),'r.')
ylabel('\omega_y')
subplot(3,2,5)
hold on
plot(T(1),state_0(3),'bo')
plot(T(end),state_f(3),'bo')
plot(T,soln(end).grid.state(3,:))
plot(T,soln(end).grid.state(3,:),'r.')
ylabel('\omega_z')
xlabel('t (s)')

subplot(3,2,2)
plot(T,EUL(1,:),'b')
ylabel('\phi')
subplot(3,2,4)
plot(T,EUL(2,:),'b')
ylabel('\theta')
subplot(3,2,6)
plot(T,EUL(3,:),'b')
ylabel('\psi')
