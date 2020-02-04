function mesh3D(q2,q3,HM,variable1,variable2,name)
figure
[X,Y] = meshgrid(q2,q3);
mesh(X,Y,HM')
T = title(name,'fontsize',20);
set(T,'Interpreter','latex')
T = xlabel(variable1,'fontsize',18);
set(T,'Interpreter','latex')
T = ylabel(variable2,'fontsize',18);
set(T,'Interpreter','latex')
xlim([min(q2),max(q2)])
ylim([min(q3),max(q3)])