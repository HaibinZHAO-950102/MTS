function plotsensorposition(x,y,variable1,variable2,name,figureplot)
if figureplot >= 1
    figure
    plot(x,y,'k.','Markersize',30)
    set(gca,'Fontsize',20)
    set(gca,'fontname','times new Roman')
    T = title(name,'fontsize',40);
    set(T,'Interpreter','latex')
    T = xlabel(variable1,'fontsize',30);
    set(T,'Interpreter','latex')
    T = ylabel(variable2,'fontsize',30);
    set(T,'Interpreter','latex')
    axis equal
    xticks([-0.05,-0.025,0,0.025,0.05])
    yticks([-0.05,-0.025,0,0.025,0.05])
    xticklabels({'-0.05','-0.025','0','0.025','0.05'})
    yticklabels({'-0.05','-0.025','0','0.025','0.05'})
    xlim([-0.05 0.05])
    ylim([-0.05 0.05])
    grid on
    if figureplot == 2
        set(gcf,'outerposition',get(0,'screensize'));
        print([name,'.png'],'-dpng','-r600')
    end
    drawnow
end
