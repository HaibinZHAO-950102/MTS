function meshpoints(x,y,z,xq1,xq2,yq1,yq2,variable1,variable2,variable3,name,figureplot)
if figureplot >= 1
    figure
    [X,Y]=meshgrid(xq1:(xq2-xq1)/1000:xq2,yq1:(yq2-yq1)/1000:yq2);
    Z = griddata(x,y,z,X,Y);
    mesh(X,Y,Z)
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
    xlim([-0.05,0.05])
    ylim([-0.05,0.05])
    zlim([0,max(z)])
    if figureplot == 2
        set(gcf,'outerposition',get(0,'screensize'));
        print([name,'.png'],'-dpng','-r600')
    end
    drawnow
end
