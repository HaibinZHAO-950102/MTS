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
ADC_bit = 16;                                    % AD Converter bit

% Movement of Magnet
max_movespeed = 1;          % maximal velocity of magnet
max_rotatespeed = pi;         % maximal rotation speed of magnet

% test_data for sensors
Test_Data = [2, 4, 500, 5/1000, 16;2, 4, 500, 5/1000, 12;2, 4, 500, 5/1000, 14;...
            2, 4, 500, 5/1000, 18;2, 4, 500, 5/1000, 20;0.5, 4, 500, 5/1000, 16;...
            1, 4, 500, 5/1000, 16;4, 4, 500, 5/1000, 16;8, 4, 500, 5/1000, 16;...
            2, 4, 500, 1/1000, 16;2, 4, 500, 2/1000, 16;2, 4, 500, 10/1000, 16;...
            2, 4, 500, 20/1000, 20;1, 4, 500, 5/1000, 18;0.5, 4, 500, 10/1000, 20;...
            0, 4, 500, 100/1000, 50];
% data(1:4)=Sensordata, data(5) = k (ADC bit)

% Sensor positions in global-coordinaten
Decroator('Calculating Sensor Positions ...',decroator);
Sensorposition_w = sensorposition(W(1),Sensor_number);
plotsensorposition(Sensorposition_w(1,:),Sensorposition_w(2,:),'$\vec{w_{1}}$','$\vec{w_{2}}$','Sensorpositionen',figureplot);

vmax = 1;
rmax = pi;

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

% Grandient
Decroator('Calculating Gradient of MFD ...',decroator);
MFD_Gradient_value = grad(MFD_value,Coordinate_q2,Coordinate_q3);
MFD_Gradient_y = grad(MFD_y,Coordinate_q2,Coordinate_q3);
MFD_Gradient_z = grad(MFD_z,Coordinate_q2,Coordinate_q3);
mesh3D(Coordinate_q2(1:end-1),Coordinate_q3(1:end-1),MFD_Gradient_value(:,:,1),'$q_{2}$','$q_{3}$','$G_{m,y}$','Gradient $\frac{\partial{B_{m}}}{\partial{q_{2}}}$','Gradient_m_i2',figureplot);
mesh3D(Coordinate_q2(1:end-1),Coordinate_q3(1:end-1),MFD_Gradient_value(:,:,2),'$q_{2}$','$q_{3}$','$G_{m,z}$','Gradient $\frac{\partial{B_{m}}}{\partial{q_{3}}}$','Gradient_m_i3',figureplot);
mesh3D(Coordinate_q2(1:end-1),Coordinate_q3(1:end-1),MFD_Gradient_y(:,:,1),'$q_{2}$','$q_{3}$','$G_{y,y}$','Gradient $\frac{\partial{B_{y}}}{\partial{q_{2}}}$','Gradient_y_i2',figureplot);
mesh3D(Coordinate_q2(1:end-1),Coordinate_q3(1:end-1),MFD_Gradient_y(:,:,2),'$q_{2}$','$q_{3}$','$G_{y,z}$','Gradient $\frac{\partial{B_{y}}}{\partial{q_{3}}}$','Gradient_y_i3',figureplot);
mesh3D(Coordinate_q2(1:end-1),Coordinate_q3(1:end-1),MFD_Gradient_z(:,:,1),'$q_{2}$','$q_{3}$','$G_{z,y}$','Gradient $\frac{\partial{B_{z}}}{\partial{q_{2}}}$','Gradient_z_i2',figureplot);
mesh3D(Coordinate_q2(1:end-1),Coordinate_q3(1:end-1),MFD_Gradient_z(:,:,2),'$q_{2}$','$q_{3}$','$G_{z,z}$','Gradient $\frac{\partial{B_{z}}}{\partial{q_{3}}}$','Gradient_z_i3',figureplot);


OG = [0    0.0020    0.0499    3.4756    5.0414];
[BG,By,Bz] = generateMFD(OG,Sensorposition_w,Coordinate_q2,Coordinate_q3,MFD_y,MFD_z,Area_Length,Area_Width,Node_Number)

Og = OG;
Bg = BG';
Vn = Noising(Bg,Sensordata);
Bb = [0.0067
    0.0219
    0.0387
    0.0219
    0.0067
    0.0055
    0.0579
    0.3677
    0.0579
    0.0055
   -0.0000
   -0.0000
       NaN
   -0.0000
   -0.0000
    0.0055
    0.0579
    0.3677
    0.0579
    0.0055
    0.0067
    0.0219
    0.0387
    0.0219
    0.0067];
initialspace(1) = max(Og(1)-vmax*0.01,-0.05);
initialspace(2) = min(Og(1)+vmax*0.01,0.05);
initialspace(3) = max(Og(2)-vmax*0.01,-0.05);
initialspace(4) = min(Og(2)+vmax*0.01,0.05);
initialspace(5) = max(Og(3)-vmax*0.01,0);
initialspace(6) = min(Og(3)+vmax*0.01,0.05);
initialspace(7) = max(Og(4)-rmax*0.01,0);
initialspace(8) = min(Og(4)+rmax*0.01,2*pi);
initialspace(9) = max(Og(5)-rmax*0.01,0);
initialspace(10) = min(Og(5)+rmax*0.01,2*pi);
node = 4;
Os = localization2(Bb,initialspace,node,Sensor_number,Sensorposition_w,Coordinate_q2,Coordinate_q3,MFD_y,MFD_z,Area_Length,Area_Width,Node_Number);



Og =

         


ans =

    0.0234   -0.0081    0.0500    3.5674    5.0404


ans =

   1.0e-13 *

    0.3019
    0.3830
    0.1778
    0.3830
    0.3019
    0.2872
   -0.0150
    0.2703
   -0.0157
    0.2871
    0.0888
    0.0888
       NaN
    0.0888
    0.0888
    0.2872
   -0.0153
    0.2670
   -0.0154
    0.2872
    0.3019
    0.3830
    0.1778
    0.3830
    0.3019


initialspace =

   -0.0100    0.0100   -0.0080    0.0120    0.0399    0.0500    3.4442    3.5070    5.0100    5.0729


ans =

   25.4929


