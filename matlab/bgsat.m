    fid = fopen(['BGSAT.in'],'w');
for nz = 1:50
    for nr = 1:50
            fprintf(fid,'%i 1 %i /\n',nz,nr);
    end
end
        fclose(fid);
