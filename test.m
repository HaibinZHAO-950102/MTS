[X,Y] = meshgrid(q2,q3);
mesh(X,Y,By')
T = title('Magnetfeld in $\vec{i}_{2}$ Richtung','fontsize',18);
set(T,'Interpreter','latex')
T = xlabel('$q_{2}$','fontsize',18);
set(T,'Interpreter','latex')
T = ylabel('$q_{3}$','fontsize',18);
set(T,'Interpreter','latex')
xlim([min(q2),max(q2)])
ylim([min(q3),max(q3)])
