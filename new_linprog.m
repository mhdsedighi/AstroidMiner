function [x,exitflag] = new_linprog(f,C,b,lb,ub)


coder.extrinsic('linprog'); 

% options = optimset;
% options.MaxIter=200;
% options.Display='none';
[x,~,exitflag] = linprog(f,[],[],C,b,lb,ub);





end

