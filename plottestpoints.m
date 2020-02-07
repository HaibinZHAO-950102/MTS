function plottestpoints(x,y,z,variable1,variable2,variable3,name,figureplot)
if figureplot >= 1
    figure
    plot3(x,y,z,'k.','Markersize',15)
    set(gca,'Fontsize',20)
    set(gca,'fontname','times new Roman')
    T = title(name,'fontsize',40);
    set(T,'Interpreter','latex')
    T = xlabel(variable1,'fontsize',30);
    set(T,'Interpreter','latex')
    T = ylabel(variable2,'fontsize',30);
    set(T,'Interpreter','latex')
    T = zlabel(variable3,'fontsize',30);
    set(T,'Interpreter','latex')
    ZERO = zeros(length(z),1);
    for i = 1 : length(z)
        hold on
        plot3([x(i);x(i)],[y(i);y(i)],[z(i);ZERO(i)],'c-','linewidth',0.1);
    end
    grid on
    xlim([-0.05 0.05])
    ylim([-0.05 0.05])
    zlim([0 0.05])
    if figureplot == 2
        set(gcf,'outerposition',get(0,'screensize'));
        print([name,'0.png'],'-dpng','-r600')
    end
    drawnow

    figure
    plot(x,y,'k.','Markersize',15)
    T = title(name,'fontsize',40);
    set(T,'Interpreter','latex')
    T = xlabel(variable1,'fontsize',30);
    set(T,'Interpreter','latex')
    T = ylabel(variable2,'fontsize',30);
    set(T,'Interpreter','latex')
    xlim([-0.05 0.05])
    ylim([-0.05 0.05])
    if figureplot == 2
        set(gcf,'outerposition',get(0,'screensize'));
        print([name,'2.png'],'-dpng','-r600')
    end
    drawnow
    
    figure
    plot(y,z,'k.','Markersize',15)
    T = title(name,'fontsize',40);
    set(T,'Interpreter','latex')
    T = xlabel(variable2,'fontsize',30);
    set(T,'Interpreter','latex')
    T = ylabel(variable3,'fontsize',30);
    set(T,'Interpreter','latex')
    xlim([-0.05 0.05])
    ylim([0 0.05])
    if figureplot == 2
        set(gcf,'outerposition',get(0,'screensize'));
        print([name,'3.png'],'-dpng','-r600')
    end
    drawnow
    
    figure
    plot(x,z,'k.','Markersize',15)
    T = title(name,'fontsize',40);
    set(T,'Interpreter','latex')
    T = xlabel(variable1,'fontsize',30);
    set(T,'Interpreter','latex')
    T = ylabel(variable3,'fontsize',30);
    set(T,'Interpreter','latex')
    xlim([-0.05 0.05])
    ylim([0 0.05])
    if figureplot == 2
        set(gcf,'outerposition',get(0,'screensize'));
        print([name,'3.png'],'-dpng','-r600')
    end
    drawnow
end
