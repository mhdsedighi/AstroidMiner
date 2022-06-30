close all




T_analog=out1.U.Time';
T_digital=out.Udigital.Time';
u_analog=out1.U.Data';
u_digital=out.Udigital.Data';


num=25
t1=0;
t2=1000;


idx_wait=find(sum(u_analog,1)>0);
idx_wait=idx_wait(1)-1;
T_analog=T_analog(idx_wait:end)-T_analog(idx_wait);
u_analog=u_analog(:,idx_wait:end);
idx_wait=find(sum(u_digital,1)>0);
idx_wait=idx_wait(1)-1;
T_digital=T_digital(idx_wait:end)-T_digital(idx_wait);
u_digital=u_digital(:,idx_wait:end);


figure
plot(T_analog./3600./24,u_analog)
xlabel('time (days)')
ylabel('Hypothetical continuousThrust Power (N)')
xlim([t1,T_analog(end)/3600/24])



idxs1=find(T_analog>t1 & T_analog<t2);
idxs1=[idxs1 idxs1(end)+1];
idxs2=find(T_digital>t1 & T_digital<t2);


N=length(idxs2);
for i=1:N-1

    id=idxs2(i);

    if (u_digital(num,id)<1e-3 && u_digital(num,id+1)>1 )

        T_digital(id+1)=T_digital(id)+0.0001;
        %         u_digital(num,id)=u_digital(num,id+1);
        %         u_digital(num,id+1)=0;

    end

    if (u_digital(num,id)>1 && u_digital(num,id+1)<1e-3 )

        T_digital(id+1)=T_digital(id)+0.0001;

    end




end
figure
hold on
xlabel('time (s)')
xlabel('Thrust Power (N)')

plt1=plot(T_digital(idxs2),u_digital(num,idxs2),'b');
plt2=plot(T_analog(idxs1),u_analog(num,idxs1),'k');

legend('On-Off command','Hypothetical continuous command')


plt1.LineWidth=0.01
plt2.LineWidth=1.4

xlim([t1,t2])


