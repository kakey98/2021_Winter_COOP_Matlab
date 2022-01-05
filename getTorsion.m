function getTorsion = getTorsion(data)

[n,~] = size(data);
getTorsion = zeros(n-3,1);

for i = 1:n-3
    getTorsion(i) = getElementsTorsion(data(i:i+3,:));


end


end

