function plotarea(q2,q3,D,variable1,variable2,name)
figure
for i = 1:12:size(D,1)
    for j = 1:12:size(D,2)
        if D(i,j) == 1
            hold on
            plot(q2(i),q3(j),'k.','Markersize',5)
        end
    end
end
i = size(D,1);
axis equal
T = title(name,'fontsize',20);
set(T,'Interpreter','latex')
T = xlabel(variable1,'fontsize',18);
set(T,'Interpreter','latex')
T = ylabel(variable2,'fontsize',18);
set(T,'Interpreter','latex')
xlim([min(q2),max(q2)])
ylim([min(q3),max(q3)])
