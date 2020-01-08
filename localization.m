function Os = localization(Bb,O0, By, Bz, GBy, GBz, q2, q3, H, B, n, sensornumber, Sensorw)
% to localize the Orientation of Magnet
% Bb is the measurment
% O0 is the initial point
% GBy is the gradient of MFD in y direction w.r.t. q2 and q3
% GBz is the gradient of MFD in z direction w.r.t. q2 and q3

for n = 1 : 30
    for j = 1 : sensornumber^2
         [rcs, thetak]= coordinatew2i(O0,Sensorw(:,j));
         [ByV,BzV] = itplt(rcs(2,2),rcs(2,3),q2,q3,By,Bz,H,B,n);
         [BxS, ByS, BzS] = coordinatei2w(O0(3),O0(4),thetak,ByV,BzV);
         BxO0 = BxS;
         [GB22V,GB32V] = itplt(rcs(2,2),rcs(2,3),q2,q3,GBy(:,:,1),GBz(:,:,1),H,B,n);
         [GB23V,GB33V] = itplt(rcs(2,2),rcs(2,3),q2,q3,GBy(:,:,2),GBz(:,:,2),H,B,n);
         A = [-cos(O0(5)),0,-sin(O0(4));
             -sin(O0(4))*sin(O0(5)),-cos(O0(4)),sin(O0(4))*cos(O0(5));
             cos(O0(4))*sin(O0(5)),-sin(O0(4)),-cos(O0(4))*cos(O0(5));
             (-O0(2)+Sensorw(2,j))*cos(O0(4))*sin(O0(5))-O0(3)*sin(O0(4))*sin(O0(5)),...
                 (O0(2)-Sensorw(2,j))*sin(O0(4))-O0(3)*cos(O0(4)),...
                 (O0(2)-Sensorw(2,j))*cos(O0(4))*cos(O0(5))+O0(3)*sin(O0(4))*cos(O0(5));
             (O0(1)-Sensorw(1,j))*sin(O0(5))+(-O0(2)+Sensorw(2,j))*sin(O0(4))*cos(O0(5))+O0(3)*cos(O0(4))*cos(O0(5)),...
                 0,...
                 (-O0(1)+Sensorw(1,j))*cos(O0(5))+(-O0(2)+Sensorw(2,j))*sin(O0(4))*sin(O0(5))+O0(3)*cos(O0(4))*sin(O0(5))];
        pj(:,j) = (Bb(j)-BxO0) * A * [0,-sin(thetak),0;0,cos(thetak),0;0,0,1] * [0,0,0;0,GB22V,GB32V;0,GB23V,GB33V] * [0;-sin(thetak)*cos(O0(5));sin(O0(5))];
        p = nansum(pj')';
        p = p / norm(p);
    end
    alpha(1) = 0.0002;
    for i = 2 : 20
        alpha(i) = alpha(i-1) * 1.7;
    end
    for i = 1 : 10
        O1 = O0 + p * alpha(i);
        if O1(1) > 0.05
            O1(1) = 0.05;
        end
        if O1(1) < -0.05
            O1(1) = -0.05;
        end
        if O1(2) > 0.05
            O1(2) = 0.05;
        end
        if O1(2) < -0.05
            O1(2) = -0.05;
        end
        if O1(3) > 0.05
            O1(3) = 0.05;
        end
        if O1(3) < 0
            O1(3) = 0;
        end
            
        for j = 1 : sensornumber^2
            [rcs, thetak]= coordinatew2i(O1,Sensorw(:,j));
            [ByV,BzV] = itplt(rcs(2,2),rcs(2,3),q2,q3,By,Bz,H,B,n);
            [BxS, ByS, BzS] = coordinatei2w(O1(3),O1(4),thetak,ByV,BzV);
            BxO0 = BxS;
            Gj(j) = 0.5 * norm(Bb(j)-BxS)^2;
        end
        G(i) = nansum(Gj);
        if i >= 3
            if G(i-2)> G(i-1) & G(i-1) < G(i)
                O0 = O0 + alpha(i-1)*p;
                break
            end
        end
    end
end
Os = O0;

        
        
        
        
        
        
        
        
        
        
        
        
    
