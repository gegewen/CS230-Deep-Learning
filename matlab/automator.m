%% All training cases automator
clc
load('random_k_mat_square.mat');
dim = size(random_k_mat);
all_sat_results = NaN(dim(1),dim(2));

%%
for case_num = 6001:12000 % 1:dim(2)
    input_perm_map = random_k_mat(:,case_num);
    all_sat_results(:,case_num) = get_training_case_fct(input_perm_map,case_num);
end

%%
%all_sat_results_square1 = all_sat_results(:,1:128);
%random_k_mat_square1 = random_k_mat(:,1:128);
% A = load('all_sat_results1.mat');
% B = load('all_sat_results2.mat');
% C = load('all_sat_results3.mat');
% all_sat_results(:,1:6000) = A.all_sat_results(:,1:6000);
% all_sat_results(:,6001:6442) = B.all_sat_results(:,6001:6442);
% all_sat_results(:,6444:12000) = C.all_sat_results(:,6444:12000);
