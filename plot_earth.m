function plot_earth

Re=6378.14;

[X,Y,Z] = sphere;
surf(X*Re,Y*Re,Z*Re)


end
