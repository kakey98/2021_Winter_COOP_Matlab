%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% last modified 22 Mar. 2018%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [data_ca] = coordi(filename)

data_ca = [];


fid = fopen(filename,'r'); % 파일 open 함수 사용
fid_out = fopen('ca.pdb','w'); % 파일 open 함수 사용

while ~feof(fid) % 파일이 끝날 때까지 반복
    
    str_read = fgetl(fid); % 파일의 각 라인을 읽는 함수 사용
    n=length(str_read);
    
    if n<80
       str_read = [str_read blanks(80-n)];
    end

    
    str_list = string(strsplit(str_read));
    
    

    if (str_read(1)=='END') % 문자열 비교 함수
        break
    

    
    elseif (str_list(1)=='ATOM' && str_list(3)=="CA" && str_list(5)=="A") % ATOM CA A chain 조건일 때 들어옴
        x = str2double(str_list(7)); % x coordinate info
        y = str2double(str_list(8)); % y coordinate info
        z = str2double(str_list(9)); % z coordinate info
        
		temp = [x,y,z]; % data_ca에 들어갈 정보
        data_ca=[data_ca;temp];
        
        str_read = sprintf('%s\n', str_read); % 각 라인에 엔터 추가
        fprintf(fid_out,str_read); % fid_out 파일에 문자열 저장 함수
        
        
    end
end

fclose(fid);
fclose(fid_out);