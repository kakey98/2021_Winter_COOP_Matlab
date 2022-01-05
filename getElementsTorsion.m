 function torsion_degree = getElementsTorsion(input)
    %torsion = getTorsion(input)
    proj = @(A,n) (A - (A*n')/(n*n')*n); %projection 함수 정의
    
    normal_vector = input(2,:)-input(3,:); %2번과 3번요소로 평면의 법선벡터 도출
    
    
    vector_1 = input(1,:)-input(2,:);        %나머지 벡터 두개 정의
    vector_2 = input(4,:)-input(3,:);
    
    proj_1 = proj(vector_1,normal_vector);  %각각의 정사영 벡터 도출
    proj_2 = proj(vector_2,normal_vector);
    proj_2 = proj_2/norm(proj_2);   %proj_2벡터는 유닛벡터로 만든다

    cross_vector = cross(normal_vector,proj_2); %법선 벡터와 proj_2벡터의 외적벡터도출
    cross_vector = cross_vector / norm(cross(normal_vector,proj_2));
    
    coord_x = (proj_1*proj_2')/(proj_2*proj_2');    %proj_1벡터의 proj_2벡터에 대한 내적값
    coord_y = (proj_1*cross_vector')/(cross_vector*cross_vector');  %proj_1벡터의 외적벡터에 대한 내적값
    
    torsion_radian = atan2(coord_y,coord_x);        %atan2함수이용
    torsion_degree = double(torsion_radian*180/pi);
 end