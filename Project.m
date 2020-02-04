clc;clear

W = [0.1,0.1,0.05];   %Size of the Workspaces in Meter m

Ra = 0.009;     % Radius of the Magnet in Meter m
L = 0.005;      % Altitude of the Magnet in Meter m
Br = 1.48;      % Magnetic Remanenz in T
Nodenumber = 500;        % Number of the Nodes
B = 0.15;
H = 2 * B;      % Width and Length of the calculated area
mu0 = 4*pi*10^-7;
Sensordata = [2, 4, 500, 5/1000]; % Error, Zerovoltage, Range, Sensitivity
Sensornumber = 5; % number of sensors on each edge
k = 16;            % AD Converter bit
vmax = 1;          % maximal velocity of magnet
rmax = pi;         % maximal rotation speed of magnet


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
% mesh3D(q2,q3,By,'$q_{2}$','$q_{3}$','MFD in $\vec{i}_{2}$ Richtung')
% mesh3D(q2,q3,Bz,'$q_{2}$','$q_{3}$','MFD in $\vec{i}_{3}$ Richtung')
% mesh3D(q2,q3,Bm,'$q_{2}$','$q_{3}$','MFD')


% Grandient
GBm = grad(Bm,q2,q3);
GBy = grad(By,q2,q3);
GBz = grad(Bz,q2,q3);
% mesh3D(q2(1:end-1),q3(1:end-1),GBm(:,:,1),'$q_{2}$','$q_{3}$','$\frac{\partial{B_{m}}}{\partial{q_{2}}}$')
% mesh3D(q2(1:end-1),q3(1:end-1),GBm(:,:,2),'$q_{2}$','$q_{3}$','$\frac{\partial{B_{m}}}{\partial{q_{3}}}$')
% mesh3D(q2(1:end-1),q3(1:end-1),GBy(:,:,1),'$q_{2}$','$q_{3}$','$\frac{\partial{B_{y}}}{\partial{q_{2}}}$')
% mesh3D(q2(1:end-1),q3(1:end-1),GBy(:,:,2),'$q_{2}$','$q_{3}$','$\frac{\partial{B_{y}}}{\partial{q_{3}}}$')
% mesh3D(q2(1:end-1),q3(1:end-1),GBz(:,:,1),'$q_{2}$','$q_{3}$','$\frac{\partial{B_{z}}}{\partial{q_{2}}}$')
% mesh3D(q2(1:end-1),q3(1:end-1),GBz(:,:,2),'$q_{2}$','$q_{3}$','$\frac{\partial{B_{z}}}{\partial{q_{3}}}$')


Sensorw = sensorposition(W(1),Sensornumber);            % Sensor positions in global-coordinaten
% plotsensorposition(Sensorw,'$\vec{w_{2}}$','$\vec{w_{3}}$','Sensorpositionen')

c1 = -0.049;
c2 = -0.049;
c3 = 0.049;           % Magnet position
node = 360;
BS = zeros(Sensornumber^2,3,node,node);
for s = 1:Sensornumber^2         % sensor index
    for i = 1:node
        for j = 1:node
            theta1 = (i-1)/node*2*pi;
            theta2 = (j-1)/node*2*pi;
            C = [c1,c2,c3,theta1,theta2];
            [rcs, thetak]= coordinatew2i(C,Sensorw(:,s));
            [ByV,BzV] = itplt(rcs(2,2),rcs(2,3),q2,q3,By,Bz,H,B,Nodenumber);
            [BxS, ByS, BzS] = coordinatei2w(C(3),C(4),thetak,ByV,BzV);
            BS(s,1,i,j) = BxS;
            BS(s,2,i,j) = ByS;
            BS(s,3,i,j) = BzS;
        end
    end
