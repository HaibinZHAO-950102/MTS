function plotsensorposition(Sensorw,x,y,name)
figure
plot(Sensorw(1,:),Sensorw(2,:),'*')
axis equal
xticks([-0.05,-0.025,0,0.025,0.05])
yticks([-0.05,-0.025,0,0.025,0.05])
xticklabels({'-0.05','-0.025','0','0.025','0.05'})
yticklabels({'-0.05','-0.025','0','0.025','0.05'})
xlim([-0.05 0.05])
ylim([-0.05 0.05])
T = title(name,'fontsize',20);
set(T,'Interpreter','latex')
T = xlabel(x,'fontsize',18);
set(T,'Interpreter','latex')
T = ylabel(y,'fontsize',18);
set(T,'Interpreter','latex')
