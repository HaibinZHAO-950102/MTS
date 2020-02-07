function mesh3D(q2,q3,HM,variable1,variable2,variable3,name,filename,figureplot)
if figureplot >= 1
    figure
    [X,Y] = meshgrid(q2,q3);
    mesh(X,Y,HM')
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
    xlim([min(q2),max(q2)])
    ylim([min(q3),max(q3)])
    zlim([min(min(HM)),max(max(HM))])
    if figureplot == 2
        set(gcf,'outerposition',get(0,'screensize'));
        print([filename,'.png'],'-dpng','-r600')
    end
    drawnow
end