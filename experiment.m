function experiment(name, Sensordata, k, experimenttimes, Sensorw,Sensornumber,q2,q3,By,Bz,H,B,Nodenumber, vmax, rmax, OG, BG)
Os = zeros(experimenttimes,5);
Error = zeros(experimenttimes,2);
sum = 0;
for n = 1 : experimenttimes
    [name(1:4), ' ',num2str(n)]
    Og = OG(n,:);
    Bg = BG(:,n);
    Vn = Noising(Bg,Sensordata);
    Bb = quantize(Vn,k,Sensordata);
    initialspace(1) = max(Og(1)-vmax*0.01,-0.05);
    initialspace(2) = min(Og(1)+vmax*0.01,0.05);
    initialspace(3) = max(Og(2)-vmax*0.01,-0.05);
    initialspace(4) = min(Og(2)+vmax*0.01,0.05);
    initialspace(5) = max(Og(3)-vmax*0.01,0);
    initialspace(6) = min(Og(3)+vmax*0.01,0.05);
    initialspace(7) = max(Og(4)-rmax*0.01,0);
    initialspace(8) = min(Og(4)+rmax*0.01,2*pi);
    initialspace(9) = max(Og(5)-rmax*0.01,0);
    initialspace(10) = min(Og(5)+rmax*0.01,2*pi);
    node = 4;
    Os(n,:) = localization2(Bb,initialspace,node,Sensornumber,Sensorw,q2,q3,By,Bz,H,B,Nodenumber);
    Error(n,1) = norm(Os(n,1:3) - OG(n,1:3))*1000;
    Error(n,2) = norm(Os(n,4:5) - OG(n,4:5));
    if Error(n,1) < 1
        sum = sum + 1;
    end
end
m = mean(Error(:,1));
R = [sum,m,NaN(1,experimenttimes-2)]';
Result3 = [OG,Os,Error,R];
xlswrite(name,Result3);