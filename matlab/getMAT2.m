function S = getMAT2(filePath,sizeEst)
    if nargin>1
        MAT = zeros(sizeEst);
        colName = cell(sizeEst(1),1); block = colName; subName = colName;
    end
    tabread=@(tabStr) textscan(tabStr,'%s','Whitespace','','Delimiter',sprintf('\t'));
    counter=0;
    fid = fopen(filePath,'r');
        line = fgets(fid);
        while (~feof(fid))
            word1 = sscanf(line,'%s',1);
            if strcmp(word1,'TIME')
                h= textscan(line,'%s'); n = length(h{1})-1; colName(counter+1:counter+n) = h{1}(2:end);
                line=fgets(fid); %u =tabread(line);
                line=fgets(fid); s =tabread(line); subName(counter+1:counter+n) = s{1}(3:end);
                line=fgets(fid); b=tabread(line); block(counter+1:counter+n) = b{1}(3:end);
                M = fscanf(fid,'%f',[n+1,inf]); MAT(counter+1:counter+n,1:size(M,2)) = M(2:end,:);
                counter=counter+n;
            end
            line=fgets(fid);
        end
    fclose(fid);
    if nargin>1
        MAT = MAT(1:counter,1:size(M,2)); colName=colName(1:counter); block=block(1:counter); subName=subName(1:counter);
    end
    S.MAT = MAT; S.head = colName; S.block=block; S.subHead=subName;
end