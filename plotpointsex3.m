function plotpointsex3(x,y,variable1,variable2,name,filename,figureplot)
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
    xlim([0 0.025])
    ylim([min(y) max(y)])
    xticks([0, 0.005, 0.01, 0.015, 0.02, 0.025])
    xticklabels({'0', '0.005', '0.01', '0.015', '0.02', '0.025'})
    set(gcf,'outerposition',get(0,'screensize'));
    if figureplot == 2
        print([filename,'.png'],'-dpng','-r600')
    end
    drawnow
end
