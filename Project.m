clc
clear
decroator = 1;     % Decorator. 1 is activited, 0 is deactivited
figureplot = 0;    % Plot and Mesh. 1 is activited, 0 is deactivited, 2 means to output the figure as png-file


% Workspace
W = [0.1,0.1,0.05];      %Size of the Workspaces in Meter m


% Magnet
Magnet_radius = 0.009;              % Radius of the Magnet in Meter m
Magnet_altitude = 0.005;            % Altitude of the Magnet in Meter m
Magnet_remanenz = 1.48;             % Magnetic Remanenz in T
Node_Number = 500;                   % Number of the Nodes
Area_Width = 0.15;
Area_Length = 2 * Area_Width;       % Width and Length of the calculated area
mu0 = 4*pi*10^-7;


% Hardwares
Sensor_data = [2, 4, 500, 5/1000];          % Drift, Zerovoltage, Range, Sensitivity
Sensor_number = 5;                          % number of sensors on each edge
ADC_bit = 16;  
% AD Converter bit
% test_data for sensors
Test_Data = [2, 4, 500, 5/1000, 16;2, 4, 500, 5/1000, 12;2, 4, 500, 5/1000, 14;...
            2, 4, 500, 5/1000, 18;2, 4, 500, 5/1000, 20;0.5, 4, 500, 5/1000, 16;...
            1, 4, 500, 5/1000, 16;4, 4, 500, 5/1000, 16;8, 4, 500, 5/1000, 16;...
            2, 4, 500, 1/1000, 16;2, 4, 500, 2/1000, 16;2, 4, 500, 10/1000, 16;...
            2, 4, 500, 20/1000, 20;1, 4, 500, 5/1000, 18;0.5, 4, 500, 10/1000, 20;...
            0, 4, 500, 100/1000, 50];
% data(1:4)=Sensordata, data(5) = k (ADC bit)


% Movement of Magnet
max_movespeed = 1;          % maximal velocity of magnet
max_rotatespeed = pi;         % maximal rotation speed of magnet


% Calculate the Magnetic Field Distribution
% Decroator('Calculating Magetic Field Strength ...',decroator);
% [MFS_y,MFS_z,Coordinate_q2,coordinate_q3] = Magnetfield(Magnet_radius,Magnet_altitude,Magnet_remanenz,Area_Width,Area_Length,Node_Number,'main',1);            
% last parameter 1 = write excel file, 0 = do not write


% reading MFS
Decroator('Reading Magnetic Field Strength ...',decroator);
MFS_y = xlsread('Hy_main.xlsx');
MFS_z = xlsread('Hz_main.xlsx');
Coordinate_q2 = xlsread('q2_main.xlsx');
Coordinate_q3 = xlsread('q3_main.xlsx');
MFS_y_show_flat = xlsread('Hy_show_flat.xlsx');
MFS_z_show_flat = xlsread('Hz_show_flat.xlsx');
MFS_y_show_long = xlsread('Hy_show_long.xlsx');
MFS_z_show_long = xlsread('Hz_show_long.xlsx');
Coordinate_q2_show = xlsread('q2_show.xlsx');
Coordinate_q3_show = xlsread('q3_show.xlsx');

MFS_value = sqrt(MFS_y.^2+MFS_z.^2);
MFS_value_show_flat = sqrt(MFS_y_show_flat.^2+MFS_z_show_flat.^2);
MFS_value_show_long = sqrt(MFS_y_show_long.^2+MFS_z_show_long.^2);


