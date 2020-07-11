function plot_earth

Re=6378.14;

[X,Y,Z] = sphere;
surf(X*Re,Y*Re,Z*Re,'EdgeColor','none','FaceColor',[0 0 1],'FaceAlpha','0.2')


end
