function Inertia_mat = point_mass_Inertia(pos_mat,mass_vec)


[N,~]=size(pos_mat);

Inertia_mat=zeros(3,3);

for i=1:N
    x=pos_mat(i,1);
    y=pos_mat(i,2);
    z=pos_mat(i,3);

    x2=x^2;
    y2=y^2;
    z2=x^2;
    xy=x*y;
    xz=x*z;
    yz=y*z;

    Inertia_mat=Inertia_mat+mass_vec(i)*[y2+z2 -xy -xz;-xy x2+z2 -yz;-xz -yz x2+y2];
end

end