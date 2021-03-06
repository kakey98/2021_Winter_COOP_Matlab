function [K, d, v] = nma(k1,data_ca)
k=k1;

[m,~]=size(k);

G1 = zeros(3*m);
K = zeros(3*m);

for i=1:m-1
    for j=i+1:m
        if k(i,j) == 0  % linking이 0일시 3X3 0행렬
            G1(3*i-2:3*i,3*j-2:3*j)=zeros(3);

        else %linking이 1일시 
            delta = data_ca(i,:)-data_ca(j,:); %delta를 벡터간 차라고 둠
            G1(3*i-2:3*i,3*j-2:3*j)=(delta.'*delta)/(delta*delta.'); %계산
            
        end
    end
end

G1 = G1.'+G1; %transpose로 대칭

% G1을 통한 K 생성 부분
for i=1:m
K(3*i-2:3*i,:) = -G1(3*i-2:3*i,:); %K의 i번째 행렬을 모두 -G의 i번째 행렬로 전환
temp = zeros(3); %temp값 초기화
    for j=1:m
        temp=temp+G1(3*i-2:3*i,3*j-2:3*j); %G의 i번째 행렬의 모든 행렬 더함
    end

K(3*i-2:3*i,3*i-2:3*i) =  temp; %완성된 temp값을 K의 대각선에 대입
end

[v,d]=eig(K);
d=diag(d);


end