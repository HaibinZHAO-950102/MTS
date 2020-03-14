function orientation_indicator(Orientation,name, filename, figureplot)
if figureplot >= 1
    vec_i_1 = [0,0,0.02];
    n = 100;
    r = 0.009;
    for i = 1 : n
        theta = 2*pi/n * i;
        circle_i(i,:) = [r * sin(theta), r * cos(theta),0] ;
    end

    theta1 = Orientation(4);
    theta2 = Orientation(5);
    mwi = [cos(theta2) 0 sin(theta2);...
        sin(theta1)*sin(theta2) cos(theta1) -sin(theta1)*cos(theta2);...
        -cos(theta1)*sin(theta2) sin(theta1) cos(theta1)*cos(theta2)];

    vec_w_1 = mwi * vec_i_1';
    for i = 1 : n
        circle_w(i,:) = (mwi * circle_i(i,:)')' ;
    end

    O_w = Orientation(1:3)';
    E_w_1 = O_w + vec_w_1;
    figure
    set(gcf,'outerposition',get(0,'screensize'));
    plot3([O_w(1),E_w_1(1)],[O_w(2),E_w_1(2)],[O_w(3),E_w_1(3)],'r-','LineWidth',5)
    for i = 1 : n
        hold on
        plot3(circle_w(i,1)+O_w(1),circle_w(i,2)+O_w(2),circle_w(i,3)+O_w(3),'k.')
    end
    hold on
    plot3(O_w(1),O_w(2),O_w(3),'k.','Markersize',30)
    hold on
    plot3([O_w(1),-0.075],[O_w(2),O_w(2)],[O_w(3),O_w(3)],'b-','LineWidth',2)
    hold on
    plot3([O_w(1),O_w(1)],[O_w(2),-0.075],[O_w(3),O_w(3)],'b-','LineWidth',2)
    hold on
    plot3([O_w(1),O_w(1)],[O_w(2),O_w(2)],[O_w(3),0],'b-','LineWidth',2)
    
    set(gca,'Fontsize',20)
    set(gca,'fontname','times new Roman')
    T = title(name,'fontsize',40);
    set(T,'Interpreter','latex')
    T = xlabel('$\vec{w_{1}}$ (m)','fontsize',30);
    set(T,'Interpreter','latex')
    T = ylabel('$\vec{w_{2}}$ (m)','fontsize',30);
    set(T,'Interpreter','latex')
    T = zlabel('$\vec{w_{3}}$ (m)','fontsize',30);
    set(T,'Interpreter','latex')

    xlim([-0.075 0.075])
    ylim([-0.075 0.075])
    zlim([0 0.075])
    pbaspect([1 1 0.5])
    xticks([-0.075,-0.05,-0.025,0,0.025,0.05,0.075])
    yticks([-0.075,-0.05,-0.025,0,0.025,0.05,0.075])
    zticks([0,0.025,0.05 0.075])
    xticklabels({'-0.075','-0.05','-0.025','0','0.025','0.05','0.075'})
    yticklabels({'-0.075','-0.05','-0.025','0','0.025','0.05','0.075'})
    zticklabels({'0','0.025','0.05','0.075'})
    grid on
    drawnow
    if figureplot == 2
        print([filename,'.png'],'-dpng','-r600')
    end
end
