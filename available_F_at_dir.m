function [sum_F]=available_F_at_dir(F_array,dir)

[n,~]=size(F_array);

sum_F=0;
for i=1:n
    
    contribution=dot(F_array(i,:),dir);
    
    if contribution>0
        sum_F=sum_F+contribution;
    end
    
end


end