clc;clear

W = [0.1,0.1,0.05];   %Size of the Workspaces in Meter m

Ra = 0.009;     % Radius of the Magnet in Meter m
L = 0.005;      % Altitude of the Magnet in Meter m
Br = 1.48;      % Magnetic Remanenz in T
n = 500;        % Number of the Nodes
B = 0.15;
H = 2 * B;      % Width and Length of the calculated area

% [Hy,Hz,q2,q3] = Magnetfield(Ra,L,Br,B,H,n);
% Calculate the Magnetic Field Distribution
Hy = xlsread('Hy.xlsx');
Hz = xlsread('Hz.xlsx');
q2 = xlsread('q2.xlsx');
q3 = xlsread('q3.xlsx');

% [X,Y] = meshgrid(q2,q3);
% mesh(X,Y,Hy')
% T = title('Magnetfeld in $\vec{i}_{2}$ Richtung','fontsize',18)
% set(T,'Interpreter','latex')
% T = xlabel('$q_{2}$','fontsize',18)
% set(T,'Interpreter','latex')
% T = ylabel('$q_{3}$','fontsize',18)
% set(T,'Interpreter','latex')
% xlim([min(q2),max(q2)])
% ylim([min(q3),max(q3)])
% 
% figure
% mesh(X,Y,Hz')
% T = title('Magnetfeld in $\vec{i}_{3}$ Richtung','fontsize',18)
% set(T,'Interpreter','latex')
% T = xlabel('$q_{2}$','fontsize',18)
% set(T,'Interpreter','latex')
% T = ylabel('$q_{3}$','fontsize',18)
% set(T,'Interpreter','latex')
% xlim([min(q2),max(q2)])
% ylim([min(q3),max(q3)])
% 
% figure
% mesh(X,Y,sqrt(Hy.^2+Hz.^2)')
% T = title('Magnetfeldst?rke','fontsize',18)
% set(T,'Interpreter','latex')
% T = xlabel('$q_{2}$','fontsize',18)
% set(T,'Interpreter','latex')
% T = ylabel('$q_{3}$','fontsize',18)
% set(T,'Interpreter','latex')
% xlim([min(q2),max(q2)])
% ylim([min(q3),max(q3)])




Sensorw = sensorposition(W(1),5);            % Sensor positions in global-coordinaten
% figure
% plot(Sensorw(1,:),Sensorw(2,:),'*')
% axis equal
% xticks([-0.05,-0.025,0,0.025,0.05])
% yticks([-0.05,-0.025,0,0.025,0.05])
% xticklabels({'-0.05','-0.025','0','0.025','0.05'})
% yticklabels({'-0.05','-0.025','0','0.025','0.05'})


c1 = -0.05;
c2 = -0.05;
c3 = 0.05;           % Magnet position

for s = 1:25         % sensor index
    for i = 1:300
        for j = 1:300
            theta1 = (i-1)/300*2*pi;
            theta2 = (j-1)/300*2*pi;
            C = [c1,c2,c3,theta1,theta2];
            [rcs thetak]= coordinatentransform(C,Sensorw(:,s));
            [HyV,HzV] = itplt(rcs(2,2),rcs(2,3),q2,q3,Hy,Hz,H,B,n);
            [HxS HyS HzS] = inversetransform(theta1,theta2,thetak,HyV,HzV);
            HS(s,1,i,j) = HxS;
            HS(s,2,i,j) = HyS;
            HS(s,3,i,j) = HzS;
        end
    end
end

% i = 1 : 300;
% j = 1 : 300;
% figure
% theta1 = (i-1)/300*2*pi;
% theta2 = (j-1)/300*2*pi;
% [X,Y] = meshgrid(theta1,theta2);
% mesh(X,Y,squeeze(HS(5,1,:,:)))
% T = title('$H_{x}$ von Sensor 5','fontsize',18)
% set(T,'Interpreter','latex')
% T = xlabel('$\theta_{1}$','fontsize',18)
% set(T,'Interpreter','latex')
% T = ylabel('$\theta_{2}$','fontsize',18)
% set(T,'Interpreter','latex')
% xticks([0,pi/2,pi,3/2*pi,2*pi])
% yticks([0,pi/2,pi,3/2*pi,2*pi])
% xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% yticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% figure
% mesh(X,Y,squeeze(HS(5,2,:,:)))
% T = title('$H_{y}$ von Sensor 5','fontsize',18)
% set(T,'Interpreter','latex')
% T = xlabel('$\theta_{1}$','fontsize',18)
% set(T,'Interpreter','latex')
% T = ylabel('$\theta_{2}$','fontsize',18)
% set(T,'Interpreter','latex')
% xticks([0,pi/2,pi,3/2*pi,2*pi])
% yticks([0,pi/2,pi,3/2*pi,2*pi])
% xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% yticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% figure
% mesh(X,Y,squeeze(HS(5,3,:,:)))
% T = title('$H_{z}$ von Sensor 5','fontsize',18)
% set(T,'Interpreter','latex')
% T = xlabel('$\theta_{1}$','fontsize',18)
% set(T,'Interpreter','latex')
% T = ylabel('$\theta_{2}$','fontsize',18)
% set(T,'Interpreter','latex')
% xticks([0,pi/2,pi,3/2*pi,2*pi])
% yticks([0,pi/2,pi,3/2*pi,2*pi])
% xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% yticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% figure
% mesh(X,Y,squeeze(HS(11,1,:,:)))
% T = title('$H_{x}$ von Sensor 11','fontsize',18)
% set(T,'Interpreter','latex')
% T = xlabel('$\theta_{1}$','fontsize',18)
% set(T,'Interpreter','latex')
% T = ylabel('$\theta_{2}$','fontsize',18)
% set(T,'Interpreter','latex')
% xticks([0,pi/2,pi,3/2*pi,2*pi])
% yticks([0,pi/2,pi,3/2*pi,2*pi])
% xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% yticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% figure
% mesh(X,Y,squeeze(HS(11,2,:,:)))
% T = title('$H_{y}$ von Sensor 11','fontsize',18)
% set(T,'Interpreter','latex')
% T = xlabel('$\theta_{1}$','fontsize',18)
% set(T,'Interpreter','latex')
% T = ylabel('$\theta_{2}$','fontsize',18)
% set(T,'Interpreter','latex')
% xticks([0,pi/2,pi,3/2*pi,2*pi])
% yticks([0,pi/2,pi,3/2*pi,2*pi])
% xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% yticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% figure
% mesh(X,Y,squeeze(HS(11,3,:,:)))
% T = title('$H_{z}$ von Sensor 11','fontsize',18)
% set(T,'Interpreter','latex')
% T = xlabel('$\theta_{1}$','fontsize',18)
% set(T,'Interpreter','latex')
% T = ylabel('$\theta_{2}$','fontsize',18)
% set(T,'Interpreter','latex')
% xticks([0,pi/2,pi,3/2*pi,2*pi])
% yticks([0,pi/2,pi,3/2*pi,2*pi])
% xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% yticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% figure
% mesh(X,Y,squeeze(HS(21,1,:,:)))
% T = title('$H_{x}$ von Sensor 21','fontsize',18)
% set(T,'Interpreter','latex')
% T = xlabel('$\theta_{1}$','fontsize',18)
% set(T,'Interpreter','latex')
% T = ylabel('$\theta_{2}$','fontsize',18)
% set(T,'Interpreter','latex')
% xticks([0,pi/2,pi,3/2*pi,2*pi])
% yticks([0,pi/2,pi,3/2*pi,2*pi])
% xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% yticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% figure
% mesh(X,Y,squeeze(HS(21,2,:,:)))
% T = title('$H_{y}$ von Sensor 21','fontsize',18)
% set(T,'Interpreter','latex')
% T = xlabel('$\theta_{1}$','fontsize',18)
% set(T,'Interpreter','latex')
% T = ylabel('$\theta_{2}$','fontsize',18)
% set(T,'Interpreter','latex')
% xticks([0,pi/2,pi,3/2*pi,2*pi])
% yticks([0,pi/2,pi,3/2*pi,2*pi])
% xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% yticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% figure
% mesh(X,Y,squeeze(HS(21,3,:,:)))
% T = title('$H_{z}$ von Sensor 21','fontsize',18)
% set(T,'Interpreter','latex')
% T = xlabel('$\theta_{1}$','fontsize',18)
% set(T,'Interpreter','latex')
% T = ylabel('$\theta_{2}$','fontsize',18)
% set(T,'Interpreter','latex')
% xticks([0,pi/2,pi,3/2*pi,2*pi])
% yticks([0,pi/2,pi,3/2*pi,2*pi])
% xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% yticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
























