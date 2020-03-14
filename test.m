clc
clear
cut = 'Experiment_for_';
len = length(cut);

files = dir('E:\Matlab\Project_github\MTS');
for i = 1 : size(files,1)
    NAME = files(i).name;
    l = size(NAME,2);
    if l >= 4
        TYPE = NAME(l-2:l);
        if TYPE == 'png'
            if l > len
                if NAME(1:len) == cut
                    I = cutfigure(NAME);
                    imwrite(I,NAME)
                end
            end
        end
    end
end

