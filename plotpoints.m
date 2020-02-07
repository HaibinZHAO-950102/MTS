function plotpoints(x,y,variable1,variable2,name,figureplot)
if figureplot >= 1
    figure
    plot(x,y,'k.','Markersize',8)
    set(gca,'Fontsize',20)
    set(gca,'fontname','times new Roman')
    T = title(name,'fontsize',40);
    set(T,'Interpreter','latex')
    T = xlabel(variable1,'fontsize',30);
    set(T,'Interpreter','latex')
    T = ylabel(variable2,'fontsize',30);
    set(T,'Interpreter','latex')
    xlim([min(x) max(x)])
    ylim([min(y) max(y)])
    if figureplot == 2
        set(gcf,'outerposition',get(0,'screensize'));
        print([name,'.png'],'-dpng','-r600')
    end
    drawnow
end
