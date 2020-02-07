clc
clear
decroator = 1;     % Decorator. 1 is activited, 0 is deactivited
figureplot = 1;    % Plot and Mesh. 1 is activited, 0 is deactivited, 2 means to output the figure as png-file


% Workspace
W = [0.1,0.1,0.05];      %Size of the Workspaces in Meter m

% Magnet
Ra = 0.009;              % Radius of the Magnet in Meter m
L = 0.005;               % Altitude of the Magnet in Meter m
Br = 1.48;               % Magnetic Remanenz in T
Nodenumber = 500;        % Number of the Nodes
B = 0.05;
H = 2 * B;               % Width and Length of the calculated area
mu0 = 4*pi*10^-7;

% Hardwares
Sensordata = [2, 4, 500, 5/1000];          % Error, Zerovoltage, Range, Sensitivity
Sensornumber = 5;                          % number of sensors on each edge
k = 16;                                    % AD Converter bit

%Calculate the Magnetic Field Distribution
Decroator('Calculating Magetic Field Strength ...',decroator);
[Hy,Hz,q2,q3] = Magnetfield(Ra,L,Br,B,H,Nodenumber,'show',1);

















