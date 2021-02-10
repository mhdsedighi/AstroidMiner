function mat=rand_gen(m,n,mini,maxi)

if length(mini)==1
    mat=mini+(maxi-mini)*rand(m,n);
else
    mat=zeros(1,n);
    for i=1:n  
        mat(1,i)=mini(i)+(maxi(i)-mini(i))*rand;  
    end
end

end