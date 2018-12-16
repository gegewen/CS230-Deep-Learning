A = ones(2500,3);
r = 50;
z = 50;
index = 1;
for i = 1:r
    for j = 1:z
        A(index,1) = j;
        A(index,3) = i;
        index = index +1;
    end
end