% MFS into MFD in Gauss
Decroator('Converting MFS into Magnetic Flux Density ...',decroator);
MFD_y = MFS_y * mu0 * 10000;
MFD_z = MFS_z * mu0 * 10000;
MFD_value = MFS_value * mu0 * 10000;
MFD_y_show_flat = MFS_y_show_flat * mu0 * 10000;
MFD_z_show_flat = MFS_z_show_flat * mu0 * 10000;
MFD_value_show_flat = MFS_value_show_flat * mu0 * 10000;
MFD_y_show_long = MFS_y_show_long * mu0 * 10000;
MFD_z_show_long = MFS_z_show_long * mu0 * 10000;
MFD_value_show_long = MFS_value_show_long * mu0 * 10000;
mesh3D(Coordinate_q2,Coordinate_q3,MFD_y,'$q_{2}$ (m)','$q_{3}$ (m)','MFD (Gauss)','MFD of the Magnet in $\vec{i}_{2}$ Direction','MFD_i2',figureplot);
mesh3D(Coordinate_q2,Coordinate_q3,MFD_z,'$q_{2}$ (m)','$q_{3}$ (m)','MFD (Gauss)','MFD of the Magnet in $\vec{i}_{3}$ Direction','MFD_i3',figureplot);
mesh3D(Coordinate_q2,Coordinate_q3,MFD_value,'$q_{2}$ (m)','$q_{3}$ (m)','MFD (Gauss)','MFD of the Magnet','MFD',figureplot)
mesh3D(Coordinate_q2_show,Coordinate_q3_show,MFD_y_show_flat,'$q_{2}$ (m)','$q_{3}$ (m)','MFD (Gauss)','MFD of the flat Magnet in $\vec{i}_{2}$ Direction','MFD_i2_flat',figureplot);
mesh3D(Coordinate_q2_show,Coordinate_q3_show,MFD_z_show_flat,'$q_{2}$ (m)','$q_{3}$ (m)','MFD (Gauss)','MFD of the flat Magnet in $\vec{i}_{3}$ Direction','MFD_i3_flat',figureplot);
mesh3D(Coordinate_q2_show,Coordinate_q3_show,MFD_value_show_flat,'$q_{2}$ (m)','$q_{3}$ (m)','MFD (Gauss)','MFD of the flat Magnet','MFD_flat',figureplot)
mesh3D(Coordinate_q2_show,Coordinate_q3_show,MFD_y_show_long,'$q_{2}$ (m)','$q_{3}$ (m)','MFD (Gauss)','MFD of the long Magnet in $\vec{i}_{2}$ Direction','MFD_i2_long',figureplot);
mesh3D(Coordinate_q2_show,Coordinate_q3_show,MFD_z_show_long,'$q_{2}$ (m)','$q_{3}$ (m)','MFD (Gauss)','MFD of the long Magnet in $\vec{i}_{3}$ Direction','MFD_i3_long',figureplot);
mesh3D(Coordinate_q2_show,Coordinate_q3_show,MFD_value_show_long,'$q_{2}$ (m)','$q_{3}$ (m)','MFD (Gauss)','MFD of the long Magnet','MFD_long',figureplot)


% Grandient
Decroator('Calculating Gradient of MFD ...',decroator);
MFD_Gradient_value = grad(MFD_value,Coordinate_q2,Coordinate_q3);
MFD_Gradient_y = grad(MFD_y,Coordinate_q2,Coordinate_q3);
MFD_Gradient_z = grad(MFD_z,Coordinate_q2,Coordinate_q3);
mesh3D(Coordinate_q2(1:end-1),Coordinate_q3(1:end-1),MFD_Gradient_value(:,:,1),'$q_{2}$ (m)','$q_{3}$ (m)','$G_{m,y}$ (Gauss/m)','Gradient $\frac{\partial{B_{m}}}{\partial{q_{2}}}$','Gradient_m_i2',figureplot);
mesh3D(Coordinate_q2(1:end-1),Coordinate_q3(1:end-1),MFD_Gradient_value(:,:,2),'$q_{2}$ (m)','$q_{3}$ (m)','$G_{m,z}$ (Gauss/m)','Gradient $\frac{\partial{B_{m}}}{\partial{q_{3}}}$','Gradient_m_i3',figureplot);
mesh3D(Coordinate_q2(1:end-1),Coordinate_q3(1:end-1),MFD_Gradient_y(:,:,1),'$q_{2}$ (m)','$q_{3}$ (m)','$G_{y,y}$ (Gauss/m)','Gradient $\frac{\partial{B_{y}}}{\partial{q_{2}}}$','Gradient_y_i2',figureplot);
mesh3D(Coordinate_q2(1:end-1),Coordinate_q3(1:end-1),MFD_Gradient_y(:,:,2),'$q_{2}$ (m)','$q_{3}$ (m)','$G_{y,z}$ (Gauss/m)','Gradient $\frac{\partial{B_{y}}}{\partial{q_{3}}}$','Gradient_y_i3',figureplot);
mesh3D(Coordinate_q2(1:end-1),Coordinate_q3(1:end-1),MFD_Gradient_z(:,:,1),'$q_{2}$ (m)','$q_{3}$ (m)','$G_{z,y}$ (Gauss/m)','Gradient $\frac{\partial{B_{z}}}{\partial{q_{2}}}$','Gradient_z_i2',figureplot);
mesh3D(Coordinate_q2(1:end-1),Coordinate_q3(1:end-1),MFD_Gradient_z(:,:,2),'$q_{2}$ (m)','$q_{3}$ (m)','$G_{z,z}$ (Gauss/m)','Gradient $\frac{\partial{B_{z}}}{\partial{q_{3}}}$','Gradient_z_i3',figureplot);


