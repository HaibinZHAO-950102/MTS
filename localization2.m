function Os = localization2(Bb,Sensornumber,Sensorw,q2,q3,By,Bz,H,B,n)

c1l = -0.05;
c1u = 0.05;
c2l = -0.05;
c2u = 0.05;
c3l = 0;
c3u = 0.05;
t1l = 0;
t1u = 2*pi;
t2l = 0;
t2u = 2*pi;

for n = 1 : 3
    BS = zeros(Sensornumber^2,6,6,6,5,5);
    for s = 1:Sensornumber^2
        for i = 1:6
            for j = 1:6
                for k = 1:6
                    for l = 1:5
                        for m = 1:5
                            c1 = c1l + (i-1)*(c1u-c1l)/5;
                            c2 = c2l + (j-1)*(c2u-c2l)/5;
                            c3 = c3l + (k-1)*(c3u-c3l)/5;
                            theta1 = t1l + (l-1)*(t1u-t1l)/5;
                            theta2 = t2l + (m-1)*(t2u-t2l)/5;
                            C = [c1,c2,c3,theta1,theta2];
                            [rcs, thetak]= coordinatew2i(C,Sensorw(:,s));
                            [ByV,BzV] = itplt(rcs(2,2),rcs(2,3),q2,q3,By,Bz,H,B,n);
                            [BxS, ByS, BzS] = coordinatei2w(C(3),C(4),thetak,ByV,BzV);
                            BS(s,i,j,k,l,m) = BxS;
                        end
                    end
                end
            end
        end
    end
end