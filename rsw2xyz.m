function Vector_xyz=rsw2xyz(Vector_rsw,R,V)



e_r=R/norm(R);
h=cross(R,V);
e_w=h/norm(h);
e_s=cross(e_w,e_r);


Vector_xyz=Vector_rsw(1)*e_r+Vector_rsw(2)*e_s+Vector_rsw(3)*e_w;


end