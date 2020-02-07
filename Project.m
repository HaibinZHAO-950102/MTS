clc
clear
decroator = 1;     % Decorator. 1 is activited, 0 is deactivited
figureplot = 1;    % Plot and Mesh. 1 is activited, 0 is deactivited, 2 means to output the figure as png-file


% Workspace
W = [0.1,0.1,0.05];      %Size of the Workspaces in Meter m

% Magnet
Magnet_radius = 0.009;              % Radius of the Magnet in Meter m
Magnet_altitude = 0.005;            % Altitude of the Magnet in Meter m
Magnet_remanenz = 1.48;             % Magnetic Remanenz in T
Nodenumber = 500;                   % Number of the Nodes
Area_Width = 0.15;
Area_Length = 2 * Area_Width;       % Width and Length of the calculated area
mu0 = 4*pi*10^-7;

% Hardwares
Sensor_data = [2, 4, 500, 5/1000];          % Drift, Zerovoltage, Range, Sensitivity
Sensor_number = 5;                          % number of sensors on each edge
ADC_bit = 16;                                    % AD Converter bit

% Movement of Magnet
max_movespeed = 1;          % maximal velocity of magnet
max_rotatespeed = pi;         % maximal rotation speed of magnet


%Calculate the Magnetic Field Distribution
% Decroator('Calculating Magetic Field Strength ...',decroator);
% [MFS_y,MFS_z,Coordinate_q2,coordinate_q3] = Magnetfield(Magnet_radius,Magnet_altitude,Magnet_remanenz,Area_Width,Area_Length,Nodenumber,'main',1);            % last parameter 1 = write excel file, 0 = do not write

Decroator('Reading Magnetic Field Strength ...',decroator);
MFS_y = xlsread('Hy_main.xlsx');
MFS_z = xlsread('Hz_main.xlsx');
Coordinate_q2 = xlsread('q2_main.xlsx');
Coordinate_q3 = xlsread('q3_main.xlsx');
MFS_value = sqrt(MFS_y.^2+MFS_z.^2);

% MFS into MFD in Gauss
Decroator('Converting MFS into Magnetic Flux Density ...',decroator);
MFD_y = MFS_y * mu0 * 10000;
MFD_z = MFS_z * mu0 * 10000;
MFD_value = MFS_value * mu0 * 10000;
mesh3D(Coordinate_q2,Coordinate_q3,MFD_y,'$q_{2}$','$q_{3}$','MFD','MFD in $\vec{i}_{2}$ Richtung','MFD_i2',figureplot);
mesh3D(Coordinate_q2,Coordinate_q3,MFD_z,'$q_{2}$','$q_{3}$','MFD','MFD in $\vec{i}_{3}$ Richtung','MFD_i3',figureplot);
mesh3D(Coordinate_q2,Coordinate_q3,MFD_value,'$q_{2}$','$q_{3}$','MFD','MFD','MFD',figureplot)

% Grandient
Decroator('Calculating Gradient of MFD ...',decroator);
MFDGradient_value = grad(MFD_value,Coordinate_q2,Coordinate_q3);
MFDGradient_y = grad(MFD_y,Coordinate_q2,Coordinate_q3);
MFDGradient_z = grad(MFD_z,Coordinate_q2,Coordinate_q3);
mesh3D(Coordinate_q2(1:end-1),Coordinate_q3(1:end-1),MFDGradient_value(:,:,1),'$q_{2}$','$q_{3}$','$G_{m,y}$','Gradient $\frac{\partial{B_{m}}}{\partial{q_{2}}}$','Gradien_m_i2',figureplot);
mesh3D(Coordinate_q2(1:end-1),Coordinate_q3(1:end-1),MFDGradient_value(:,:,2),'$q_{2}$','$q_{3}$','$G_{m,z}$','Gradient $\frac{\partial{B_{m}}}{\partial{q_{3}}}$','Gradien_m_i3',figureplot);
mesh3D(Coordinate_q2(1:end-1),Coordinate_q3(1:end-1),MFDGradient_y(:,:,1),'$q_{2}$','$q_{3}$','$G_{y,y}$','Gradient $\frac{\partial{B_{y}}}{\partial{q_{2}}}$','Gradien_y_i2',figureplot);
mesh3D(Coordinate_q2(1:end-1),Coordinate_q3(1:end-1),MFDGradient_y(:,:,2),'$q_{2}$','$q_{3}$','$G_{y,z}$','Gradient $\frac{\partial{B_{y}}}{\partial{q_{3}}}$','Gradien_y_i3',figureplot);
mesh3D(Coordinate_q2(1:end-1),Coordinate_q3(1:end-1),MFDGradient_z(:,:,1),'$q_{2}$','$q_{3}$','$G_{z,y}$','Gradient $\frac{\partial{B_{z}}}{\partial{q_{2}}}$','Gradien_z_i2',figureplot);
mesh3D(Coordinate_q2(1:end-1),Coordinate_q3(1:end-1),MFDGradient_z(:,:,2),'$q_{2}$','$q_{3}$','$G_{z,z}$','Gradient $\frac{\partial{B_{z}}}{\partial{q_{3}}}$','Gradien_z_i3',figureplot);

