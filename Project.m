clc
clear
% Decorator. 1 is activited, 0 is deactivited
decroator = 1;    
% Plot and Mesh. 1 is activited, 0 is deactivited, 2 means to output the figure as png-file
figureplot = 0;

% Workspace
%Size of the Workspaces in Meter m
W = [0.1,0.1,0.05];

% Magnet
% Radius of the Magnet in Meter m
Magnet_radius = 0.009;
% Altitude of the Magnet in Meter m
Magnet_altitude = 0.005;
% Magnetic Remanenz in T
Magnet_remanenz = 1.48;
% Number of the Nodes
Node_Number = 500;
% Width and Length of the calculated area
Area_Width = 0.15;
Area_Length = 2 * Area_Width;
mu0 = 4*pi*10^-7;

% Hardwares
% Drift, Zerovoltage, Range, Sensitivity
Sensor_data = [2, 4, 500, 5/1000];
% number of sensors on each edge
Sensor_number = 5;
ADC_bit = 16;
% AD Converter bit
% test_data for sensors
Test_Data = [2, 4, 500, 5/1000, 16;...
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
             2, 4, 500, 20/1000, 20;...
             1, 4, 500, 5/1000, 18;...
             0.5, 4, 500, 10/1000, 20;...
             0, 4, 500, 100/1000, 50];
% data(1:4)=Sensordata, data(5) = k (ADC bit)

% Movement of Magnet
% maximal velocity of magnet
max_movespeed = 1;
% maximal rotation speed of magnet
max_rotatespeed = pi;

% Calculate the Magnetic Field Distribution
% Decroator('Calculating Magetic Field Strength ...',decroator);
% [MFS_y,MFS_z,Coordinate_q2,Coordinate_q3] = Magnetfield(Magnet_radius,Magnet_altitude,Magnet_remanenz,Area_Width,Area_Length,Node_Number,'main',1);            
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
plotsensorposition(Sensorposition_w(1,:),Sensorposition_w(2,:),'$\vec{w_{1}}$ (m)','$\vec{w_{2}}$ (m)','Sensor Positions 5','Sensor Positions 5',figureplot);

% Detected Signal at Sensors
% Magnet Orientation
Orientation = [-0.049,-0.049,0.049,0,0];
test_node = 360;
MFD_at_Sensor = zeros(Sensor_number^2,3,test_node,test_node);
THETA1 = 0:1/test_node*2*pi:2*pi-1/test_node*2*pi;
THETA2 = THETA1;
% s is sensor index
for s = 1:Sensor_number^2
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

% out of range area
D_out_of_range = out_of_range(Coordinate_q2,Coordinate_q3,Sensor_data,MFD_value);
out_of_range_points = area2points(Coordinate_q2,Coordinate_q3,D_out_of_range);
plotarea(out_of_range_points(:,1),out_of_range_points(:,2),'$q_{2}$ (m)','$q_{3}$ (m)','Out of Range','Out of Range',figureplot);

% detectable area
% ADC bit
ADC_BIT = [12,14,16,18,20];
% Sensitivity
SENSITIVITY = [5/1000, 10/1000, 20/1000];
Detectable_area = NaN(length(ADC_BIT),length(SENSITIVITY),length(Coordinate_q2),length(Coordinate_q3));
Detectable_movement = NaN(length(ADC_BIT),length(SENSITIVITY),length(Coordinate_q2),length(Coordinate_q3));
for i = 1:length(ADC_BIT)
    for j = 1 : length(SENSITIVITY)
        Detectable_area(i,j,:,:) = detectablearea(Coordinate_q2,Coordinate_q3,D_out_of_range,ADC_BIT(i),SENSITIVITY(j),MFD_Gradient_value);
        Detectable_movement(i,j,:,:) = detectmovement(Coordinate_q2,Coordinate_q3,SENSITIVITY(j),ADC_BIT(i),MFD_Gradient_value);
        Detectable_points = area2points(Coordinate_q2(1:end-1),Coordinate_q3(2:end-1),squeeze(Detectable_area(i,j,1:end-1,2:end-1)));
        name1 = {['Detectable Area with ',num2str(ADC_BIT(i)),' bit'];['ADC and ',num2str(SENSITIVITY(j)*1000),'бы Sensitivity']};
        filename1 = ['Detectable Area ',num2str(ADC_BIT(i)),' bit ',num2str(SENSITIVITY(j)*1000)];
        plotarea(Detectable_points(:,1),Detectable_points(:,2),'$q_{2}$ (m)','$q_{3}$ (m)',name1,filename1,figureplot);
        name2 = {['Detectable Movement with ',num2str(ADC_BIT(i)),' bit'];['ADC and ',num2str(SENSITIVITY(j)*1000),'бы Sensitivity']};
        filename2 = ['Detectable Movement ',num2str(ADC_BIT(i)),' bit ',num2str(SENSITIVITY(j)*1000)];
        mesh3Darea(Coordinate_q2(1:end-1),Coordinate_q3(2:end-1),squeeze(Detectable_movement(i,j,1:end-1,2:end-1)),'$q_{2}$ (m)','$q_{3}$ (m)','Movement (mm)',name2,filename2,figureplot);
    end
