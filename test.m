clc;clear
for s = 1:Sensornumber^2
    C1 = [-0.0402   -0.0222    0.0273    6.0162    6.0626];
    C2 = 
    [rcs, thetak]= coordinatew2i(C,Sensorw(:,s));
    [ByV,BzV] = itplt(rcs(2,2),rcs(2,3),q2,q3,By,Bz,H,B,n);
    [BxS, ByS, BzS] = coordinatei2w(C(3),C(4),thetak,ByV,BzV);
    BS(s,i,j,k,l,m) = BxS;
                  
end