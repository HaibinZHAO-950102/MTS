function [O Bb] = randpoint(Sensorw,Sensornumber,q2,q3,By,Bz,H,B,Nodenumber)
O(1) = rand()*0.1-0.05;
O(2) = rand()*0.1-0.05;
O(3) = rand()*0.05;
O(4) = rand()*2*pi;
O(5) = rand()*2*pi;
for s = 1 : Sensornumber^2
    [rcs, thetak]= coordinatew2i(O,Sensorw(:,s));
    [ByV,BzV] = itplt(rcs(2,2),rcs(2,3),q2,q3,By,Bz,H,B,Nodenumber);
    [BxS, ByS, BzS] = coordinatei2w(O(3),O(4),thetak,ByV,BzV);
    Bb(s,1) = BxS;
end