end

% Localization Process

% 1st experiment
% Experimenttimes = 1000;
% Decroator('Generating Random Test Points ...',decroator)
% % test points
% Orientation_Given = zeros(Experimenttimes,5); 
% % MFD of test points at every sensor
% MFD_Given = zeros(25,Experimenttimes);       
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
Experimenttimes = size(Orientation_Given,1);

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
Errorinner5mm = zeros(Experimenttimes,size(Test_Data,1));
for i = 1 : size(Test_Data,1)
    name = ['Ex_',num2str(i-1),'.xlsx'];
    readdata = xlsread(name);
    exresult(i,:,:) = readdata(2:end,:);
    Error(:,i) = exresult(i,:,11)';
end
inner5mm = zeros(size(Test_Data,1),1);
meanerror = zeros(size(Test_Data,1),1);
for i = 1 : size(Test_Data,1)
    for j = 1 : Experimenttimes
        if Error(j,i) <= 5
            inner5mm(i) = inner5mm(i) + 1;
            Errorinner5mm(j,i) = Error(j,i);
        else
            Errorinner5mm(j,i) = NaN;
        end
    end
    meanerror(i) = nanmean(Errorinner5mm(:,i));
end
xlswrite('analysis.xlsx',[inner5mm,meanerror]);

plotresult(meanerror,inner5mm,figureplot)

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
% Experimenttimes_2 = 51^2;
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

Decroator('Reading Test Points for 2nd Experiment ...',decroator);
Test_Points_2 = xlsread('testpoints_2.xlsx');
Orientation_Given_2 = Test_Points_2(:,1:5);
MFD_Given_2 = Test_Points_2(:,6:30)';
Experimenttimes_2 = size(Orientation_Given_2,1);

plottestpoints(Orientation_Given_2(:,1),Orientation_Given_2(:,2),Orientation_Given_2(:,3),'$\vec{w_{1}}$ (m)','$\vec{w_{2}}$ (m)','$\vec{w_{3}}$ (m)','Test Points 2','Test_Points_2',figureplot);

% do the 2nd experiments under the best sensordaten and write them in excel-tables
% data = Test_Data(16,:);
% name = ['Experiment_2'];
% experiment(name, data, Experimenttimes_2, Sensorposition_w,Sensor_number,Coordinate_q2,Coordinate_q3,MFD_y,MFD_z,Area_Length,Area_Width,Node_Number,max_movespeed,max_rotatespeed,Orientation_Given_2,MFD_Given_2);

% analyse the 2nd results
Decroator('Analysing Results 2 ....',decroator);
readdata_2 = xlsread('Experiment_2.xlsx');
exresult_2 = readdata_2(2:end,:);
Error_2 = exresult_2(:,11);

