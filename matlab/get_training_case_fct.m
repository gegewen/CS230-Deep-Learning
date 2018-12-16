function sat_map = get_training_case_fct(input_matrix,case_num)
% input_matrix dimension: 5000 by 1 vector
%% First modifies PERMR in GRID.IN
% Opens input file
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

% Change cell A
num = length(input_matrix);

before_PERMR = A(1:13);
after_PERMR = A(15:38);

for line = 1:num
    before_PERMR{13+line} = strcat('1*',num2str(input_matrix(line)));
end

new_A = [before_PERMR, {"/"}, after_PERMR];

% Write cell A into txt
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

%% Then modify Pc curve in REL_PERM.IN
% get domain absolute perm value
domain_perm = geomean(input_matrix);

% get input Pc curve from Excel
relaPerm_pc = xlsread('GSF_Pc_curve.xlsx','A1:C36');

% scale input Pc curve (500md) using Leverett J func by domain perm value
relaPerm_pc(:,3) = relaPerm_pc(:,3)*sqrt(500/domain_perm);

% Opens input file
% Read txt into cell B
fid = fopen('REL_PERM_input.IN','r');
i = 1;
tline = fgetl(fid);
B{i} = tline;
while ischar(tline)
    i = i+1;
    tline = fgetl(fid);
    B{i} = tline;
end
B(i) = [];
fclose(fid);

% Change cell B
before_GSF = B(1:56);

for line = 1:length(relaPerm_pc)
    before_GSF{56+line} = strcat(num2str(relaPerm_pc(line,1))," ",...
        num2str(relaPerm_pc(line,2))," ",...
        num2str(relaPerm_pc(line,3)));
end

new_B = [before_GSF, {"/"}];

% Write cell B into txt
fid = fopen('REL_PERM.IN', 'w');
len = numel(new_B);
for i = 1:len
    if i == len
        fprintf(fid,'%s', new_B{i});
        break
    else
        fprintf(fid,'%s\n', new_B{i});
    end
end
fclose(fid);


%% Create num folders and run all in Eclipse
parentFolder = 'training_cases';
% mkdir(parentFolder);
% num = 1;

% for i = 1:num
    folderName = strcat('train_sample', num2str(case_num));
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
%filePath = strcat('C:\Users\gegewen\Desktop\All_training_cases_square\',parentFolder,'\',folderName,'\CO2_OPT.DATA"');
%command = strcat('eclrun e300 "',filePath);
%status = system(command);

%% Plot sat map
%folderPath = strcat('C:\Users\gegewen\Desktop\All_training_cases_square\',parentFolder,'\',folderName);
%sat_map = plot_sat_map_fct(folderPath);
sat_map = 1;
end


