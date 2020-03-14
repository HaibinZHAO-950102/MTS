function gradient = grad(MFD,Coordinate_q2,Coordinate_q3)
% to calculate the gradient
dq2 = Coordinate_q2(2) - Coordinate_q2(1);
dq3 = Coordinate_q3(2) - Coordinate_q3(1);
for i = 1 : length(Coordinate_q2) - 1
    for j = 1 : length(Coordinate_q3) - 1
        gradient(i,j,1) = (MFD(i+1,j) - MFD(i,j))/dq2;
        gradient(i,j,2) = (MFD(i,j+1) - MFD(i,j))/dq3;
    end
end