% Sensor positions in global-coordinaten
Decroator('Calculating Sensor Positions ...',decroator);
Sensorposition_w = sensorposition(W(1),Sensor_number);
plotsensorposition(Sensorposition_w(1,:),Sensorposition_w(2,:),'$\vec{w_{1}}$','$\vec{w_{2}}$','Sensorpositionen',figureplot);

% Detected Signal at Sensors
Orientation = [-0.049,-0.049,0.049,0,0];                   % Magnet Orientation
test_node = 360;
MFD_at_Sensor = zeros(Sensor_number^2,3,test_node,test_node);
THETA1 = 0:1/test_node*2*pi:2*pi-1/test_node*2*pi;
THETA2 = THETA1;
for s = 1:Sensor_number^2                         % s is sensor index
    Decroator(['Calculating Detected Signal at Sensor ',num2str(s),' ...'],decroator);
    for i = 1:test_node
        for j = 1:test_node
            theta1 = (i-1)/test_node*2*pi;
            theta2 = (j-1)/test_node*2*pi;
            Orientation(4:5) = [theta1 theta2];
            [r_cs, theta_k]= coordinatew2i(Orientation,Sensorposition_w(:,s));
            [MFD_y_Vglpunkt,MFD_z_Vglpunkt] = itplt(r_cs(2,2),r_cs(2,3),Coordinate_q2,Coordinate_q3,MFD_y,MFD_z,Area_Length,Area_Width,Nodenumber);
            [MFD_at_Sensor_x, MFD_at_Sensor_y, MFD_at_Sensor_z] = coordinatei2w(Orientation(3),Orientation(4),theta_k,MFD_y_Vglpunkt,MFD_z_Vglpunkt);
            MFD_at_Sensor(s,1,i,j) = MFD_at_Sensor_x;
            MFD_at_Sensor(s,2,i,j) = MFD_at_Sensor_y;
            MFD_at_Sensor(s,3,i,j) = MFD_at_Sensor_z;
        end
    end
    direction = ['x','y','z'];
    for p = 1 : 3
        TITLE = ['MFD $B_{',direction(p),'}$ von Sensor ',num2str(s)];
        filename = ['MFD_B_',num2str(s),'_',direction];
        mesh3D(THETA1,THETA2,squeeze(MFD_at_Sensor(s,p,:,:)),'$\theta_{1}$','$\theta_{2}$','B',TITLE,filename,figureplot);
    end
end

% Detectable Area
Decroator('Calculating Detectable Area under different Sensor Data ...',decroator);
ADC_BIT = [12,14,16,18,20];                         % ADC bit
Detectable_area = NaN(length(ADC_BIT),length(Coordinate_q2),length(Coordinate_q3));
Detectable_movement = NaN(length(ADC_BIT),length(Coordinate_q2),length(Coordinate_q3));
for i = 1:length(ADC_BIT)
    Detectable_area(i,:,:) = detectablearea(Coordinate_q2,Coordinate_q3,Sensor_data,ADC_BIT(i),MFD_value,MFDGradient_value);
    Detectable_movement(i,:,:) = detectmovement(Coordinate_q2,Coordinate_q3,Sensor_data,ADC_BIT(i),MFDGradient_value);
    Detectable_points = area2points(Coordinate_q2(1:end-1),Coordinate_q3(2:end-1),squeeze(Detectable_area(i,1:end-1,2:end-1)));
    name1 = ['Detektiertbarer Bereich mit ',num2str(ADC_BIT(i)),' bit'];
    plotarea(Detectable_points(:,1),Detectable_points(:,2),'$q_{2}$','$q_{3}$',name1,figureplot);
    name2 = ['Detektiertbare Bewegung mit ',num2str(ADC_BIT(i)),' bit'];
    mesh3D(Coordinate_q2(1:end-1),Coordinate_q3(2:end-1),squeeze(Detectable_movement(i,1:end-1,2:end-1)),'$q_{2}$','$q_{3}$','Bewegung',name2,name2,figureplot);
