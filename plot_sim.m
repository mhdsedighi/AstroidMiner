
XYZ=out.r.Data;



close all

figure
hold on
axis equal

set(gca, 'XTick', [], 'YTick', [], 'ZTick', [])
set(gca, 'xcolor', 'w', 'ycolor', 'w','zcolor', 'w') ;

% grid minor
view(25,45)
plot3(0,0,0,'ro')
size=1e7;
plot_planet(size)
plot_orbit(oe_0,'b:')
plot_orbit(oe_f,'r:')


plot3(XYZ(:,1),XYZ(:,2),XYZ(:,3),'k')

plot3(XYZ(1,1),XYZ(1,2),XYZ(1,3),'k*')
plot3(XYZ(end,1),XYZ(end,2),XYZ(end,3),'ko')


l_axis=50000000;
plot_line([0 0 0],[1 0 0],l_axis,'k-',2,'$X_I$',15)
plot_line([0 0 0],[0 1 0],l_axis,'k-',2,'$Y_I$',15)
% plot_line([0 0 0],[0 0 1],l_axis,'k-',2,'$Z_I$',15)


function plot_line(p,dir,d,style,thickness,name,font_size)

p2=p+d*dir;
XYZ=[p;p2];
plt=plot3(XYZ(:,1),XYZ(:,2),XYZ(:,3),style);
plt.LineWidth=thickness;

p2=p+1.1*d*dir;
text(p2(1),p2(2),p2(3),name,'FontSize',font_size, 'Interpreter','latex')

end