function D = detectablearea(Coordinate_q2,Coordinate_q3,D1,k,Sensitivity, GBm)
D2 = zeros(length(Coordinate_q2),length(Coordinate_q3));
% detectable position change in m
a = 1/1000;
for i = 1: size(GBm,1)
    for j = 1: size(GBm,2)
        if sqrt(GBm(i,j,1)^2+GBm(i,j,2)^2) < 5 / a / 2^k / Sensitivity
            D2(i,j) = 1;
        else
            D2(i,j) = NaN;
        end
    end
end

D = zeros(length(Coordinate_q2),length(Coordinate_q3));
for i = 1 : length(Coordinate_q2)
    for j = 1 : length(Coordinate_q3)
        if D1(i,j)==1 ||  D2(i,j)==1
            D(i,j) = 1;
        else
            D(i,j) = 0;
        end
    end
end
