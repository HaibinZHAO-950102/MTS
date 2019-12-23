clc;clear

W = [0.1,0.1,0.05];   %Size of the Workspaces in Meter m

Ra = 0.009;     % Radius of the Magnet in Meter m
L = 0.005;      % Altitude of the Magnet in Meter m
Br = 1.48;      % Magnetic Remanenz in T
n = 500;        % Number of the Nodes
B = 0.15;
H = 2 * B;      % Width and Length of the calculated area
mu0 = 4*pi*10^-7;
Sensordata = [2, 2.5, 500, 5/1000]; % Error, Zerovoltage, Range, Sensitivity
Sensornumber = 5; % number of sensors on each edge
k = 11;            % AD Converter bit


%[Hy,Hz,q2,q3] = Magnetfield(Ra,L,Br,B,H,n);
%Calculate the Magnetic Field Distribution
Hy = xlsread('Hy.xlsx');
Hz = xlsread('Hz.xlsx');
q2 = xlsread('q2.xlsx');
q3 = xlsread('q3.xlsx');
Hm = sqrt(Hy.^2+Hz.^2);

% MFS into MFD in Gauss
By = Hy * mu0 * 10000;
Bz = Hz * mu0 * 10000;
Bm = Hm * mu0 * 10000;

% [X,Y] = meshgrid(q2,q3);
% mesh(X,Y,By')
% T = title('MFD in $\vec{i}_{2}$ Richtung','fontsize',18);
% set(T,'Interpreter','latex')
% T = xlabel('$q_{2}$','fontsize',18);
% set(T,'Interpreter','latex')
% T = ylabel('$q_{3}$','fontsize',18);
% set(T,'Interpreter','latex')
% xlim([min(q2),max(q2)])
% ylim([min(q3),max(q3)])
% 
% figure
% mesh(X,Y,Bz')
% T = title('MFD in $\vec{i}_{3}$ Richtung','fontsize',18);
% set(T,'Interpreter','latex')
% T = xlabel('$q_{2}$','fontsize',18);
% set(T,'Interpreter','latex')
% T = ylabel('$q_{3}$','fontsize',18);
% set(T,'Interpreter','latex')
% xlim([min(q2),max(q2)])
% ylim([min(q3),max(q3)])
% 
% figure
% mesh(X,Y,Bm')
% T = title('MFD','fontsize',18);
% set(T,'Interpreter','latex')
% T = xlabel('$q_{2}$','fontsize',18);
% set(T,'Interpreter','latex')
% T = ylabel('$q_{3}$','fontsize',18);
% set(T,'Interpreter','latex')
% xlim([min(q2),max(q2)])
% ylim([min(q3),max(q3)])


% Grandient
GBm = grad(Bm,q2,q3);
GBy = grad(By,q2,q3);
GBz = grad(Bz,q2,q3);

% [X,Y] = meshgrid(q2(1:length(q2)-1),q3(1:length(q3)-1));
% mesh(X,Y,GBm(:,:,1)')
% T = title('$\frac{\partial{B_{m}}}{\partial{q_{2}}}$','fontsize',18);
% set(T,'Interpreter','latex')
% T = xlabel('$q_{2}$','fontsize',18);
% set(T,'Interpreter','latex')
% T = ylabel('$q_{3}$','fontsize',18);
% set(T,'Interpreter','latex')
% xlim([min(q2),max(q2)])
% ylim([min(q3),max(q3)])
% 
% figure
% [X,Y] = meshgrid(q2(1:length(q2)-1),q3(1:length(q3)-1));
% mesh(X,Y,GBm(:,:,2)')
% T = title('$\frac{\partial{B_{m}}}{\partial{q_{3}}}$','fontsize',18);
% set(T,'Interpreter','latex')
% T = xlabel('$q_{2}$','fontsize',18);
% set(T,'Interpreter','latex')
% T = ylabel('$q_{3}$','fontsize',18);
% set(T,'Interpreter','latex')
% xlim([min(q2),max(q2)])
% ylim([min(q3),max(q3)])
% 
% figure
% [X,Y] = meshgrid(q2(1:length(q2)-1),q3(1:length(q3)-1));
% mesh(X,Y,GBy(:,:,1)')
% T = title('$\frac{\partial{B_{y}}}{\partial{q_{2}}}$','fontsize',18);
% set(T,'Interpreter','latex')
% T = xlabel('$q_{2}$','fontsize',18);
% set(T,'Interpreter','latex')
% T = ylabel('$q_{3}$','fontsize',18);
% set(T,'Interpreter','latex')
% xlim([min(q2),max(q2)])
% ylim([min(q3),max(q3)])
% 
% figure
% [X,Y] = meshgrid(q2(1:length(q2)-1),q3(1:length(q3)-1));
% mesh(X,Y,GBy(:,:,2)')
% T = title('$\frac{\partial{B_{y}}}{\partial{q_{3}}}$','fontsize',18);
% set(T,'Interpreter','latex')
% T = xlabel('$q_{2}$','fontsize',18);
% set(T,'Interpreter','latex')
% T = ylabel('$q_{3}$','fontsize',18);
% set(T,'Interpreter','latex')
% xlim([min(q2),max(q2)])
% ylim([min(q3),max(q3)])
% 
% figure
% [X,Y] = meshgrid(q2(1:length(q2)-1),q3(1:length(q3)-1));
% mesh(X,Y,GBz(:,:,1)')
% T = title('$\frac{\partial{B_{z}}}{\partial{q_{2}}}$','fontsize',18);
% set(T,'Interpreter','latex')
% T = xlabel('$q_{2}$','fontsize',18);
% set(T,'Interpreter','latex')
% T = ylabel('$q_{3}$','fontsize',18);
% set(T,'Interpreter','latex')
% xlim([min(q2),max(q2)])
% ylim([min(q3),max(q3)])
% 
% figure
% [X,Y] = meshgrid(q2(1:length(q2)-1),q3(1:length(q3)-1));
% mesh(X,Y,GBz(:,:,2)')
% T = title('$\frac{\partial{B_{z}}}{\partial{q_{3}}}$','fontsize',18);
% set(T,'Interpreter','latex')
% T = xlabel('$q_{2}$','fontsize',18);
% set(T,'Interpreter','latex')
% T = ylabel('$q_{3}$','fontsize',18);
% set(T,'Interpreter','latex')
% xlim([min(q2),max(q2)])
% ylim([min(q3),max(q3)])

Sensorw = sensorposition(W(1),Sensornumber);            % Sensor positions in global-coordinaten
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

BS = zeros(Sensornumber^2,3,300,300);
for s = 1:Sensornumber^2         % sensor index
    for i = 1:300
        for j = 1:300
            theta1 = (i-1)/300*2*pi;
            theta2 = (j-1)/300*2*pi;
            C = [c1,c2,c3,theta1,theta2];
            [rcs, thetak]= Coordinatentransform(C,Sensorw(:,s));
            [ByV,BzV] = itplt(rcs(2,2),rcs(2,3),q2,q3,By,Bz,H,B,n);
            [BxS, ByS, BzS] = inversetransform(C(3),C(4),thetak,ByV,BzV);
            BS(s,1,i,j) = BxS;
            BS(s,2,i,j) = ByS;
            BS(s,3,i,j) = BzS;
        end
    end
end
% 
% i = 1 : 300;
% j = 1 : 300;
% figure
% theta1 = (i-1)/300*2*pi;
% theta2 = (j-1)/300*2*pi;
% [X,Y] = meshgrid(theta1,theta2);
% mesh(X,Y,squeeze(BS(4,1,:,:)))
% T = title('$B_{x}$ von Sensor 4','fontsize',18);
% set(T,'Interpreter','latex')
% T = xlabel('$\theta_{1}$','fontsize',18);
% set(T,'Interpreter','latex')
% T = ylabel('$\theta_{2}$','fontsize',18);
% set(T,'Interpreter','latex')
% xticks([0,pi/2,pi,3/2*pi,2*pi])
% yticks([0,pi/2,pi,3/2*pi,2*pi])
% xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% yticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% figure
% mesh(X,Y,squeeze(BS(4,2,:,:)))
% T = title('$B_{y}$ von Sensor 4','fontsize',18);
% set(T,'Interpreter','latex')
% T = xlabel('$\theta_{1}$','fontsize',18);
% set(T,'Interpreter','latex')
% T = ylabel('$\theta_{2}$','fontsize',18);
% set(T,'Interpreter','latex')
% xticks([0,pi/2,pi,3/2*pi,2*pi])
% yticks([0,pi/2,pi,3/2*pi,2*pi])
% xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% yticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% figure
% mesh(X,Y,squeeze(BS(4,3,:,:)))
% T = title('$B_{z}$ von Sensor 5','fontsize',18);
% set(T,'Interpreter','latex')
% T = xlabel('$\theta_{1}$','fontsize',18);
% set(T,'Interpreter','latex')
% T = ylabel('$\theta_{2}$','fontsize',18);
% set(T,'Interpreter','latex')
% xticks([0,pi/2,pi,3/2*pi,2*pi])
% yticks([0,pi/2,pi,3/2*pi,2*pi])
% xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% yticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% figure
% mesh(X,Y,squeeze(BS(11,1,:,:)))
% T = title('$B_{x}$ von Sensor 11','fontsize',18);
% set(T,'Interpreter','latex')
% T = xlabel('$\theta_{1}$','fontsize',18);
% set(T,'Interpreter','latex')
% T = ylabel('$\theta_{2}$','fontsize',18);
% set(T,'Interpreter','latex')
% xticks([0,pi/2,pi,3/2*pi,2*pi])
% yticks([0,pi/2,pi,3/2*pi,2*pi])
% xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% yticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% figure
% mesh(X,Y,squeeze(BS(11,2,:,:)))
% T = title('$B_{y}$ von Sensor 11','fontsize',18);
% set(T,'Interpreter','latex')
% T = xlabel('$\theta_{1}$','fontsize',18);
% set(T,'Interpreter','latex')
% T = ylabel('$\theta_{2}$','fontsize',18);
% set(T,'Interpreter','latex')
% xticks([0,pi/2,pi,3/2*pi,2*pi])
% yticks([0,pi/2,pi,3/2*pi,2*pi])
% xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% yticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% figure
% mesh(X,Y,squeeze(BS(11,3,:,:)))
% T = title('$B_{z}$ von Sensor 11','fontsize',18);
% set(T,'Interpreter','latex')
% T = xlabel('$\theta_{1}$','fontsize',18);
% set(T,'Interpreter','latex')
% T = ylabel('$\theta_{2}$','fontsize',18);
% set(T,'Interpreter','latex')
% xticks([0,pi/2,pi,3/2*pi,2*pi])
% yticks([0,pi/2,pi,3/2*pi,2*pi])
% xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% yticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% figure
% mesh(X,Y,squeeze(BS(21,1,:,:)))
% T = title('$B_{x}$ von Sensor 21','fontsize',18);
% set(T,'Interpreter','latex')
% T = xlabel('$\theta_{1}$','fontsize',18);
% set(T,'Interpreter','latex')
% T = ylabel('$\theta_{2}$','fontsize',18);
% set(T,'Interpreter','latex')
% xticks([0,pi/2,pi,3/2*pi,2*pi])
% yticks([0,pi/2,pi,3/2*pi,2*pi])
% xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% yticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% figure
% mesh(X,Y,squeeze(BS(21,2,:,:)))
% T = title('$B_{y}$ von Sensor 21','fontsize',18);
% set(T,'Interpreter','latex')
% T = xlabel('$\theta_{1}$','fontsize',18);
% set(T,'Interpreter','latex')
% T = ylabel('$\theta_{2}$','fontsize',18);
% set(T,'Interpreter','latex')
% xticks([0,pi/2,pi,3/2*pi,2*pi])
% yticks([0,pi/2,pi,3/2*pi,2*pi])
% xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% yticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% figure
% mesh(X,Y,squeeze(BS(21,3,:,:)))
% T = title('$B_{z}$ von Sensor 21','fontsize',18);
% set(T,'Interpreter','latex')
% T = xlabel('$\theta_{1}$','fontsize',18);
% set(T,'Interpreter','latex')
% T = ylabel('$\theta_{2}$','fontsize',18);
% set(T,'Interpreter','latex')
% xticks([0,pi/2,pi,3/2*pi,2*pi])
% yticks([0,pi/2,pi,3/2*pi,2*pi])
% xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% yticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
% 

%max. detected signal
Bd = zeros(Sensornumber^2,1);
for i = 1 : Sensornumber^2
    Bd(i) = max(max(max(squeeze(BS(i,:,:,:)))));
end


% D1 are the area that out of the range
D1 = zeros(length(q2),length(q3));

for i = 1 : length(q2)
    for j = 1 : length(q3)
        if Bm(i,j) > Sensordata(3)
            D1(i,j) = 0;
        else
            D1(i,j) = NaN;
        end
    end
end


D2 = NaN(length(q2),length(q3));
% D2 is the area smaller than the resolution
a = 1/1000;  % detectable position change in m
for i = 1: size(GBm,1)
    for j = 1: size(GBm,2)
        if sqrt(GBm(i,j,1)^2+GBm(i,j,2)^2) < 5 / a / 2^k / Sensordata(4)
            D2(i,j) = 0;
        else
            D2(i,j) = NaN;
        end
    end
end

D = zeros(length(q2),length(q3));
for i = 1 : length(q2)
    for j = 1 : length(q3)
        if D1(i,j)==0 ||  D2(i,j)==0
            D(i,j) = 0;
        else
            D(i,j) = NaN;
        end
    end
end
% [X,Y] = meshgrid(q2,q3);
% mesh(X,Y,D')
% T = title('not detectable area','fontsize',18);
% set(T,'Interpreter','latex')
% T = xlabel('$q_{2}$','fontsize',18);
% set(T,'Interpreter','latex')
% T = ylabel('$q_{3}$','fontsize',18);
% set(T,'Interpreter','latex')
% axis equal










C = [0.03,0.02,0.005,pi/3,pi/4];
SV = zeros(Sensornumber^2,1);
O = zeros(Sensornumber^2,1);
for s = 1:Sensornumber^2
    [rcs, thetak]= Coordinatentransform(C,Sensorw(:,s));
    [ByV,BzV] = itplt(rcs(2,2),rcs(2,3),q2,q3,By,Bz,H,B,n);
    [BxS, ByS, BzS] = inversetransform(C(3),C(4),thetak,ByV,BzV);
    [SV(s), O(s)] = Noising(ByS,Sensordata);
end








