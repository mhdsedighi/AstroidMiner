function plot_vector(x_base,y_base,z_base,direction)

quiver3(x_base,y_base,z_base,direction(1),direction(2),direction(3),'LineWidth',2);


end

