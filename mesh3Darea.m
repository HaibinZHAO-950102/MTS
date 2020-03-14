function mesh3Darea(q2,q3,HM,variable1,variable2,variable3,name,filename,figureplot)
if figureplot >= 1
    figure
    [X,Y] = meshgrid(q2,q3);
    mesh(X,Y,HM')
    set(gca,'Fontsize',20)
    set(gca,'fontname','times new Roman')
    title(name,'fontsize',40);
    T = xlabel(variable1,'fontsize',30);
    set(T,'Interpreter','latex')
    T = ylabel(variable2,'fontsize',30);
    set(T,'Interpreter','latex') 
    T = zlabel(variable3,'fontsize',30);
    set(T,'Interpreter','latex')
    xlim([min(q2),max(q2)])
    ylim([min(q3),max(q3)])
    zlim([min(min(HM)),max(max(HM))])
    pbaspect([1 (max(q3)-min(q3))/(max(q2)-min(q2)) 1])
    set(gcf,'outerposition',get(0,'screensize'));
    if figureplot == 2
        print([filename,'.png'],'-dpng','-r600')
    end
    drawnow
end