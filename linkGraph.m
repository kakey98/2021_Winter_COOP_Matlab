function linkGraph(input,K)
    %LINKGRAPH 이 함수의 요약 설명 위치
    %   자세한 설명 위치
    
    [n,~]=size(input); %input 행렬의 세로크기를 n에 저장
    
    %%%%%%%%%그래프%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    figure() %새 피규어 (새창) 생성
    hold on %현재 창 유지
    
    title("Linking Visualizing Cutoff")
    
    
    for i=1:n
        scatter3(input(:,1),input(:,2),input(:,3),"b.") %모든 요소에 대해 점 추가
        for j=i:n %선 추가 (j의 시작을 i에서 해서 행렬을 절반만 사용)
            if (i~=j && K(i,j)==1) %i와 j과 같은 경우 동일 요소라서 선을 안그어도됨 && linkmatrix가 1인 경우
                line([input(i,1) input(j,1)], [input(i,2) input(j,2)], [input(i,3) input(j,3)],'Color','black','LineStyle',':','LineWidth',0.1)
            end
        end
    end
    
    for i=1:n-1 %input의 요소좌표들을 순서대로 선을 이어서 backbone 생성
        line([input(i,1) input(i+1,1)], [input(i,2) input(i+1,2)], [input(i,3) input(i+1,3)],'Color','red','LineStyle','-','LineWidth',0.5)
    end
    
    
    hold off
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end

