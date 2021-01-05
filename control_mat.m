function [params]=control_mat(params,quat)



% alligned_Force_vectors=zeros(3,params.N_sat);
% dcm=quat2dcm(quat);
% 
% for i=1:params.N_sat
%     alligned_Force_vectors(:,i)=dcm*params.Force_Vectors(i,:)';
% end
% 
% params.control_mat=[alligned_Force_vectors;params.Moment_Vectors'];

% alligned_Force_vectors=zeros(3,params.N_sat);
% dcm=quat2dcm(quat);
% 
% for i=1:params.N_sat
%     alligned_Force_vectors(:,i)=dcm*params.Force_Vectors(i,:)';
% end

params.control_mat=params.Moment_Vectors';


end