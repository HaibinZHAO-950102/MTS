function plotarea(x,y,variable1,variable2,name,figureplot)
if figureplot >= 1
    figure
    plot(x,y,'k.','Markersize',5)
    set(gca,'Fontsize',20)
    set(gca,'fontname','times new Roman')
    T = title(name,'fontsize',40);
    set(T,'Interpreter','latex')
    T = xlabel(variable1,'fontsize',30);
    set(T,'Interpreter','latex')
    T = ylabel(variable2,'fontsize',30);
    set(T,'Interpreter','latex')
    axis equal
    xlim([0 0.15])
    ylim([-0.15 0.15])
    if figureplot == 2
        set(gcf,'outerposition',get(0,'screensize'));
        print([name,'.png'],'-dpng','-r600')
    end
    drawnow
end
