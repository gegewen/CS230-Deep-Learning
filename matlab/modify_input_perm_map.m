%% This matlab file opens and modifies the input text file
%% Opens input file
% Read txt into cell A
fid = fopen('GRID_input.IN','r');
i = 1;
tline = fgetl(fid);
A{i} = tline;
while ischar(tline)
    i = i+1;
    tline = fgetl(fid);
    A{i} = tline;
end
A(i) = [];
fclose(fid);

%% Change cell A
num = 5000;
input_matrix = rand(1,num)*1000;

before_PERMR = A(1:13);
after_PERMR = A(15:40);

for line = 1:num
    before_PERMR{13+line} = strcat('1*',num2str(input_matrix(line)));
end

new_A = [before_PERMR, {"/"}, after_PERMR];

%% Write cell A into txt
fid = fopen('GRID.IN', 'w');
len = numel(new_A);
for i = 1:len
    if i == len
        fprintf(fid,'%s', new_A{i});
        break
    else
        fprintf(fid,'%s\n', new_A{i});
    end
end
fclose(fid);


%% Create num folders and run all in Eclipse
parentFolder = 'training_cases';
mkdir(parentFolder);
num = 1;

% for i = 1:num
    folderName = strcat('train_sample', num2str(num));
    mkdir(parentFolder,folderName);
%     cd(strcat(parentFolder,"\",folderName));
    destination = strcat(parentFolder,'\',folderName);
    copyfile('BGSAT.IN', destination);
    copyfile('DIMENS.IN', destination);
    copyfile('GRID.IN', destination);
    copyfile( 'PROPS.IN', destination);
    copyfile( 'REL_PERM.IN', destination);
    copyfile( 'SCHEDULE.IN', destination);
    copyfile('CO2_OPT.DATA', destination);

%% Call eclipse from matlab (actually does work)
filePath = 'Q:\Users\gegewen\All_training_cases\training_cases\train_sample1\CO2_OPT.DATA"';
command = strcat('eclrun e300 "',filePath);
status = system(command);



