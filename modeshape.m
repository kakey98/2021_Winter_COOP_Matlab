function modeshape(data_ca,v,NumOfModes) %NumOfModes->5

	%modeshape(data_ca,v,NumOfModes)
	m=size(data_ca,1); %m->214
	mag_fac = 30*sqrt(m/100); %mag_fac: 총 스텝 양
	step = mag_fac/5; %step: 스텝 하나 양

%%%%%%%%%%%%mat생성%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for mode_num = 1:NumOfModes
		i=6+mode_num;
        
        warning('off','MATLAB:MKDIR:DirectoryExists'); %폴더 중복생성시 경고 off
        mkdir (["Results/mode"+int2str(mode_num)]); %Results 폴더안에 mode1~mode5까지 생성
        steps=-1; %k의 index가 정수로 주어지지않아 steps라는 정수 생성 (mat 파일명 생성에 쓰임)
        warning('on','MATLAB:MKDIR:DirectoryExists');   %폴더 중복생성시 경고 on

		for k=0:step:mag_fac % 0부터 step 간격으로 mag_fac까지 반복 (step 인덱스)
            steps=steps+1; %steps 증가

            %datap, datam 초기화
            datap = zeros(m,3); 
            datam = zeros(m,3);

		    for j=1:m %j: 원자 index
				datap(j,:)=data_ca(j,:) + k*v(3*j-2:3*j,i)'; %v는 column이기 때문에 transpose 사용
				datam(j,:)=data_ca(j,:) - k*v(3*j-2:3*j,i)'; %영행렬의 각 행에다가 결과값 할당
            end
            
            %pathP,pathM 문자열에다 경로만들고 save함수를 통해 저장
            pathP=sprintf("Results/mode%d/datap%d.mat",mode_num,steps); 
            save(pathP,"datap");
            pathM=sprintf("Results/mode%d/datam%d.mat",mode_num,steps);
            save(pathM,"datam");

        end
        addpath(genpath('Results')) %작업을 마친후 Result폴더를 matlab 검색경로에 추가
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
%%%%%%%%%%%%%%%%%%%%%pdb 작성%%%%%%%%%%%%%%%%%%%%%%%%
        pathResult=sprintf("Results/mode%d/data%d.pdb",mode_num,mode_num); %쓰기모드로  생성
        pdbResult = fopen(pathResult,'w');
    %%%%%%%%%%%%datam 먼저%%%%%%%%%%%%%%%%%%%%%%%%%%%
        for j=5:-1:0  %j:참조하는 datamat 번호

            %pdb Output open
            pdb = fopen('ca.pdb','r'); %ca.pdb파일을 open
            

            %해당 
            pathload = sprintf("Results/mode%d/datam%d.mat",mode_num,j);
            load (pathload)

            fprintf(pdbResult,sprintf("MODEL        %d\n",-j+6));
            for k=1:m %각 줄마다
                str_read = fgetl(pdb);
                
                for t=1:3 %x,y,z마다 7글자로 맞추어서 str_read 문자열 수정
                    temp = sprintf("%.3f",datam(k,t));
                    lgn =strlength(temp);
                    if (lgn<7)
                        temp = append(blanks(7-lgn),temp);
                    end
                    str_read(24+8*t:30+8*t) = temp;
                end
                str_read = sprintf('%s\n', str_read); % 각 라인에 엔터 추가
                fprintf(pdbResult,str_read); % output파일에 조건에 맞는 라인을 씀 
            end

            fprintf(pdbResult,"ENDMDL\n");
            fclose(pdb);
        end
        
%%%%%%%%%%%%datap%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        for j=0:5  %j:참조하는 datamat 번호

            %pdb Output open
            pdb = fopen('ca.pdb','r'); %ca.pdb파일을 open
            

            %해당 
            pathload = sprintf("Results/mode%d/datap%d.mat",mode_num,j);
            load (pathload)

            fprintf(pdbResult,sprintf("MODEL        %d\n",7+j));
            for k=1:m %각 줄마다
                str_read = fgetl(pdb);
                
                for t=1:3 %x,y,z마다
                    temp = sprintf("%.3f",datap(k,t));
                   
                    lgn =strlength(temp);
                    if (lgn<7)
                        temp = append(blanks(7-lgn),temp);
                    end
                   
                    str_read(24+8*t:30+8*t) = temp;
                end

                str_read = sprintf('%s\n', str_read); % 각 라인에 엔터 추가
                fprintf(pdbResult,str_read); % output파일에 조건에 맞는 라인을 씀 


            end

            fprintf(pdbResult,"ENDMDL\n");
            fclose(pdb);
        end
        fclose(pdbResult);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end

    

fprintf("PDB Generating Done\n");
end