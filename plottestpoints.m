function plottestpoints(x,y,z,variable1,variable2,variable3,name,filename,figureplot)
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
    axis equal
    xlim([-0.05 0.05])
    ylim([-0.05 0.05])
    zlim([0 0.05])
    xticks([-0.05,-0.025, 0, 0.025, 0.05])
    yticks([-0.05,-0.025, 0, 0.025, 0.05])
    zticks([-0.05,-0.025, 0, 0.025, 0.05])
    xticklabels({'-0.05','-0.025', '0', '0.025',  '0.05'})
    yticklabels({'-0.05','-0.025', '0', '0.025',  '0.05'})
    zticklabels({'-0.05','-0.025', '0', '0.025',  '0.05'})
    set(gcf,'outerposition',get(0,'screensize'));
    if figureplot == 2
        print([filename,'_3D.png'],'-dpng','-r600')
    end
    drawnow

    figure
    plot(x,y,'k.','Markersize',15)
    set(gca,'Fontsize',20)
    set(gca,'fontname','times new Roman')
    T = title(name,'fontsize',40);
    set(T,'Interpreter','latex')
    T = xlabel(variable1,'fontsize',30);
    set(T,'Interpreter','latex')
    T = ylabel(variable2,'fontsize',30);
    set(T,'Interpreter','latex')
    axis equal
    xlim([-0.05 0.05])
    ylim([-0.05 0.05])
    xticks([-0.05,-0.025, 0, 0.025, 0.05])
    yticks([-0.05,-0.025, 0, 0.025, 0.05])
    xticklabels({'-0.05','-0.025', '0', '0.025',  '0.05'})
    yticklabels({'-0.05','-0.025', '0', '0.025',  '0.05'})
    grid on
    set(gcf,'outerposition',get(0,'screensize'));
    if figureplot == 2
        print([filename,'_w1w2.png'],'-dpng','-r600')
    end
    drawnow
    
    figure
    plot(y,z,'k.','Markersize',15)
    set(gca,'Fontsize',20)
    set(gca,'fontname','times new Roman')
    T = title(name,'fontsize',40);
    set(T,'Interpreter','latex')
    T = xlabel(variable2,'fontsize',30);
    set(T,'Interpreter','latex')
    T = ylabel(variable3,'fontsize',30);
    set(T,'Interpreter','latex')
    axis equal
    xlim([-0.05 0.05])
    ylim([0 0.05])
    xticks([-0.05,-0.04, -0.03, -0.02, -0.01, 0, 0.01, 0.02, 0.03, 0.04, 0.05])
    yticks([-0.05,-0.04, -0.03, -0.02, -0.01, 0, 0.01, 0.02, 0.03, 0.04, 0.05])
    xticklabels({'-0.05','-0.04','-0.03', '-0.02', '-0.01', '0', '0.01', '0.02', '0.03', '0.04', '0.05'})
    yticklabels({'-0.05','-0.04','-0.03', '-0.02', '-0.01', '0', '0.01', '0.02', '0.03', '0.04', '0.05'})
    grid on
    set(gcf,'outerposition',get(0,'screensize'));
    if figureplot == 2
        print([filename,'_w2w3.png'],'-dpng','-r600')
    end
    drawnow
    
    figure
    plot(x,z,'k.','Markersize',15)
    set(gca,'Fontsize',20)
    set(gca,'fontname','times new Roman')
    T = title(name,'fontsize',40);
    set(T,'Interpreter','latex')
    T = xlabel(variable1,'fontsize',30);
    set(T,'Interpreter','latex')
    T = ylabel(variable3,'fontsize',30);
    set(T,'Interpreter','latex')
    axis equal
    xlim([-0.05 0.05])
    ylim([0 0.05])
    xticks([-0.05,-0.04, -0.03, -0.02, -0.01, 0, 0.01, 0.02, 0.03, 0.04, 0.05])
    yticks([-0.05,-0.04, -0.03, -0.02, -0.01, 0, 0.01, 0.02, 0.03, 0.04, 0.05])
    xticklabels({'-0.05','-0.04','-0.03', '-0.02', '-0.01', '0', '0.01', '0.02', '0.03', '0.04', '0.05'})
    yticklabels({'-0.05','-0.04','-0.03', '-0.02', '-0.01', '0', '0.01', '0.02', '0.03', '0.04', '0.05'})
    grid on
    set(gcf,'outerposition',get(0,'screensize'));
    if figureplot == 2
        print([filename,'_w1w3.png'],'-dpng','-r600')
    end
    drawnow
end
