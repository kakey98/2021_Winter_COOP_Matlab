function [K Distance] = link(input,d)
% input,d -> linking matrix출력

mag = @(x) sqrt(sum(x.*x)); %mag함수 정의 (익명함수:vector x의 절대값을 구함)
[n,~]=size(input); %input 행렬의 세로크기를 n에 저장

K = zeros(n); %가로세로 n의 크기를 가지는 0으로 이루어진 빈 행렬을 생성
Distance = zeros(n); %요소간 거리 행렬을 빈 행렬로 생성

for i=1:n  %위쪽 대각행렬 생성 (symmetic 행렬임)
    for j=i:n

        Distance(i,j)=mag(input(i,:)-input(j,:)); %요소간 거리 계산

        if (Distance(i,j)<=d) %cutoff 조건
            K(i,j)=1;
        else
            K(i,j)=0;
        end

    end
end



Distance=Distance.'+Distance; %행렬 대칭
K = K.'+K;

for i=1:n %중복된 K를 1로 만들어줌
    K(i,i)=1;
end

%%%%%%%%%그래프%%%%%%%%
figure()
hold on

title(["Linking Visualizing Cutoff:" num2str(d)])

for i=1:n
    scatter3(input(:,1),input(:,2),input(:,3),"b.")
end

for i=1:n
    for j=i:n
        if (i~=j && K(i,j)==1)
            line([input(i,1) input(j,1)], [input(i,2) input(j,2)], [input(i,3) input(j,3)],'Color','blue','LineStyle','-','LineWidth',0.1)
        end
    end
end

hold off
%%%%%%%%%%%%%%%%%%%%%%%
