function mesh3Ddetectedsignal(q2,q3,HM,variable1,variable2,variable3,name,filename,figureplot)
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
    xlim([0,2*pi])
    ylim([0,2*pi])
    zlim([min(min(HM)),max(max(HM))])
    xticks([0 pi/2 pi 1.5*pi 2*pi])
    yticks([0 pi/2 pi 1.5*pi 2*pi])
    xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
    yticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
    set(gcf,'outerposition',get(0,'screensize'));
    if figureplot == 2
        print([filename,'.png'],'-dpng','-r600')
    end
    drawnow
end