w1_2 = exresult_2(:,1);
w2_2 = exresult_2(:,2);
w3_2 = exresult_2(:,3);
plotpoints(w1_2,Error_2,'$\vec{w_{1}}$ (m)','Error (mm)','Error - $\vec{w_{1}}$','Error_w1_2',figureplot);
plotpoints(w2_2,Error_2,'$\vec{w_{2}}$ (m)','Error (mm)','Error - $\vec{w_{2}}$','Error_w2_2',figureplot);
meshpoints(w1_2,w2_2,Error_2,-0.05,0.05,-0.05,0.05,'$\vec{w_{1}}$ (m)','$\vec{w_{2}}$ (m)','Error (mm)','Error - $\vec{w_{1}}$ - $\vec{w_{2}}$','Error_w1_w2_2',figureplot)

% 3rd Experiment
% Experimenttimes_3 = 51^2;
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

Decroator('Reading Test Points for 3rd Experiment ...',decroator);
Test_Points_3 = xlsread('testpoints_3.xlsx');
Orientation_Given_3 = Test_Points_3(:,1:5);
MFD_Given_3 = Test_Points_3(:,6:30)';
Experimenttimes_3 = size(Orientation_Given_3,1);

plottestpoints(Orientation_Given_3(:,1),Orientation_Given_3(:,2),Orientation_Given_3(:,3),'$\vec{w_{1}}$ (m)','$\vec{w_{2}}$ (m)','$\vec{w_{3}}$ (m)','Test Points 3','Test_Points_3',figureplot);

% do the 3rd experiments under the best sensordaten and write them in excel-tables
% data = Test_Data(16,:);
% name = ['Experiment_3'];
% experiment(name, data, Experimenttimes_3, Sensorposition_w,Sensor_number,Coordinate_q2,Coordinate_q3,MFD_y,MFD_z,Area_Length,Area_Width,Node_Number,max_movespeed,max_rotatespeed,Orientation_Given_3,MFD_Given_3);

% analyse the 3rd results
Decroator('Analysing Results 3 ....',decroator);
readdata_3 = xlsread('Experiment_3.xlsx');
exresult_3 = readdata_3(2:end,:);
Error_3 = exresult_3(:,11);

w1_3 = exresult_3(:,1);
w2_3 = exresult_3(:,2);
w3_3 = exresult_3(:,3);
plotpointsex3(w1_3,Error_3,'$\vec{w_{1}}$ (m)','Error (mm)','Error - $\vec{w_{1}}$','Error_w1_3',figureplot);
plotpointsex3(w2_3,Error_3,'$\vec{w_{2}}$ (m)','Error (mm)','Error - $\vec{w_{2}}$','Error_w2_3',figureplot);
meshpointsex3(w1_3,w2_3,Error_3,0,0.025,0,0.025,'$\vec{w_{1}}$ (m)','$\vec{w_{2}}$ (m)','Error (mm)','Error - $\vec{w_{1}}$ - $\vec{w_{2}}$','Error_w1_w2_3',figureplot)

% 4th Experiment
Sensor_number_2 = 3;
Sensorposition_w_2 = sensorposition(W(1),Sensor_number_2);
plotsensorposition(Sensorposition_w_2(1,:),Sensorposition_w_2(2,:),'$\vec{w_{1}}$ (m)','$\vec{w_{2}}$ (m)','Sensor Positions 3','Sensor Positions 3',figureplot);

% Decroator('Generating Random Test Points for 4th Experiment ...',decroator)
% Test_Points_4 = xlsread('testpoints.xlsx');
% Orientation_Given_4 = Test_Points_4(:,1:5);
% for i = 1 : size(Orientation_Given_4,1)
%     [Bx,~,~] = generateMFD(Orientation_Given_4(i,:),Sensorposition_w_2,Coordinate_q2,Coordinate_q3,MFD_y,MFD_z,Area_Length,Area_Width,Node_Number);
%     MFD_Given_4(i,:) = Bx;
% end
% xlswrite('testpoints_4.xlsx',[Orientation_Given_4,MFD_Given_4]);

Decroator('Reading Test Points for 4th Experiment ...',decroator);
Test_Points_4 = xlsread('testpoints_4.xlsx');
Orientation_Given_4 = Test_Points_4(:,1:5);
MFD_Given_4 = Test_Points_4(:,6:14)';
Experimenttimes_4 = size(Orientation_Given_4,1);

