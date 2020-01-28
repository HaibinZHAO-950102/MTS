clc;clear
t1 = clock;
A1 = rand(10000,10000);
A11 = A1^-1;
t2 = clock;
A2 = gpuArray.rand(10000,10000);

