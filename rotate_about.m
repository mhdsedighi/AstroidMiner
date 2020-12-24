function [Vec_new]=rotate_about(Vec,O,pitch,yaw)

V1=Vec-O;

dcm = angle2dcm(yaw,pitch,0);  %% order of rotation to be checked

V2=dcm*V1';

Vec_new=V2'+O;

end