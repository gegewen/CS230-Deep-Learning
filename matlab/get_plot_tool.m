% parentFolder = 'training_cases';
% folderName = strcat('train_sample', num2str(case_num));
folderPath = 'C:\Users\gegewen\Desktop\All_training_cases _square\training_cases\train_sample1 - Copy';
% addpath('C:\Users\gegewen\Desktop\All_training_cases_square');
nr=50; nz=50;
[R,THETA,Z] = meshgrid(1:nr,1,1:nz);
        IJK = [R(:) THETA(:) Z(:)]';
        fid = fopen(['SUMMARY.in'],'w');
            fprintf(fid,'BGSAT\n');
            fprintf(fid,'%i %i %i /\n',IJK);
            fprintf(fid,'/\n');
            fprintf(fid,'BXMF\n');
            fprintf(fid,'%i %i %i /\n',IJK);
            fprintf(fid,'/\n');
            fprintf(fid,'BDENW\n');
            fprintf(fid,'%i %i %i /\n',IJK);
            fprintf(fid,'/\n');
        fclose(fid);
        S = getMAT2(strcat('C:\Users\gegewen\Desktop\All_training_cases _square\training_cases\train_sample1 - Copy','\CO2_OPT.RSM'));
        sat_map = S.MAT(2:2501);
        
%%
%        dis = S.MAT(2)/(S.MAT(2)+S.MAT(3));
        CO2 = reshape(S.MAT(2:2501),nr,nz);
        
%%
imagesc(CO2)
colorbar
colormap jet