nr=100; nz=50;
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
        S = getMAT2('C:\Users\gegewen\Desktop\CS230 Project\r=100 5000mD\CO2_OPT.RSM');
%%
CO2 = reshape(S.MAT(2:5001),nr,nz)';
%%
imagesc(CO2)
colorbar
colormap jet