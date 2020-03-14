function plotarrayresult(meanerror,figureplot)
if figureplot >= 1
    figure
    plot([1,2,3,4],meanerror,'k.-','Markersize',40)
    set(gca,'Fontsize',20)
    set(gca,'fontname','times new Roman')
    T = title('Experiment for Sensorarray','fontsize',40);
    set(T,'Interpreter','latex')
    T = xlabel('Sensor Numer','fontsize',30);
    set(T,'Interpreter','latex')
    T = ylabel('Error (mm)','fontsize',30);
    set(T,'Interpreter','latex')
    xlim([1 4])
    xticks([1 2 3 4])
    xticklabels({'3*3','4*4', '5*5', '7*7'})
    set(gcf,'outerposition',get(0,'screensize'));
    if figureplot == 2
        print(['Experiment_for_Sensorarray.png'],'-dpng','-r600')
    end
    drawnow
end
