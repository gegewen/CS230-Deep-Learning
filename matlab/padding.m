input = zeros(1024,1,64,64);
output = zeros(1024,1,64,64);
for i = 1:1024
    input_s = reshape(all(:,i),50,50);
    input(i,1,8:57,8:57) = input_s;
end
for i = 1:1024
    output_s = reshape(hetero_8000_k_mat(:,i),50,50);
    output(i,1,8:57,8:57) = output_s;
end
