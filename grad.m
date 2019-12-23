function grad = grad(B,q2,q3)
% to calculate the gradient
dq2 = q2(2) - q2(1);
dq3 = q3(2) - q3(1);
for i = 1 : length(q2) - 1
    for j = 1 : length(q3) - 1
        grad(i,j,1) = (B(i+1,j) - B(i,j))/dq2;
        grad(i,j,2) = (B(i,j+1) - B(i,j))/dq3;
    end
end
