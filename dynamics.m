function dx = dynamics(x,u,p)


mu=p.mu;

pmee = x(1,:);
fmee = x(2,:);
gmee = x(3,:);
hmee = x(4,:);
xkmee = x(5,:);
xlmee = x(6,:);

force_r=u(1,:);
force_t=u(2,:);
force_n=u(3,:);


sinl = sin(xlmee);

cosl = cos(xlmee);

wmee = 1.0 + fmee .* cosl + gmee .* sinl;

sesqr = 1.0 + hmee .* hmee + xkmee .* xkmee;

meedot_1 = (2.0 .* pmee ./ wmee) .* sqrt(pmee ./ mu) .* force_r;

meedot_2 = sqrt(pmee ./ mu) .* (force_r.*sinl+((wmee + 1.0) .* cosl + fmee) .* (force_t ./ wmee) ...
    -(hmee .* sinl - xkmee .* cosl) .* (gmee .* force_n ./ wmee));

meedot_3 = sqrt(pmee ./ mu) .* (-force_r.*cosl+((wmee + 1.0) .* sinl + gmee) .* (force_t ./ wmee) ...
    -(hmee .* sinl - xkmee .* cosl) .* (fmee .* force_n ./ wmee));

meedot_4 = sqrt(pmee ./ mu) .* (sesqr .* force_n ./ (2.0 .* wmee)) .* cosl;

meedot_5 = sqrt(pmee ./ mu) .* (sesqr .* force_n ./ (2.0 .* wmee)) .* sinl;

meedot_6 = sqrt(mu .* pmee) .* (wmee ./ pmee).^2 + (1.0 ./ wmee) .* sqrt(pmee ./ mu) ...
    .* (hmee .* sinl - xkmee .* cosl) .* force_n;

dx=[meedot_1;meedot_2;meedot_3;meedot_4;meedot_5;meedot_6];


end