end



% Localization Process
Experimenttimes = 1000;
% Decroator('Generating Random Test Points ...',decroator)
% Orientation_Given = zeros(Experimenttimes,5);        % test points
% MFD_Given = zeros(25,Experimenttimes);       % MFD of test points at every sensor
% for i = 1 : Experimenttimes
%     [Orientation_given, MFD_given] = randpoint(Sensorposition_w,Sensornumber,Coordinate_q2,Coordinate_q3,MFD_y,MFD_z,Area_Length,Area_Width,Nodenumber);
%     Orientation_Given(i,:) = Orientation_given;
%     MFD_Given(:,i) = MFD_given;
% end
% xlswrite('testpoints.xlsx',[Orientation_Given,MFD_Given']);

Decroator('Reading Random Test Points ....',decroator);
Test_Points = xlsread('testpoints.xlsx');
Orientation_Given = Test_Points(:,1:5);
MFD_Given = Test_Points(:,6:30)';

plottestpoints(Orientation_Given(:,1),Orientation_Given(:,2),Orientation_Given(:,3),'$w_{1}$','$w_{2}$','$w_{3}$','Test Points',figureplot);

Test_Data = [2, 4, 500, 5/1000, 16;2, 4, 500, 5/1000, 12;2, 4, 500, 5/1000, 14;...
            2, 4, 500, 5/1000, 18;2, 4, 500, 5/1000, 20;0.5, 4, 500, 5/1000, 16;...
            1, 4, 500, 5/1000, 16;4, 4, 500, 5/1000, 16;8, 4, 500, 5/1000, 16;...
            2, 4, 500, 1/1000, 16;2, 4, 500, 2/1000, 16;2, 4, 500, 10/1000, 16;...
            2, 4, 500, 20/1000, 20;1, 4, 500, 5/1000, 18;0.5, 4, 500, 10/1000, 20;...
            0, 4, 500, 100/1000, 50];
% data(1:4)=Sensordata, data(5) = k (ADC bit)

% do experiments under different sensordaten and write them in excel-tables
for i = 16 : size(Test_Data,1)
    data = Test_Data(i,:);
    name = ['Ex_',num2str(i-1)];
    experiment(name, data, Experimenttimes, Sensorposition_w,Sensornumber,Coordinate_q2,Coordinate_q3,MFD_y,MFD_z,Area_Length,Area_Width,Nodenumber,max_movespeed,max_rotatespeed,Orientation_Given,MFD_Given);
end

% analyse the results
Decroator('Analysing Results ....',decroator);
exresult = zeros(size(Test_Data,1),Experimenttimes,12);
Error = zeros(Experimenttimes,size(Test_Data,1));
for i = 1 : size(Test_Data,1)
    name = ['Ex_',num2str(i-1),'.xlsx'];
    readdata = xlsread(name);
    exresult(i,:,:) = readdata(2:end,:);
    Error(:,i) = exresult(i,:,11)';
end
inner1mm = zeros(size(Test_Data,1),1);
meanerror = zeros(size(Test_Data,1),1);
for i = 1 : size(Test_Data,1)
    for j = 1 : Experimenttimes
        if Error(j,i) < 1
            inner1mm(i) = inner1mm(i) + 1;
        end
    end
    meanerror(i) = mean(Error(:,i));
end
xlswrite('analysis.xlsx',[inner1mm,meanerror]);


combineresult = squeeze(exresult(1,:,:));
combineerror = Error(:,1);
for i = 2 : size(Test_Data,1)
    combineresult = [combineresult;squeeze(exresult(i,:,:))];
    combineerror = [combineerror;Error(:,i);];
end
w1 = combineresult(:,1);
w2 = combineresult(:,2);
w3 = combineresult(:,3);
plotpoints(w1,combineerror,'$\vec{w_{1}}$','Fehler','Fehler - $\vec{w_{1}}$',figureplot);
plotpoints(w2,combineerror,'$\vec{w_{2}}$','Fehler','Fehler - $\vec{w_{2}}$',figureplot);
plotpoints(w3,combineerror,'$\vec{w_{3}}$','Fehler','Fehler - $\vec{w_{3}}$',figureplot);
meshpoints(w1,w2,combineerror,-0.05,0.05,-0.05,0.05,'$\vec{w_{1}}$','$\vec{w_{2}}$','Fehler','Fehler - $\vec{w_{1}}$ - $\vec{w_{2}}$',figureplot)


Decroator('Programm finished.',decroator);




















