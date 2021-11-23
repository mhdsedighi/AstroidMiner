
XYZ=out.r.Data;



% close all

figure
hold on
axis equal
grid minor
view(25,45)
plot3(0,0,0,'ro')
size=1e7;
plot_planet(size)
plot_orbit(oe_0,'k.')
plot_orbit(oe_f,'r.')


plot3(XYZ(:,1),XYZ(:,2),XYZ(:,3),'b')

plot3(XYZ(1,1),XYZ(1,2),XYZ(1,3),'b*')
plot3(XYZ(end,1),XYZ(end,2),XYZ(end,3),'bo')