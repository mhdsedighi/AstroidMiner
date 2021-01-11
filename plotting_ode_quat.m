N=length(quats);
% pqr=sol3.y(1:3,:);
% EUL=zeros(3,N);
% % 
% for i=1:N
%     quat=quats(:,i);
%     EUL(:,i)=quat2eul(quat')';
% end
% 
% EUL=rad2deg(EUL);
% 
% Force_history_xyz=zeros(3,N);
% Force_mag=zeros(1,N);
% for i=1:N
%     Force_history_xyz(:,i)=rsw2xyz(Force_history(:,i),R(:,i),V(:,i));
% %     Force_mag(i)=norm(Force_history_xyz(:,i));
% end

% EUL=rad2deg(EUL);

close all

% figure
% hold on
% axis equal
% grid minor
% view(25,45)
% ploT_quats(0,0,0,'ro')
% plot_earth
% ploT_quats(R(1,:),R(2,:),R(3,:),'b')
% ploT_quats(R(1,:),R(2,:),R(3,:),'r.')


% quiver3(R(1,:),R(2,:),R(3,:),Force_history_xyz(1,:),Force_history_xyz(2,:),Force_history_xyz(3,:),1.3,'k')



% figure
% hold on
% plot(T,U(:,:))
% % plot(T,U(:,:),'k.')
% ylabel('Thrusts')
% xlabel('t (s)')
% legend


figure
subplot(3,1,1)
hold on
plot(T_rot_history,pqr_rot_history(:,1))
% plot(T_rot_history,pqr_rot_history(:,1),'r.')
plot(T_b,pqrs_b(1,:))
% plot(T_b,pqrs_b(1,:))
ylabel('\omega_x')
subplot(3,1,2)
hold on
plot(T_rot_history,pqr_rot_history(:,2))
% plot(T_rot_history,pqr_rot_history(:,2),'r.')
plot(T_b,pqrs_b(2,:))
% plot(T_b,pqrs_b(2,:),'r.')
ylabel('\omega_y')
subplot(3,1,3)
hold on
plot(T_rot_history,pqr_rot_history(:,3))
% plot(T_rot_history,pqr_rot_history(:,3),'r.')
plot(T_b,pqrs_b(3,:))
% plot(T_b,pqrs_b(3,:),'r.')
ylabel('\omega_z')
xlabel('t (s)')




figure
subplot(3,1,1)
hold on
plot(T_rot_history,pqr_rot_history(:,1))
ylabel('\omega_x')
subplot(3,1,2)
hold on
plot(T_rot_history,pqr_rot_history(:,2))
ylabel('\omega_y')
subplot(3,1,3)
hold on
plot(T_rot_history,pqr_rot_history(:,3))
ylabel('\omega_z')
xlabel('t (s)')


figure
subplot(3,1,1)
hold on
% plot(T_rot_history,pqr_rot_history(:,1))
% plot(T_rot_history,pqr_rot_history(:,1),'r.')
plot(T_b,pqrs_b(1,:))
% plot(T_b,pqrs_b(1,:))
ylabel('\omega_x')
subplot(3,1,2)
hold on
% plot(T_rot_history,pqr_rot_history(:,2))
% plot(T_rot_history,pqr_rot_history(:,2),'r.')
plot(T_b,pqrs_b(2,:))
% plot(T_b,pqrs_b(2,:),'r.')
ylabel('\omega_y')
subplot(3,1,3)
hold on
% plot(T_rot_history,pqr_rot_history(:,3))
% plot(T_rot_history,pqr_rot_history(:,3),'r.')
plot(T_b,pqrs_b(3,:))
% plot(T_b,pqrs_b(3,:),'r.')
ylabel('\omega_z')
xlabel('t (s)')
% % % 
% % abs_omega=sqrt(soln(end).grid.state(1,:).^2+soln(end).grid.state(2,:).^2+soln(end).grid.state(3,:).^2);

% subplot(3,2,2)
% hold on
% plot(T,abs_omega)
% plot(T,abs_omega,'k.')
% ylabel('\omega')
% xlabel('t (s)')


EUL=quat2eul(quats');

figure
subplot(3,1,1)
plot(T_quats,EUL(:,1),'b')
ylabel('\phi')
subplot(3,1,2)
plot(T_quats,EUL(:,2),'b')
ylabel('\theta')
subplot(3,1,3)
plot(T_quats,EUL(:,3),'b')
ylabel('\psi')


% 
% figure
% subplot(3,2,1)
% hold on
% plot(T(1),mee_0(1),'bo')
% plot(T(end),mee_f(1),'bo')
% plot(T,soln(end).grid.state(8,:),'r.')
% ylabel('mee1')
% subplot(3,2,2)
% hold on
% plot(T(1),mee_0(2),'bo')
% plot(T(end),mee_f(2),'bo')
% plot(T,soln(end).grid.state(9,:),'r.')
% ylabel('mee2')
% subplot(3,2,3)
% hold on
% plot(T(1),mee_0(3),'bo')
% plot(T(end),mee_f(3),'bo')
% plot(T,soln(end).grid.state(10,:),'r.')
% ylabel('mee3')
% subplot(3,2,4)
% hold on
% plot(T(1),mee_0(4),'bo')
% plot(T(end),mee_f(4),'bo')
% plot(T,soln(end).grid.state(11,:),'r.')
% ylabel('mee4')
% subplot(3,2,5)
% hold on
% plot(T(1),mee_0(5),'bo')
% plot(T(end),mee_f(5),'bo')
% plot(T,soln(end).grid.state(12,:),'r.')
% ylabel('mee5')
% subplot(3,2,6)
% hold on
% plot(T(1),mee_0(6),'bo')
% plot(T,soln(end).grid.state(13,:),'r.')
% ylabel('mee6')
% 
% 
% 
% figure
% subplot(3,2,1)
% hold on
% plot(T(1),oe_0(1),'bo')
% plot(T(end),oe_f(1),'bo')
% plot(T,OE(1,:),'r.')
% ylabel('a')
% subplot(3,2,2)
% hold on
% plot(T(1),oe_0(2),'bo')
% plot(T(end),oe_f(2),'bo')
% plot(T,OE(2,:),'r.')
% ylabel('e')
% subplot(3,2,3)
% hold on
% plot(T(1),oe_0(3),'bo')
% plot(T(end),oe_f(3),'bo')
% plot(T,rad2deg(OE(3,:)),'r.')
% ylabel('i')
% subplot(3,2,4)
% hold on
% plot(T(1),oe_0(4),'bo')
% plot(T(end),oe_f(4),'bo')
% plot(T,rad2deg(OE(4,:)),'r.')
% ylabel('\omega')
% subplot(3,2,5)
% hold on
% plot(T(1),oe_0(5),'bo')
% plot(T(end),oe_f(5),'bo')
% plot(T,rad2deg(OE(5,:)),'r.')
% ylabel('\Omega')
% subplot(3,2,6)
% hold on
% plot(T(1),oe_0(6),'bo')
% plot(T,rad2deg(OE(6,:)),'r.')
% ylabel('\theta')
