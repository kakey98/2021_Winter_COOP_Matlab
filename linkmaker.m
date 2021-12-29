function k1 = linkmaker(data_ca,cutoff)

arguments
    data_ca;
    cutoff = 12; % distance cutoff
end

[n,~] = size(data_ca);
k1=zeros(n);


for i=1:n-1
  for j=i+1:n
     dis=norm(data_ca(i,:)-data_ca(j,:)); % 두 atoms 간 거리 계산
     if (dis<=cutoff) %cutoff 조건
            k1(i,j)=1;
        else
            k1(i,j)=0;
        end % 거리가 cutoff distance 내에 존재하는지 체크
  end
end


k1 = k1.'+k1;


end
