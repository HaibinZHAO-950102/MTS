clc
clear

% Workspace
W = [0.1,0.1,0.05];      %Size of the Workspaces in Meter m

% Magnet
Ra = 0.009;              % Radius of the Magnet in Meter m
L = 0.005;               % Altitude of the Magnet in Meter m
Br = 1.48;               % Magnetic Remanenz in T
Nodenumber = 500;        % Number of the Nodes
B = 0.15;
H = 2 * B;               % Width and Length of the calculated area
mu0 = 4*pi*10^-7;

% Hardwares
Sensordata = [2, 4, 500, 5/1000];          % Error, Zerovoltage, Range, Sensitivity
Sensornumber = 5;                          % number of sensors on each edge
k = 16;                                    % AD Converter bit

% Movement of Magnet
vmax = 1;          % maximal velocity of magnet
rmax = pi;         % maximal rotation speed of magnet

decroator = 1;     % 1 is activited, 0 is deactivited
figureplot = 1;    % 1 is activited, 0 is deactivited

%Calculate the Magnetic Field Distribution
% Decroator('Calculating Magetic Field Strength ...',decroator);
% [Hy,Hz,q2,q3] = Magnetfield(Ra,L,Br,B,H,n);

Decroator('Reading Magnetic Field Strength...',decroator);
Hy = xlsread('Hy.xlsx');
Hz = xlsread('Hz.xlsx');
q2 = xlsread('q2.xlsx');
q3 = xlsread('q3.xlsx');
Hm = sqrt(Hy.^2+Hz.^2);

% MFS into MFD in Gauss
Decroator('Converting MFS into Magnetic Flux Density ...',decroator);
By = Hy * mu0 * 10000;
Bz = Hz * mu0 * 10000;
Bm = Hm * mu0 * 10000;
mesh3D(q2,q3,By,'$q_{2}$','$q_{3}$','MFD in $\vec{i}_{2}$ Richtung',figureplot);
mesh3D(q2,q3,Bz,'$q_{2}$','$q_{3}$','MFD in $\vec{i}_{3}$ Richtung',figureplot);
mesh3D(q2,q3,Bm,'$q_{2}$','$q_{3}$','MFD',figureplot)

% Grandient
Decroator('Calculating Gradient of MFD ...',decroator);
GBm = grad(Bm,q2,q3);
GBy = grad(By,q2,q3);
GBz = grad(Bz,q2,q3);
mesh3D(q2(1:end-1),q3(1:end-1),GBm(:,:,1),'$q_{2}$','$q_{3}$','$\frac{\partial{B_{m}}}{\partial{q_{2}}}$',figureplot);
mesh3D(q2(1:end-1),q3(1:end-1),GBm(:,:,2),'$q_{2}$','$q_{3}$','$\frac{\partial{B_{m}}}{\partial{q_{3}}}$',figureplot);
mesh3D(q2(1:end-1),q3(1:end-1),GBy(:,:,1),'$q_{2}$','$q_{3}$','$\frac{\partial{B_{y}}}{\partial{q_{2}}}$',figureplot);
mesh3D(q2(1:end-1),q3(1:end-1),GBy(:,:,2),'$q_{2}$','$q_{3}$','$\frac{\partial{B_{y}}}{\partial{q_{3}}}$',figureplot);
mesh3D(q2(1:end-1),q3(1:end-1),GBz(:,:,1),'$q_{2}$','$q_{3}$','$\frac{\partial{B_{z}}}{\partial{q_{2}}}$',figureplot);
mesh3D(q2(1:end-1),q3(1:end-1),GBz(:,:,2),'$q_{2}$','$q_{3}$','$\frac{\partial{B_{z}}}{\partial{q_{3}}}$',figureplot);

% Sensor positions in global-coordinaten
Decroator('Calculating Sensor Positions ...',decroator);
Sensorw = sensorposition(W(1),Sensornumber);
plotsensorposition(Sensorw,'$\vec{w_{2}}$','$\vec{w_{3}}$','Sensorpositionen',figureplot);

