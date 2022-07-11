close all
XYZ=out.r.Data;



figure
hold on
axis equal

set(gca, 'XTick', [], 'YTick', [], 'ZTick', [])
set(gca, 'xcolor', 'w', 'ycolor', 'w','zcolor', 'w') ;


plt1=plot3(XYZ(:,1),XYZ(:,2),XYZ(:,3),'k');
plot3(XYZ(1,1),XYZ(1,2),XYZ(1,3),'b*')
plot3(XYZ(end,1),XYZ(end,2),XYZ(end,3),'ro')

plt1.LineWidth=1.3

% Time=out.r.Time;
% T_end=Time(end);

% F_his=out.F_req_B.Data';
% N=length(F_his);

% idxs=[];
% count=0;
% for i=0:0.1:1
%     this_t=i*T_end;
%     arr=find(Time>=this_t);
%     count=count+1;
%     idxs(count)=arr(1);
% end

% quiver3(XYZ(idxs,1),XYZ(idxs,2),XYZ(idxs,3),F_his(1,idxs)',F_his(2,idxs)',F_his(3,idxs)',13,'k')



% grid minor
view(25,45)
plot3(0,0,0,'ro')
size=1e7;
plot_planet(size)
plot_orbit(oe_0,'b:');
plot_orbit(oe_f,'r:');







l_axis=50000000;
plot_line([0 0 0],[1 0 0],l_axis,'k-',2,'$X_I$',15)
plot_line([0 0 0],[0 1 0],l_axis,'k-',2,'$Y_I$',15)
% plot_line([0 0 0],[0 0 1],l_axis,'k-',2,'$Z_I$',15)

lgd=legend([{'Redirection path'}    {'Start point'}    {'End point'}]);



function plot_line(p,dir,d,style,thickness,name,font_size)

p2=p+d*dir;
XYZ=[p;p2];
plt=plot3(XYZ(:,1),XYZ(:,2),XYZ(:,3),style);
plt.LineWidth=thickness;

p2=p+1.1*d*dir;
text(p2(1),p2(2),p2(3),name,'FontSize',font_size, 'Interpreter','latex')

end