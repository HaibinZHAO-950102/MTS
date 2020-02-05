function experiment(name, testdata, experimenttimes, Sensorw,Sensornumber,q2,q3,By,Bz,H,B,Nodenumber, vmax, rmax, OG, BG)
Sensordata = testdata(1:4);
k = testdata(5);
Os = zeros(experimenttimes,5);
Error = zeros(experimenttimes,2);
for n = 1 : experimenttimes
    if n == 1
        Decroator(['Localizing the 1st Point / ',num2str(experimenttimes),' Points in ',name],1)
    elseif n == 2
        Decroator(['Localizing the 2nd Point / ',num2str(experimenttimes),' Points in ',name],1)
    elseif n == 3
        Decroator(['Localizing the 3rd Point / ',num2str(experimenttimes),' Points in ',name],1)
    else
        Decroator(['Localizing the ',num2str(n),'th Point / ',num2str(experimenttimes),' Points in ',name],1)
    end
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
end
Parameter = [testdata,NaN(1,7)];
Result = [Parameter;OG(1:experimenttimes,:),Os,Error];
name = [name,'.xlsx'];
xlswrite(name,Result);