% Sensor positions in global-coordinaten
Decroator('Calculating Sensor Positions ...',decroator);
Sensorposition_w = sensorposition(W(1),Sensor_number);
plotsensorposition(Sensorposition_w(1,:),Sensorposition_w(2,:),'$\vec{w_{1}}$ (m)','$\vec{w_{2}}$ (m)','Sensor Positions',figureplot);



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
            [MFD_y_Vglpunkt,MFD_z_Vglpunkt] = itplt(r_cs(2,2),r_cs(2,3),Coordinate_q2,Coordinate_q3,MFD_y,MFD_z,Area_Length,Area_Width,Node_Number);
            [MFD_at_Sensor_x, MFD_at_Sensor_y, MFD_at_Sensor_z] = coordinatei2w(Orientation(3),Orientation(4),theta_k,MFD_y_Vglpunkt,MFD_z_Vglpunkt);
            MFD_at_Sensor(s,1,i,j) = MFD_at_Sensor_x;
            MFD_at_Sensor(s,2,i,j) = MFD_at_Sensor_y;
            MFD_at_Sensor(s,3,i,j) = MFD_at_Sensor_z;
        end
    end
    direction = ['x','y','z'];
    for p = 1 : 3
        TITLE = ['MFD $B_{',direction(p),'}$ of Sensor ',num2str(s)];
        filename = ['MFD_B_',num2str(s),'_',direction(p)];
        mesh3Ddetectedsignal(THETA1,THETA2,squeeze(MFD_at_Sensor(s,p,:,:)),'$\theta_{1}$','$\theta_{2}$','MFD (Gauss)',TITLE,filename,figureplot);
    end
end


% Detectable Area
Decroator('Calculating Detectable Area under different Sensor Data ...',decroator);
ADC_BIT = [12,14,16,18,20];                         % ADC bit
Detectable_area = NaN(length(ADC_BIT),length(Coordinate_q2),length(Coordinate_q3));
Detectable_movement = NaN(length(ADC_BIT),length(Coordinate_q2),length(Coordinate_q3));
for i = 1:length(ADC_BIT)
    Detectable_area(i,:,:) = detectablearea(Coordinate_q2,Coordinate_q3,Sensor_data,ADC_BIT(i),MFD_value,MFD_Gradient_value);
    Detectable_movement(i,:,:) = detectmovement(Coordinate_q2,Coordinate_q3,Sensor_data,ADC_BIT(i),MFD_Gradient_value);
    Detectable_points = area2points(Coordinate_q2(1:end-1),Coordinate_q3(2:end-1),squeeze(Detectable_area(i,1:end-1,2:end-1)));
    name1 = ['Detectable Area with ',num2str(ADC_BIT(i)),' bit ADC'];
    plotarea(Detectable_points(:,1),Detectable_points(:,2),'$q_{2}$ (m)','$q_{3}$ (m)',name1,figureplot);
    name2 = ['Detectable Movement with ',num2str(ADC_BIT(i)),' bit ADC'];
    mesh3D(Coordinate_q2(1:end-1),Coordinate_q3(2:end-1),squeeze(Detectable_movement(i,1:end-1,2:end-1)),'$q_{2}$ (m)','$q_{3}$ (m)','Movement (mm)',name2,name2,figureplot);
end



% Localization Process

