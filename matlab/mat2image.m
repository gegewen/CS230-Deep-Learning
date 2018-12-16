load('hetero_8000_k_mat.mat');
load('hetero_8000.mat');

hetero_8000 = all';
hetero_8000_k = hetero_8000_k_mat';

x_pad_zero = zeros(256,256);
y_pad_zero = zeros(256,256);

for i = 1:1024
    x_data = reshape(hetero_8000_k(i,:),50,50);
    x_pad_zero(102:151,102:151) = x_data./2000.*255;
    y_data = reshape(hetero_8000(i,:),50,50);
    y_pad_zero(102:151,102:151) = y_data.*255;
    input = [x_pad_zero y_pad_zero];
    I = mat2gray(input);
    s = num2str(i);
    s = strcat(s,'.jpg');
    imwrite(I,s)
end

