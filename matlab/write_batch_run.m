names = cell(1000,1);
for i = 1:99
    filePath = strcat('eclrun e300 "M:\train_sample',num2str(i),'\CO2_OPT.DATA"');
    names{i} = filePath;
end
fileID = fopen('RUN.BAT','w');
formatSpec = '%s\n';
[nrows,ncols] = size(names);
for row = 1:nrows
    fprintf(fileID,formatSpec,names{row,1});
end
fclose(fileID);
