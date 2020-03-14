function a = detectmovement(Coordinate_q2,Coordinate_q3,Sensitivity,k,GBm)
a = NaN(length(Coordinate_q2),length(Coordinate_q3));
for i = 1 : size(GBm,1)
    for j = 1 : size(GBm,2)
        a(i,j) = 5/2^k/Sensitivity/sqrt(GBm(i,j,1)^2+GBm(i,j,2)^2);
    end
end
a = a*1000;