% do the 4nd experiments under the best sensordaten and write them in excel-tables
% data = Test_Data(16,:);
% name = ['Experiment_4'];
% experiment(name, data, Experimenttimes_4, Sensorposition_w_2,Sensor_number_2,Coordinate_q2,Coordinate_q3,MFD_y,MFD_z,Area_Length,Area_Width,Node_Number,max_movespeed,max_rotatespeed,Orientation_Given_4,MFD_Given_4);

% 5th Experiment
Sensor_number_3 = 4;
Sensorposition_w_3 = sensorposition(W(1),Sensor_number_3);
plotsensorposition2(Sensorposition_w_3(1,:),Sensorposition_w_3(2,:),'$\vec{w_{1}}$ (m)','$\vec{w_{2}}$ (m)','Sensor Positions 4','Sensor Positions 4',figureplot);

% Decroator('Generating Random Test Points for 5th Experiment ...',decroator)
% Test_Points_5 = xlsread('testpoints.xlsx');
% Orientation_Given_5 = Test_Points_5(:,1:5);
% for i = 1 : size(Orientation_Given_5,1)
%     [Bx,~,~] = generateMFD(Orientation_Given_5(i,:),Sensorposition_w_3,Coordinate_q2,Coordinate_q3,MFD_y,MFD_z,Area_Length,Area_Width,Node_Number);
%     MFD_Given_5(i,:) = Bx;
% end
% xlswrite('testpoints_5.xlsx',[Orientation_Given_5,MFD_Given_5]);

Decroator('Reading Test Points for 5th Experiment ...',decroator);
Test_Points_5 = xlsread('testpoints_5.xlsx');
Orientation_Given_5 = Test_Points_5(:,1:5);
MFD_Given_5 = Test_Points_5(:,6:21)';
Experimenttimes_5 = size(Orientation_Given_5,1);

% do the 5th experiments under the best sensordaten and write them in excel-tables
% data = Test_Data(16,:);
% name = ['Experiment_5'];
% experiment(name, data, Experimenttimes_5, Sensorposition_w_3,Sensor_number_3,Coordinate_q2,Coordinate_q3,MFD_y,MFD_z,Area_Length,Area_Width,Node_Number,max_movespeed,max_rotatespeed,Orientation_Given_5,MFD_Given_5);

% 6th Experiment
Sensor_number_4 = 7;
Sensorposition_w_4 = sensorposition(W(1),Sensor_number_4);
plotsensorposition3(Sensorposition_w_4(1,:),Sensorposition_w_4(2,:),'$\vec{w_{1}}$ (m)','$\vec{w_{2}}$ (m)','Sensor Positions 7','Sensor Positions 7',figureplot);

% Decroator('Generating Random Test Points for 5th Experiment ...',decroator)
% Test_Points_6 = xlsread('testpoints.xlsx');
% Orientation_Given_6 = Test_Points_6(:,1:5);
% for i = 1 : size(Orientation_Given_6,1)
%     [Bx,~,~] = generateMFD(Orientation_Given_6(i,:),Sensorposition_w_4,Coordinate_q2,Coordinate_q3,MFD_y,MFD_z,Area_Length,Area_Width,Node_Number);
%     MFD_Given_6(i,:) = Bx;
% end
% xlswrite('testpoints_6.xlsx',[Orientation_Given_6,MFD_Given_6]);

Decroator('Reading Test Points for 6th Experiment ...',decroator);
Test_Points_6 = xlsread('testpoints_6.xlsx');
Orientation_Given_6 = Test_Points_6(:,1:5);
MFD_Given_6 = Test_Points_6(:,6:54)';
Experimenttimes_6 = size(Orientation_Given_6,1);

% do the 6th experiments under the best sensordaten and write them in excel-tables
% data = Test_Data(16,:);
% name = ['Experiment_6'];
% experiment(name, data, Experimenttimes_6, Sensorposition_w_4,Sensor_number_4,Coordinate_q2,Coordinate_q3,MFD_y,MFD_z,Area_Length,Area_Width,Node_Number,max_movespeed,max_rotatespeed,Orientation_Given_6,MFD_Given_6);

