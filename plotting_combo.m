N=length(T);
R=zeros(3,N);
V=zeros(3,N);

for i=1:N
    [r,v]=mee2rv(soln(end).grid.state(8:13,i)',p.mu);
    R(:,i)=r;
    V(:,i)=v;
end
% 
% Force_history_xyz=zeros(3,N);
% Force_mag=zeros(1,N);
% for i=1:N
%     Force_history_xyz(:,i)=rsw2xyz(Force_history(:,i),R(:,i),V(:,i));
% %     Force_mag(i)=norm(Force_history_xyz(:,i));
% end

close all

figure
hold on
axis equal
grid minor
view(25,45)
plot3(0,0,0,'ro')
plot_earth
plot3(R(1,:),R(2,:),R(3,:),'b')
plot3(R(1,:),R(2,:),R(3,:),'r.')


% quiver3(R(1,:),R(2,:),R(3,:),Force_history_xyz(1,:),Force_history_xyz(2,:),Force_history_xyz(3,:),1.3,'k')



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
plot(T(1),state_0(1),'bo')
plot(T(end),state_f(1),'bo')
plot(T,soln(end).grid.state(1,:))
plot(T,soln(end).grid.state(1,:),'r.')
ylabel('\omega_x')
subplot(3,1,2)
hold on
plot(T(1),state_0(2),'bo')
plot(T(end),state_f(2),'bo')
plot(T,soln(end).grid.state(2,:))
plot(T,soln(end).grid.state(2,:),'r.')
ylabel('\omega_y')
subplot(3,1,3)
hold on
plot(T(1),state_0(3),'bo')
plot(T(end),state_f(3),'bo')
plot(T,soln(end).grid.state(3,:))
plot(T,soln(end).grid.state(3,:),'r.')
ylabel('\omega_z')
xlabel('t (s)')




figure
subplot(3,2,1)
hold on
plot(T(1),mee_0(1),'bo')
plot(T(end),mee_f(1),'bo')
plot(T,soln(end).grid.state(8,:),'r.')
subplot(3,2,2)
hold on
plot(T(1),mee_0(2),'bo')
plot(T(end),mee_f(2),'bo')
plot(T,soln(end).grid.state(9,:),'r.')
subplot(3,2,3)
hold on
plot(T(1),mee_0(3),'bo')
plot(T(end),mee_f(3),'bo')
plot(T,soln(end).grid.state(10,:),'r.')
subplot(3,2,4)
hold on
plot(T(1),mee_0(4),'bo')
plot(T(end),mee_f(4),'bo')
plot(T,soln(end).grid.state(11,:),'r.')
subplot(3,2,5)
hold on
plot(T(1),mee_0(5),'bo')
plot(T(end),mee_f(5),'bo')
plot(T,soln(end).grid.state(12,:),'r.')
subplot(3,2,6)
hold on
plot(T(1),mee_0(6),'bo')
plot(T(end),mee_f(6),'bo')
plot(T,soln(end).grid.state(13,:),'r.')
