function D = detectablearea(q2,q3,Sensordata,k,Bm,GBm)
D1 = zeros(length(q2),length(q3));     % D1 are the area that out of the range
for i = 1 : length(q2)
    for j = 1 : length(q3)
        if Bm(i,j) > Sensordata(3)
            D1(i,j) = 0;
        else
            D1(i,j) = NaN;
        end
    end
end


D2 = zeros(length(q2),length(q3));     % D2 is the area smaller than the resolution
a = 1/1000;                          % detectable position change in m
for i = 1: size(GBm,1)
    for j = 1: size(GBm,2)
        if sqrt(GBm(i,j,1)^2+GBm(i,j,2)^2) < 5 / a / 2^k / Sensordata(4)
            D2(i,j) = 0;
        else
            D2(i,j) = NaN;
        end
    end
end

D = zeros(length(q2),length(q3));
for i = 1 : length(q2)
    for j = 1 : length(q3)
        if D1(i,j)==0 ||  D2(i,j)==0
            D(i,j) = 1;
        else
            D(i,j) = 0;
        end
    end
end
