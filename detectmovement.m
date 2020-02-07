function a = detectmovement(q2,q3,Sensordata,k,GBm)
a = NaN(length(q2),length(q3));
for i = 1 : size(GBm,1)
    for j = 1 : size(GBm,2)
        a(i,j) = 5/2^k/Sensordata(4)/sqrt(GBm(i,j,1)^2+GBm(i,j,2)^2);
    end
end
a = a*1000;