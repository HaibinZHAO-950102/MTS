function plotresult(meanerror,inner1mm,figureplot)
erroradc = [meanerror(2),meanerror(3),meanerror(1),meanerror(4),meanerror(5)];
errordrift = [meanerror(6),meanerror(7),meanerror(1),meanerror(8),meanerror(9)];
errorsensitivity = [meanerror(10),meanerror(11),meanerror(1),meanerror(12),meanerror(13)];
errorall = [meanerror(1),meanerror(14),meanerror(15),meanerror(16)];
inneradc = [inner1mm(2),inner1mm(3),inner1mm(1),inner1mm(4),inner1mm(5)]/1000;
innerdrift = [inner1mm(6),inner1mm(7),inner1mm(1),inner1mm(8),inner1mm(9)]/1000;
innersensitivity = [inner1mm(10),inner1mm(11),inner1mm(1),inner1mm(12),inner1mm(13)]/1000;
innerall = [inner1mm(1),inner1mm(14),inner1mm(15),inner1mm(16)]/1000;

if figureplot >= 1
    figure
    plot([1,2,3,4,5],erroradc,'k.-','Markersize',40)
    set(gca,'Fontsize',20)
    set(gca,'fontname','times new Roman')
    T = title('Experiment for ADC','fontsize',40);
    set(T,'Interpreter','latex')
    T = xlabel('Experiment','fontsize',30);
    set(T,'Interpreter','latex')
    T = ylabel('Error (mm)','fontsize',30);
    set(T,'Interpreter','latex')
    xlim([1 5])
    xticks([1 2 3 4 5])
    xticklabels({'12 bit','14 bit', '16 bit', '18 bit', '20 bit'})
    set(gcf,'outerposition',get(0,'screensize'));
    if figureplot == 2
        print(['Experiment_for_ADC.png'],'-dpng','-r600')
    end
    drawnow
    
    figure
    plot([1,2,3,4,5],errordrift,'k.-','Markersize',40)
    set(gca,'Fontsize',20)
    set(gca,'fontname','times new Roman')
    T = title('Experiment for Drift','fontsize',40);
    set(T,'Interpreter','latex')
    T = xlabel('Experiment','fontsize',30);
    set(T,'Interpreter','latex')
    T = ylabel('Error (mm)','fontsize',30);
    set(T,'Interpreter','latex')
    xlim([1 5])
    xticks([1 2 3 4 5])
    xticklabels({'0.5%','1%', '2%', '4%', '8%'})
    set(gcf,'outerposition',get(0,'screensize'));
    if figureplot == 2
        print(['Experiment_for_Drift.png'],'-dpng','-r600')
    end
    drawnow
      
    figure
    plot([1,2,3,4,5],errorsensitivity,'k.-','Markersize',40)
    set(gca,'Fontsize',20)
    set(gca,'fontname','times new Roman')
    T = title('Experiment for Sensitivity','fontsize',40);
    set(T,'Interpreter','latex')
    T = xlabel('Experiment','fontsize',30);
    set(T,'Interpreter','latex')
    T = ylabel('Error (mm)','fontsize',30);
    set(T,'Interpreter','latex')
    xlim([1 5])
    xticks([1 2 3 4 5])
    xticklabels({'1бы','2бы', '5бы', '10бы', '20бы'})
    set(gcf,'outerposition',get(0,'screensize'));
    if figureplot == 2
        print(['Experiment_for_Sensitivity.png'],'-dpng','-r600')
    end
    drawnow

    figure
    plot([1,2,3,4],errorall,'k.-','Markersize',40)
    set(gca,'Fontsize',20)
    set(gca,'fontname','times new Roman')
    T = title('Experiment for All','fontsize',40);
    set(T,'Interpreter','latex')
    T = xlabel('Experiment','fontsize',30);
    set(T,'Interpreter','latex')
    T = ylabel('Error (mm)','fontsize',30);
    set(T,'Interpreter','latex')
    xlim([1 4])
    xticks([1 2 3 4])
    xticklabels({'Ex 0','Ex 13', 'Ex 14', 'Ex 15'})
    set(gcf,'outerposition',get(0,'screensize'));
    if figureplot == 2
        print(['Experiment_for_All.png'],'-dpng','-r600')
    end
    drawnow
  
end
