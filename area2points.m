function x = area2points(q2,q3,D)
r = 1;
for i = 1 : 5 : length(q2)
    for j = 1 : 5 : length(q3)
        if D(i,j) == 1
            x(r,1) = q2(i);
            x(r,2) = q3(j);
            r = r + 1;
        end
    end
end