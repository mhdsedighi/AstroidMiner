function Vector_rsw=xyz2rsw(Vector_xyz,R,V)

Vector_rsw=0*Vector_xyz;

e_r=R/norm(R);
h=cross(R,V);
e_w=h/norm(h);
e_s=cross(e_w,e_r);


Vector_rsw(1)=dot(Vector_xyz,e_r);
Vector_rsw(2)=dot(Vector_xyz,e_s);
Vector_rsw(3)=dot(Vector_xyz,e_w);

end