function Os = localization2(Bb,initialspace, node, Sensornumber,Sensorw,q2,q3,By,Bz,H,B,n)

N = ceil(log((initialspace(2)-initialspace(1))*1000)/log(node));

for n = 1 : N
    c1l = (initialspace(2)-initialspace(1))/2/node + initialspace(1);
    c1u = initialspace(2) - (initialspace(2)-initialspace(1))/2/node;
    c2l = (initialspace(4)-initialspace(3))/2/node + initialspace(3);
    c2u = initialspace(4) - (initialspace(4)-initialspace(3))/2/node;
    c3l = (initialspace(6)-initialspace(5))/2/node + initialspace(5);
    c3u = initialspace(6) - (initialspace(6)-initialspace(5))/2/node;
    t1l = (initialspace(8)-initialspace(7))/2/node + initialspace(7);
    t1u = initialspace(8) - (initialspace(8)-initialspace(7))/2/node;
    t2l = (initialspace(10)-initialspace(9))/2/node + initialspace(9);
    t2u = initialspace(10) - (initialspace(10)-initialspace(9))/2/node;


    BS = zeros(Sensornumber^2,node,node,node,node,node);
    for s = 1:Sensornumber^2
        for i = 1:node
            for j = 1:node
                for k = 1:node
                    for l = 1:node
                        for m = 1:node
                            c1(i) = c1l + (i-1)*(initialspace(2)-initialspace(1))/node;
                            c2(j) = c2l + (j-1)*(initialspace(4)-initialspace(3))/node;
                            c3(k) = c3l + (k-1)*(initialspace(6)-initialspace(5))/node;
                            theta1(l) = t1l + (l-1)*(initialspace(8)-initialspace(7))/node;
                            theta2(m) = t2l + (m-1)*(initialspace(10)-initialspace(9))/node;
                            C = [c1(i),c2(j),c3(k),theta1(l),theta2(m)];
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
    
    
    
end