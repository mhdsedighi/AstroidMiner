function [params]=rigid_positioning(N_sat,a,b,c,azimuths,elevations,pitchs,yaws)

d2r=0.017453292519943;

Force_Vectors=zeros(N_sat,3);
Moment_Vectors=zeros(N_sat,3);

for i=1:N_sat
    
    [x,y,z,normal_vector]=ellip_deg(a,b,c,azimuths(i),elevations(i));
    
    sat_pos=[x,y,z];
    [normal_vector]=rotate_about(normal_vector,sat_pos,d2r*pitchs(i),d2r*yaws(i));
    
    Force_Vectors(i,:)=normal_vector;
    Moment_Vectors(i,:)=cross(sat_pos,normal_vector);
    
end

params.N_sat=N_sat;
params.Force_Vectors=Force_Vectors;
params.Moment_Vectors=Moment_Vectors;


end