% analyse 4-6th Experiments
meanerror_array = zeros(1,4);
for i = 1 : 3
    Experiment_numer = ['4','5','6'];
    name = ['Experiment_',Experiment_numer(i),'.xlsx'];
    data = xlsread(name);
    ERROR = data(2:end,11);
    for k = 1 : 1000
        if ERROR(k) > 5
            ERROR(k) = NaN;
        end
    end
    meanerror_array(i) = nanmean(ERROR);
end
data = xlsread('Ex_15.xlsx');
ERROR = data(2:end,11);
for k = 1 : 1000
    if ERROR(k) > 5
        ERROR(k) = NaN;
    end
end
meanerror_array(4) = nanmean(ERROR);
temp = meanerror_array(3);
meanerror_array(3) = meanerror_array(4);
meanerror_array(4) = temp;
plotarrayresult(meanerror_array,figureplot)


% Hardware Validation
% x_v = [0 -0.03 0 0.02];
% y_v = [0 -0.04 0.01 0.05];
% z_v = [0.05 0.02 0.03 0.04];
% theta1_v = [0 0 pi/2 -pi/2];
% theta2_v = [0 pi/4 pi/6 -pi/6];
% for i = 1 : 4
%     Orientation_Validation(i,:) = [x_v(i) y_v(i) z_v(i) theta1_v(i) theta2_v(i)];
%     [Bx,~,~] = generateMFD(Orientation_Validation(i,:),Sensorposition_w_3,Coordinate_q2,Coordinate_q3,MFD_y,MFD_z,Area_Length,Area_Width,Node_Number);
%     MFD_Validation(i,:) = Bx;
% end
% Orientation_Validation(:,4:5) = Orientation_Validation(:,4:5) / pi * 180;
% xlswrite('Validation.xlsx',[Orientation_Validation,MFD_Validation]);

Validation_Data = xlsread('Validation.xlsx');
Orientation_Validation = Validation_Data(:,1:5);
Orientation_Validation_show = Orientation_Validation;
Orientation_Validation(:,4:5) = Orientation_Validation(:,4:5) * pi / 180;
for i = 1 : 4
    name = ['Orientation ',num2str(i)];
    orientation_indicator(Orientation_Validation(i,:),name,['Validation_',num2str(i)],2)
end
MFD_Validation = Validation_Data(:,6:21);

validationresult = xlsread('Validationresult.xlsx');
zero_voltage = validationresult(:,2);
validation_evaluation = zeros(k,1);
voltage_theory_quantization = zeros(16,4);
for k = 1 : 4
    voltage_is = validationresult(:,2*k+1);
    MFD_theory = validationresult(:,2*k+2);
    voltage_difference_theory = MFD_theory * 5 / 3000;
    voltage_theory = voltage_difference_theory + zero_voltage;
    voltage_theory_quantization(:,k) = (floor((voltage_theory + 5/2048) / (5/1024))) * 5 / 1024;
    validation_evaluation(k) = norm(voltage_is - voltage_theory_quantization(:,k));
end
validation_evaluation = [NaN,validation_evaluation(1),NaN,validation_evaluation(2),NaN,validation_evaluation(3),NaN,validation_evaluation(4)]/16;
% xlswrite('validation_evaluation.xlsx', validation_evaluation)

xlswrite('validation_evaluation.xlsx',[validationresult(:,3),voltage_theory_quantization(:,1),validationresult(:,5),voltage_theory_quantization(:,2),validationresult(:,7),voltage_theory_quantization(:,3),validationresult(:,9),voltage_theory_quantization(:,4);validation_evaluation])


% important!!
% if the figures are already with tranparent background, the parameter
% trans must be set to 0 !!!!!!!!!!!
% Decroator('Processing Pictures ....',decroator);
% trans = 0;
% files = dir('E:\Matlab\Project_github\MTS');
% for i = 1 : size(files,1)
%     NAME = files(i).name;
%     l = size(NAME,2);
%     if l >= 4
%         TYPE = NAME(l-2:l);
%         if TYPE == 'png'
%             [I alpha] = cutfigure(NAME);
%             if trans == 1
%                 imwrite(I,NAME,'Alpha',alpha)
%             elseif trans == 0
%                 imwrite(I,NAME)
%             end
%         end
%     end
% end

Decroator('Programm finished.',decroator);



