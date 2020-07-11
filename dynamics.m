function dx = dynamics(x,u,p)


mu=p.mu;

pmee = x(1,:);
fmee = x(2,:);
gmee = x(3,:);
hmee = x(4,:);
xkmee = x(5,:);
xlmee = x(6,:);

% Thrust=u(1,:);
% azimuth=u(2,:);
% elevation=u(3,:);
% pert_1=Thrust.*cos(elevation).*sin(azimuth);
% pert_2=Thrust.*cos(elevation).*cos(azimuth);
% pert_3=Thrust.*sin(elevation);

pert_1=u(1,:);
pert_2=u(2,:);
pert_3=u(3,:);



smovrp = sqrt(mu ./ pmee);

tani2s = hmee.^2 + xkmee.^2;

cosl = cos(xlmee);

sinl = sin(xlmee);

wmee = 1.0 + fmee .* cosl + gmee .* sinl;

% radius = pmee ./ wmee;
% 
% hsmks = hmee.^2 - xkmee.^2;

ssqrd = 1.0 + tani2s;




meedot_1 = 2.0 .* pmee .* pert_2 ./ (wmee .* smovrp);

term1 = ((wmee + 1.0) .* cosl + fmee) .* pert_2;

term2 = (hmee .* sinl - xkmee .* cosl) .* gmee .* pert_3;

meedot_2 = (pert_1 .* sinl + (term1 - term2) ./ wmee) ./ smovrp;

term1 = ((wmee + 1.0) .* sinl + gmee) .* pert_2;

term2 = (hmee .* sinl - xkmee .* cosl) .* fmee .* pert_3;

meedot_3 = (-pert_1 .* cosl + (term1 + term2) ./ wmee) ./ smovrp;

term1 = ssqrd .* pert_3 ./ (2.0 .* wmee .* smovrp);

meedot_4 = term1 .* cosl;

meedot_5 = term1 .* sinl;

meedot_6 = sqrt(mu .* pmee) .* (wmee ./ pmee).^2 ...
    + (hmee .* sinl - xkmee .* cosl) .* pert_3./(wmee .* smovrp);



dx=[meedot_1;meedot_2;meedot_3;meedot_4;meedot_5;meedot_6];


end