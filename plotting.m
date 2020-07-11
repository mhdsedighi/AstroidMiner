figure
hold on
axis equal
grid minor
view(25,45)
plot3(0,0,0,'ro')
plot3(R(1,:),R(2,:),R(3,:),'b')
plot3(R(1,:),R(2,:),R(3,:),'k.')

figure
subplot(3,1,1)
hold on
plot(T,U(1,:),'g')
plot(T,U(1,:),'k.')
subplot(3,1,2)
hold on
plot(T,rad2deg(U(2,:)),'g')
plot(T,rad2deg(U(2,:)),'k.')
subplot(3,1,3)
hold on
plot(T,rad2deg(U(3,:)),'g')
plot(T,rad2deg(U(3,:)),'k.')

figure
subplot(3,2,1)
hold on
plot(T(1),mee_0(1),'bo')
plot(T(end),mee_f(1),'bo')
plot(T,soln.grid.state(1,:),'r.')
subplot(3,2,2)
hold on
plot(T(1),mee_0(2),'bo')
plot(T(end),mee_f(2),'bo')
plot(T,soln.grid.state(2,:),'r.')
subplot(3,2,3)
hold on
plot(T(1),mee_0(3),'bo')
plot(T(end),mee_f(3),'bo')
plot(T,soln.grid.state(3,:),'r.')
subplot(3,2,4)
hold on
plot(T(1),mee_0(4),'bo')
plot(T(end),mee_f(4),'bo')
plot(T,soln.grid.state(4,:),'r.')
subplot(3,2,5)
hold on
plot(T(1),mee_0(5),'bo')
plot(T(end),mee_f(5),'bo')
plot(T,soln.grid.state(5,:),'r.')
subplot(3,2,6)
hold on
plot(T(1),mee_0(6),'bo')
plot(T(end),mee_f(6),'bo')
plot(T,soln.grid.state(6,:),'r.')