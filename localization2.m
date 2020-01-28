function Os = localization2(Bb,initialspace, node, Sensornumber,Sensorw,q2,q3,By,Bz,H,B,n)
spacelength = initialspace(2)-initialspace(1);

BS = zeros(Sensornumber^2,node,node,node,node,node);
c1 = zeros(node);
c2 = zeros(node);
c3 = zeros(node);
theta1 = zeros(node);
theta2 = zeros(node);
C = zeros(1,5);
G = zeros(node,node,node,node,node);
while spacelength > 0.0005
     for s = 1:Sensornumber^2
        for i = 1:node
            for j = 1:node
                for k = 1:node
                    for l = 1:node
                        for m = 1:node
                            c1(i) = initialspace(1) + (i-1)*(initialspace(2)-initialspace(1))/(node-1);
                            c2(j) = initialspace(3) + (j-1)*(initialspace(4)-initialspace(3))/(node-1);
                            c3(k) = initialspace(5) + (k-1)*(initialspace(6)-initialspace(5))/(node-1);
                            theta1(l) = initialspace(7) + (l-1)*(initialspace(8)-initialspace(7))/(node-1);
                            theta2(m) = initialspace(9) + (m-1)*(initialspace(10)-initialspace(9))/(node-1);
                            C = [c1(i),c2(j),c3(k),theta1(l),theta2(m)];
                            [rcs, thetak]= coordinatew2i(C,Sensorw(:,s));
                            [ByV,BzV] = itplt(rcs(2,2),rcs(2,3),q2,q3,By,Bz,H,B,n);
                            [BxS, ~, ~] = coordinatei2w(C(3),C(4),thetak,ByV,BzV);
                            BS(s,i,j,k,l,m) = BxS;
                        end
                    end
                end
            end
        end
    end
    for i = 1:node
        for j = 1:node
            for k = 1:node
                for l = 1:node
                    for m = 1:node
                       G(i,j,k,l,m) = sum((BS(:,i,j,k,l,m) - Bb).^2);
                    end
                end
            end
        end
    end
    temp = G(1,1,1,1,1);
    INDEX = [1,1,1,1,1];
    for i = 1:node
        for j = 1:node
            for k = 1:node
                for l = 1:node
                    for m = 1:node
                        if G(i,j,k,l,m) < temp
                            temp = G(i,j,k,l,m);
                            INDEX = [i,j,k,l,m];
                        end
                    end
                end
            end
        end
    end
    Os = [c1(INDEX(1)),c2(INDEX(2)),c3(INDEX(3)),theta1(INDEX(4)),theta2(INDEX(5))];
    spacelength = (initialspace(2)-initialspace(1))/(node-1);
    rotatespacelength = (initialspace(8)-initialspace(7))/(node-1);
    initialspace(1) = max(Os(1)-spacelength,-0.05);
    initialspace(2) = min(Os(1)+spacelength,0.05);
    initialspace(3) = max(Os(2)-spacelength,-0.05);
    initialspace(4) = min(Os(2)+spacelength,0.05);
    initialspace(5) = max(Os(3)-spacelength,0);
    initialspace(6) = min(Os(3)+spacelength,0.05);
    initialspace(7) = max(Os(4)-rotatespacelength,0);
    initialspace(8) = min(Os(4)+rotatespacelength,2*pi);
    initialspace(9) = max(Os(5)-rotatespacelength,0);
    initialspace(10) = min(Os(5)+rotatespacelength,2*pi);
end