% 1st experiment
Experimenttimes = 1000;
% Decroator('Generating Random Test Points ...',decroator)
% Orientation_Given = zeros(Experimenttimes,5);        % test points
% MFD_Given = zeros(25,Experimenttimes);       % MFD of test points at every sensor
% for i = 1 : Experimenttimes
%     [Orientation_given, MFD_given] = randpoint(Sensorposition_w,Sensor_number,Coordinate_q2,Coordinate_q3,MFD_y,MFD_z,Area_Length,Area_Width,Node_Number);
%     Orientation_Given(i,:) = Orientation_given;
%     MFD_Given(:,i) = MFD_given;
% end
% xlswrite('testpoints.xlsx',[Orientation_Given,MFD_Given']);

Decroator('Reading Random Test Points ....',decroator);
Test_Points = xlsread('testpoints.xlsx');
Orientation_Given = Test_Points(:,1:5);
MFD_Given = Test_Points(:,6:30)';

plottestpoints(Orientation_Given(:,1),Orientation_Given(:,2),Orientation_Given(:,3),'$\vec{w_{1}}$ (m)','$\vec{w_{2}}$ (m)','$\vec{w_{3}}$ (m)','Test Points 1','Test_Points_1',figureplot);

% do experiments under different sensordaten and write them in excel-tables
% for i = 1 : size(Test_Data,1)
%     data = Test_Data(i,:);
%     name = ['Ex_',num2str(i-1)];
%     experiment(name, data, Experimenttimes, Sensorposition_w,Sensor_number,Coordinate_q2,Coordinate_q3,MFD_y,MFD_z,Area_Length,Area_Width,Node_Number,max_movespeed,max_rotatespeed,Orientation_Given,MFD_Given);
% end

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
plotpoints(w1,combineerror,'$\vec{w_{1}}$ (m)','Error (mm)','Error - $\vec{w_{1}}$','Error_w1',figureplot);
plotpoints(w2,combineerror,'$\vec{w_{2}}$ (m)','Error (mm)','Error - $\vec{w_{2}}$','Error_w2',figureplot);
plotpointsw3(w3,combineerror,'$\vec{w_{3}}$ (m)','Error (mm)','Error - $\vec{w_{3}}$','Error_w3',figureplot);
meshpoints(w1(15001:16000),w2(15001:16000),combineerror(15001:16000),-0.05,0.05,-0.05,0.05,'$\vec{w_{1}}$ (m)','$\vec{w_{2}}$ (m)','Error (mm)','Error - $\vec{w_{1}}$ - $\vec{w_{2}}$','Error_w1_w2',figureplot)


% 2nd Experiment
Experimenttimes_2 = 51^2;
% Decroator('Generating Random Test Points for 2nd Experiment ...',decroator)
% index = 1;
% for i = 1 : 51
%     for j = 1 : 51
%         Orientation_Given_2(index,1:3) = [-0.05+(i-1)*0.002,-0.05+(j-1)*0.002,0.0499];
%         Orientation_Given_2(index,4:5) = rand(2,1)*2*pi;
%         [Bx,By,Bz] = generateMFD(Orientation_Given_2(index,:),Sensorposition_w,Coordinate_q2,Coordinate_q3,MFD_y,MFD_z,Area_Length,Area_Width,Node_Number);
%         MFD_Given_2(index,:) = Bx;
%         index = index + 1;
%     end
% end
% xlswrite('testpoints_2.xlsx',[Orientation_Given_2,MFD_Given_2]);

Decroator('Reading Random Test Points for 2nd Experiment ...',decroator);
Test_Points_2 = xlsread('testpoints_2.xlsx');
Orientation_Given_2 = Test_Points_2(:,1:5);
MFD_Given_2 = Test_Points_2(:,6:30)';

plottestpoints(Orientation_Given_2(:,1),Orientation_Given_2(:,2),Orientation_Given_2(:,3),'$\vec{w_{1}}$','$\vec{w_{2}}$','$\vec{w_{3}}$','Test Points 2','Test_Points_2',figureplot);

% do the 2nd experiments under the best sensordaten and write them in excel-tables
% data = Test_Data(16,:);
% name = ['Experiment_2'];
% experiment(name, data, Experimenttimes_2, Sensorposition_w,Sensor_number,Coordinate_q2,Coordinate_q3,MFD_y,MFD_z,Area_Length,Area_Width,Node_Number,max_movespeed,max_rotatespeed,Orientation_Given_2,MFD_Given_2);

% analyse the 2nd results
Decroator('Analysing Results 2 ....',decroator);
readdata_2 = xlsread('Experiment_2.xlsx');
exresult_2 = readdata_2(2:end,:);
Error_2 = exresult_2(:,11);
inner1mm_2 = 0;
for i = 1 : size(Error_2)
    if Error_2(i) < 1
        inner1mm_2 = inner1mm_2 + 1;
    end
end
meanerror_2 = mean(Error_2);
xlswrite('analysis_2.xlsx',[inner1mm_2,meanerror_2]);

w1_2 = exresult_2(:,1);
w2_2 = exresult_2(:,2);
w3_2 = exresult_2(:,3);
plotpoints(w1_2,Error_2,'$\vec{w_{1}}$','Error','Error - $\vec{w_{1}}$','Error_w1_2',figureplot);
plotpoints(w2_2,Error_2,'$\vec{w_{2}}$','Error','Error - $\vec{w_{2}}$','Error_w2_2',figureplot);
meshpoints(w1_2,w2_2,Error_2,-0.05,0.05,-0.05,0.05,'$\vec{w_{1}}$','$\vec{w_{2}}$','Error','Error - $\vec{w_{1}}$ - $\vec{w_{2}}$','Error_w1_w2_2',figureplot)


% 3rd Experiment
Experimenttimes_3 = 51^2;
% Decroator('Generating Random Test Points for 2nd Experiment ...',decroator)
% index = 1;
% for i = 1 : 51
%     for j = 1 : 51
%         Orientation_Given_3(index,1:3) = [(i-1)*0.0005,(j-1)*0.0005,0.0499];
%         Orientation_Given_3(index,4:5) = rand(2,1)*2*pi;
%         [Bx,By,Bz] = generateMFD(Orientation_Given_3(index,:),Sensorposition_w,Coordinate_q2,Coordinate_q3,MFD_y,MFD_z,Area_Length,Area_Width,Node_Number);
%         MFD_Given_3(index,:) = Bx;
%         index = index + 1;
%     end
% end
% xlswrite('testpoints_3.xlsx',[Orientation_Given_3,MFD_Given_3]);

Decroator('Reading Random Test Points for 3rd Experiment ...',decroator);
Test_Points_3 = xlsread('testpoints_3.xlsx');
Orientation_Given_3 = Test_Points_3(:,1:5);
MFD_Given_3 = Test_Points_3(:,6:30)';

plottestpoints(Orientation_Given_3(:,1),Orientation_Given_3(:,2),Orientation_Given_3(:,3),'$\vec{w_{1}}$','$\vec{w_{2}}$','$\vec{w_{3}}$','Test Points 3','Test_Points_3',figureplot);

% do the 3rd experiments under the best sensordaten and write them in excel-tables
data = Test_Data(16,:);
name = ['Experiment_3'];
experiment(name, data, Experimenttimes_3, Sensorposition_w,Sensor_number,Coordinate_q2,Coordinate_q3,MFD_y,MFD_z,Area_Length,Area_Width,Node_Number,max_movespeed,max_rotatespeed,Orientation_Given_3,MFD_Given_3);

% analyse the 3rd results
Decroator('Analysing Results 3 ....',decroator);
readdata_3 = xlsread('Experiment_3.xlsx');
exresult_3 = readdata_3(2:end,:);
Error_3 = exresult_3(:,11);
inner1mm_3 = 0;
for i = 1 : size(Error_3)
    if Error_3(i) < 1
        inner1mm_3 = inner1mm_3 + 1;
    end
end
meanerror_3 = mean(Error_3);
xlswrite('analysis_3.xlsx',[inner1mm_3,meanerror_3]);

w1_3 = exresult_3(:,1);
w2_3 = exresult_3(:,2);
w3_3 = exresult_3(:,3);
plotpointsex3(w1_3,Error_3,'$\vec{w_{1}}$','Error','Error - $\vec{w_{1}}$','Error_w1_3',figureplot);
plotpointsex3(w2_3,Error_3,'$\vec{w_{2}}$','Error','Error - $\vec{w_{2}}$','Error_w2_3',figureplot);
meshpointsex3(w1_3,w2_3,Error_3,-0.05,0.05,-0.05,0.05,'$\vec{w_{1}}$','$\vec{w_{2}}$','Error','Error - $\vec{w_{1}}$ - $\vec{w_{2}}$','Error_w1_w2_3',figureplot)


Decroator('Programm finished.',decroator);



