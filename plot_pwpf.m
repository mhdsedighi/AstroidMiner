%%% run this after model_5_exact then out1=out then pwpwf_real_signal.slx
close all

addpath('plotlib')

% load('run_e__8.mat');
% load('pwpf_d_tune.mat');
% [sat_pos,Force_Vectors,Moment_Vectors,min_dis]=rigid_positioning_dis(sim_data.params,N_sat,lambdas,phis,alphas,betas);
% Force_Vectors=Force_Vectors';
% Moment_Vectors=Moment_Vectors';

%for t
% load run_T
% t_sim=T_end*365*24*3600;


% t_sim=3.042410919992809e+07

%for e
% t_sim=T_end*365*24*3600;


% load('run_model5_e.mat');
% out1=out;

% out1=sim('model_5');



outd=out;

T_analog=out1.U.Time';
T_digital=outd.Udigital.Time';
u_analog=out1.U.Data';
u_digital=outd.Udigital.Data';


num=2
nums=[1 2 3 4 5 10 12 15 20 25]
% nums=1:25;



% t1=0;
% t2=500;

t1=T_digital(end)-500;
t2=T_digital(end);

% 
% idx_wait=find(sum(u_analog,1)>0);
% idx_wait=idx_wait(1)-1;
% T_analog=T_analog(idx_wait:end)-T_analog(idx_wait);
% u_analog=u_analog(:,idx_wait:end);

% idx_wait=find(sum(u_digital,1)>0);
% idx_wait=idx_wait(1)-1;
% T_digital=T_digital(idx_wait:end)-T_digital(idx_wait);
% u_digital=u_digital(:,idx_wait:end);


% figure
% plot(T_analog./3600,u_analog)
% xlabel('time (hours)')
% ylabel('Hypothetical continuousThrust Power (N)')
% xlim([t1,T_analog(end)./3600])
% grid



% idxs1=find(T_analog>t1 & T_analog<t2);
% idxs1=[idxs1 idxs1(end)+1];
idxs2=find(T_digital>t1 & T_digital<t2);


N2=length(nums)
for j=1:N2
N=length(idxs2);
for i=1:N-1

    id=idxs2(i);

    if (u_digital(nums(j),id)<1e-3 && u_digital(nums(j),id+1)>1 )

        T_digital(id+1)=T_digital(id)+0.0001;
        %         u_digital(num,id)=u_digital(num,id+1);
        %         u_digital(num,id+1)=0;

    end

    if (u_digital(nums(j),id)>1 && u_digital(nums(j),id+1)<1e-3 )

        T_digital(id+1)=T_digital(id)+0.0001;

    end




end
end



N=length(nums);

xtick_time=[t1:100:t2];

plt=figure('DefaultAxesFontSize',14,'defaultAxesFontName','Euclid','defaultTextFontName','Euclid')
ha = tight_subplot(N,1,[0.017 0.035],[0.12 .04],[.1 .05]);

for i=1:N
%     subplot(N,1,i);





% ii=1;
axes(ha(i))

% hold on
% xlabel('time (s)')
% ylabel('Thrust Power (N)')

plt1=plot(T_digital(idxs2),u_digital(nums(i),idxs2),'b');

%  yyaxis right
% plt2=plot(T_analog(idxs1),u_analog(num,idxs1),'k');

% legend('On-Off command (N) [left axis]','Hypothetical continuous command (N) [right axis]')


plt1.LineWidth=0.2;
% plt2.LineWidth=1.4;

xlim([t1,t2])
ylim([0 12.5])
% grid
ylabel("{\it i=}"+num2str(nums(i)))
xtick_time=[t1:20:t2];
xticks(xtick_time)
yticks([0 12]);
box off

end
xlabel('Time (s)')
% xticks(xtick_time-T_digital(end))
set(ha(1:N-1),'XTickLabel','');
set(ha(1:N),'YTickLabel','');

% xlabel(t)



% figure
% hold on
% xlabel('time (s)')
% ylabel('Thrust Power (N)')
% 
% plt1=plot(T_digital(idxs2),u_digital(num,idxs2),'b');
% %  yyaxis right
% % plt2=plot(T_analog(idxs1),u_analog(num,idxs1),'k');
% 
% % legend('On-Off command (N) [left axis]','Hypothetical continuous command (N) [right axis]')
% 
% 
% plt1.LineWidth=0.01
% plt2.LineWidth=1.4
% 
% xlim([t1,t2])
% grid