% Detected Signal at Sensors
C = [-0.049,-0.049,0.049,0,0];                   % Magnet position
node = 360;
BS = zeros(Sensornumber^2,3,node,node);
THETA1 = 0:1/node*2*pi:2*pi-1/node*2*pi;
THETA2 = THETA1;
for s = 1:Sensornumber^2                         % s is sensor index
    Decroator(['Calculating Detected Signal at Sensor ',num2str(s),' ...'],decroator);
    for i = 1:node
        for j = 1:node
            theta1 = (i-1)/node*2*pi;
            theta2 = (j-1)/node*2*pi;
            C(4:5) = [theta1 theta2];
            [rcs, thetak]= coordinatew2i(C,Sensorw(:,s));
            [ByV,BzV] = itplt(rcs(2,2),rcs(2,3),q2,q3,By,Bz,H,B,Nodenumber);
            [BxS, ByS, BzS] = coordinatei2w(C(3),C(4),thetak,ByV,BzV);
            BS(s,1,i,j) = BxS;
            BS(s,2,i,j) = ByS;
            BS(s,3,i,j) = BzS;
        end
    end
    for p = 1 : 3
        if p == 1
            direction = 'x';
        elseif p == 2
            direction = 'y';
        else
            direction = 'z';
        end
        TITLE = ['$B_{',direction,'}$ von Sensor',num2str(s)];
        mesh3D(THETA1,THETA2,squeeze(BS(s,p,:,:)),'$\theta_{1}$','$\theta_{2}$',TITLE,figureplot);
    end
end

% Detectable Area
Decroator('Calculating Detectable Area under different Sensor Data ...',decroator);
BIT = [12,14,16,18,20];                         % ADC bit
D = NaN(length(BIT),length(q2),length(q3));
for i = 1:length(BIT)
    D(i,:,:) = detectablearea(q2,q3,Sensordata,BIT(i),Bm,GBm);
end
plotarea(q2,q3,squeeze(D(1,:,:)),'$q_{2}$','$q_{3}$','Detektiertbarer Bereich mit 12 bit',figureplot);
plotarea(q2,q3,squeeze(D(2,:,:)),'$q_{2}$','$q_{3}$','Detektiertbarer Bereich mit 14 bit',figureplot);
plotarea(q2,q3,squeeze(D(3,:,:)),'$q_{2}$','$q_{3}$','Detektiertbarer Bereich mit 16 bit',figureplot);
plotarea(q2,q3,squeeze(D(4,:,:)),'$q_{2}$','$q_{3}$','Detektiertbarer Bereich mit 18 bit',figureplot);
plotarea(q2,q3,squeeze(D(5,:,:)),'$q_{2}$','$q_{3}$','Detektiertbarer Bereich mit 20 bit',figureplot);

% Localization Process

experimenttimes = 20;

% Decroator('Generating Random Test Points ...',decroator)
% OG = zeros(experimenttimes,5);        % test points
% BG = zeros(25,experimenttimes);       % MFD of test points at every sensor
% for i = 1 : experimenttimes
%     [Og, Bg] = randpoint(Sensorw,Sensornumber,q2,q3,By,Bz,H,B,Nodenumber);
%     OG(i,:) = Og;
%     BG(:,i) = Bg;
% end
% xlswrite('testpoints.xlsx',[OG,BG']);

Decroator('Reading Random Test Points ....',decroator);
testpoints = xlsread('testpoints.xlsx');
OG = testpoints(:,1:5);
BG = testpoints(:,6:30)';

testdata = [2, 4, 500, 5/1000, 16;2, 4, 500, 5/1000, 12;2, 4, 500, 5/1000, 14;...
            2, 4, 500, 5/1000, 18;2, 4, 500, 5/1000, 20;0.5, 4, 500, 5/1000, 16;...
            1, 4, 500, 5/1000, 16;4, 4, 500, 5/1000, 16;8, 4, 500, 5/1000, 16;...
            2, 4, 500, 1/1000, 16;2, 4, 500, 2/1000, 16;2, 4, 500, 10/1000, 16;...
            2, 4, 500, 20/1000, 20;1, 4, 500, 5/1000, 18;0.5, 4, 500, 10/1000, 20];
% data(1:4)=Sensordata, data(5) = k (ADC bit)

% do experiments under different sensordaten and write them in excel-tables
for i = 1 : size(testdata,1)
    data = testdata(i,:);
    name = ['Ex_',num2str(i-1)];
    experiment(name, data, experimenttimes, Sensorw,Sensornumber,q2,q3,By,Bz,H,B,Nodenumber, vmax, rmax, OG, BG);
end

% analyse the results
Decroator('Analysing Results ....',decroator);
exresult = zeros(size(testdata,1),experimenttimes,12);
Error = zeros(experimenttimes,size(testdata,1));
for i = 1 : size(testdata,1)
    name = ['Ex_',num2str(i-1),'.xlsx'];
    readdata = xlsread(name);
    exresult(i,:,:) = readdata(2:end,:);
    Error(:,i) = exresult(i,:,11)';
end
inner1mm = zeros(size(testdata,1),1);
meanerror = zeros(size(testdata,1),1);
for i = 1 : size(testdata,1)
    for j = 1 : experimenttimes
        if Error(j,i) < 1
            inner1mm(i) = inner1mm(i) + 1;
        end
    end
    meanerror(i) = mean(Error(:,i));
end
xlswrite('analysis.xlsx',[inner1mm,meanerror]);


Decroator('Programm finished.',decroator);



















