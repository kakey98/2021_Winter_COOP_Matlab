%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% last modified 22 Mar. 2018%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [data_ca] = coordi(filename)




%pdb 파일을 불러서 해당 ca들의 좌표행렬 생성



data_ca = [];


fid = fopen(filename,'r'); % input 파일 open 
fid_out = fopen('ca.pdb','w'); % output 파일 open 

while (~feof(fid)) % 파일이 끝날 때까지 반복
    
    str_read = fgetl(fid); % 파일의 각 라인을 읽는 함수 사용
    n=length(str_read);  %읽은 라인의 글자수를 n에 저장
    
    if n<80  % 만약 글자수 n이 80보다 작으면?
       str_read = [str_read blanks(80-n)];  %80자가 되도록 빈칸을 더함
    end

    
    str_list = string(strsplit(str_read));  %읽은 라인을 띄어쓰기 기준으로 문자열 리스트로 나눔
    
    

    if (str_read(1)=='END') %리스트 첫번째가 "END"면 루프문을 끊음
        break
    

    


    
    elseif (str_list(1)=='ATOM' && str_list(3)=="CA" && str_list(5)=="A") % ATOM CA A chain 조건일 때 들어옴

        x = str2double(str_list(7)); % x coordinate info
        y = str2double(str_list(8)); % y coordinate info
        z = str2double(str_list(9)); % z coordinate info
        %string을 double로 바꿈
        


        temp = [x,y,z];%temp에 xyz를 저장
      

	
            temp = [x,y,z]; %temp에 xyz를 저장
        



        data_ca=[data_ca;temp]; %원래 data_ca와 temp를 합쳐 새로운 data_ca를 만듬
        
        str_read = sprintf('%s\n', str_read); % 각 라인에 엔터 추가
        fprintf(fid_out,str_read); % output파일에 조건에 맞는 라인을 씀
        
        
      end
end



fclose(fid);  %input파일 닫음
fclose(fid_out);  %output파일 닫음