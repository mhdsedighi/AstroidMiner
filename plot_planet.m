function plot_planet(size)



[X,Y,Z] = sphere;

surf(X*size,Y*size,Z*size,'EdgeColor','none','FaceColor',[0.9290, 0.6940, 0.1250],'FaceAlpha','0.5')


end
