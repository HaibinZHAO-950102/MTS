function Inew = cutfigure(filename)
    I = imread(filename);
    Ig = rgb2gray(I);
    [m,n] = size(Ig);
    cutedge = [1 1 m n];

    for i = 1 : m
        if sum(Ig(i,:)) < n * 255
            cutedge(1) = i;
            break
        end
    end
    for i = 1 : n
        if sum(Ig(:,i)) < m * 255
            cutedge(2) = i;
            break
        end
    end
    for i = m : -1 : 1
        if sum(Ig(i,:)) < n * 255
            cutedge(3) = i;
            break
        end
    end
    for i = n : -1 : 1
        if sum(Ig(:,i)) < m * 255
            cutedge(4) = i;
            break
        end
    end

    Cutedge = cutedge + [-100 -100 100 100];
    if Cutedge(1) <= 0
        Cutedge(1) = 1;
    end
    if Cutedge(2) <= 0
        Cutedge(2) = 1;
    end
    if Cutedge(3) > m
        Cutedge(3) = m;
    end
    if Cutedge(4) > n
        Cutedge(4) = n;
    end
   
    Inew = I(Cutedge(1):Cutedge(3),Cutedge(2):Cutedge(4),:);
end