end
% theta1 = 0:1/node*2*pi:2*pi-1/node*2*pi;
% theta2 = theta1;
% mesh3D(theta1,theta2,squeeze(BS(5,1,:,:)),'$\theta_{1}$','$\theta_{2}$','$B_{x}$ von Sensor 5')
% mesh3D(theta1,theta2,squeeze(BS(5,2,:,:)),'$\theta_{1}$','$\theta_{2}$','$B_{y}$ von Sensor 5')
% mesh3D(theta1,theta2,squeeze(BS(5,3,:,:)),'$\theta_{1}$','$\theta_{2}$','$B_{z}$ von Sensor 5')
% mesh3D(theta1,theta2,squeeze(BS(11,1,:,:)),'$\theta_{1}$','$\theta_{2}$','$B_{x}$ von Sensor 11')
% mesh3D(theta1,theta2,squeeze(BS(11,2,:,:)),'$\theta_{1}$','$\theta_{2}$','$B_{y}$ von Sensor 11')
% mesh3D(theta1,theta2,squeeze(BS(11,3,:,:)),'$\theta_{1}$','$\theta_{2}$','$B_{z}$ von Sensor 11')
% mesh3D(theta1,theta2,squeeze(BS(21,1,:,:)),'$\theta_{1}$','$\theta_{2}$','$B_{x}$ von Sensor 21')
% mesh3D(theta1,theta2,squeeze(BS(21,2,:,:)),'$\theta_{1}$','$\theta_{2}$','$B_{y}$ von Sensor 21')
% mesh3D(theta1,theta2,squeeze(BS(21,3,:,:)),'$\theta_{1}$','$\theta_{2}$','$B_{z}$ von Sensor 21')

% Detectable Area
BIT = [12,14,16,18,20];
D = NaN(length(BIT),length(q2),length(q3));
for i = 1:length(BIT)
    D(i,:,:) = detectablearea(q2,q3,Sensordata,BIT(i),Bm,GBm);
end
% plotarea(q2,q3,squeeze(D(1,:,:)),'$q_{2}$','$q_{3}$','Detektiertbarer Bereich mit 12 bit')
% plotarea(q2,q3,squeeze(D(2,:,:)),'$q_{2}$','$q_{3}$','Detektiertbarer Bereich mit 14 bit')
% plotarea(q2,q3,squeeze(D(3,:,:)),'$q_{2}$','$q_{3}$','Detektiertbarer Bereich mit 16 bit')
% plotarea(q2,q3,squeeze(D(4,:,:)),'$q_{2}$','$q_{3}$','Detektiertbarer Bereich mit 18 bit')
% plotarea(q2,q3,squeeze(D(5,:,:)),'$q_{2}$','$q_{3}$','Detektiertbarer Bereich mit 20 bit')




experimenttimes = 1000;
% OG = zeros(experimenttimes,5);
% BG = zeros(25,experimenttimes);
% for i = 1 : experimenttimes
%     [Og, Bg] = randpoint(Sensorw,Sensornumber,q2,q3,By,Bz,H,B,Nodenumber);
%     OG(i,:) = Og;
%     BG(:,i) = Bg;
% end
% xlswrite('testpoints.xlsx',[OG,BG']);
testpoints = xlsread('testpoints.xlsx');
OG1 = testpoints(:,1:5);
BG1 = testpoints(:,6:30)';

testdata = [2, 4, 500, 5/1000, 16;...
            2, 4, 500, 5/1000, 12;...
            2, 4, 500, 5/1000, 14;...
            2, 4, 500, 5/1000, 18;...
            2, 4, 500, 5/1000, 20;...
            0.5, 4, 500, 5/1000, 16;...
            1, 4, 500, 5/1000, 16;...
            4, 4, 500, 5/1000, 16;...
            8, 4, 500, 5/1000, 16;...
            2, 4, 500, 1/1000, 16;...
            2, 4, 500, 2/1000, 16;...
            2, 4, 500, 10/1000, 16;...
            2, 4, 500, 20/1000, 16];
% data(1:5)=Sensordata, data(5) = k (ADC bit)
for experiment = 2 : 13
    data = testdata(i,:);
    name = ['Ex_',num2str(i-1)];
    experiment(name, data(1:5), data(6), experimenttimes, Sensorw,Sensornumber,q2,q3,By,Bz,H,B,Nodenumber, vmax, rmax, OG, BG);
end