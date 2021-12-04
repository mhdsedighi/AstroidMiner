% clc; clear; close all
% % addpath OptimTraj
% % addpath chebfun
% load('params')
% load('ref')
load('shape');
params.shape=shape;
addpath('geom3d/geom3d')
addpath('geom3d/meshes3d')




close all
figure
tiledlayout(2,2);

nexttile
hold on
axis equal
% set(gca, 'XTick', [], 'YTick', [], 'ZTick', [])
% set(gca, 'xcolor', 'w', 'ycolor', 'w','zcolor', 'w') ;
xlabel('x')
ylabel('y')
zlabel('z')
view(30,45);
grid minor
astplt=drawMesh(shape.V, shape.F);
% astplt.FaceAlpha=0.2;
% astplt.EdgeAlpha=0.2;
% astplt.FaceColor=[0.3020 0.1529 0.0235];
% astplt.EdgeColor=[0.3020 0.1529 0];
astplt.FaceColor='w';
astplt.EdgeColor=[0.3020 0.1529 0.0235];
astplt.LineWidth=0.06;
% lighting flat
% material metal






nexttile
hold on
axis equal
xlabel('x')
ylabel('y')
zlabel('z')
view(90,90);
grid minor


astplt=drawMesh(shape.V, shape.F);
% astplt.FaceAlpha=0.2;
% astplt.EdgeAlpha=0.2;
% astplt.FaceColor=[0.3020 0.1529 0.0235];
% astplt.EdgeColor=[0.3020 0.1529 0];
astplt.LineWidth=0.1;
astplt.EdgeColor=[0.3020 0.1529 0.0235];
astplt.FaceColor='w';
% lighting flat
% material metal


nexttile
hold on
axis equal
xlabel('x')
ylabel('y')
zlabel('z')
view(0,0);
grid minor




astplt=drawMesh(shape.V, shape.F);
% astplt.FaceAlpha=0.2;
% astplt.EdgeAlpha=0.2;
% astplt.FaceColor=[0.3020 0.1529 0.0235];
astplt.EdgeColor=[0.3020 0.1529 0.0235];
astplt.FaceColor='w';
% astplt.EdgeColor=[0.3020 0.1529 0];
astplt.LineWidth=0.1;
% lighting flat
% material metal

nexttile
hold on
axis equal
xlabel('x')
ylabel('y')
zlabel('z')
view(90,0);
grid minor
astplt=drawMesh(shape.V, shape.F);
% astplt.FaceAlpha=0.2;
% astplt.EdgeAlpha=0.2;
% astplt.FaceColor=[0.3020 0.1529 0.0235];
% astplt.EdgeColor=[0.3020 0.1529 0];
astplt.EdgeColor=[0.3020 0.1529 0.0235];
astplt.FaceColor='w';
astplt.LineWidth=0.1;
% lighting flat
% material metal



% exportgraphics(gca,'test.emf','ContentType','vector')
% print('test3','-dsvg','-vector')
print('test4','-dmeta','-vector')






