function [MFS_y,MFS_z,Coordinate_q2,Coordinate_q3] = Magnetfield(Magnet_radius,Magnet_altitude,Magnet_remanenz,Area_Width,Area_Length,Node_Number,filename,write)
% m is the magnetization of the Magnets. Dor Permanetmagnet is m = Br/mu_0
m = Magnet_remanenz / (4*pi*10^(-7));

h12 = zeros(Node_Number + 1,Node_Number * 2 + 1);
h13 = h12;
h32 = h12;
h33 = h12;

% Megnetic Field from area 1
for i = 1 : Node_Number + 1
    t1 = clock;
    for j = 1 : Node_Number * 2 + 1
        Coordinate_q2 = (i - 1) * Area_Width / Node_Number;
        Coordinate_q3 = (j - 1) * Area_Length / 2 / Node_Number - Area_Length/2;
        h12(i,j) = H12(Coordinate_q2,Coordinate_q3,m,Magnet_radius,Magnet_altitude);
        h13(i,j) = H13(Coordinate_q2,Coordinate_q3,m,Magnet_radius,Magnet_altitude);
    end
    t2 = clock;
    delta_t = etime(t2,t1);
    rest_time = delta_t * (Node_Number+1-i);
    percentage = floor(i/(Node_Number+1)*10000)/100;
    Decroator(['Calculating MFS ',num2str(percentage),'%. Estimated to be finished in ',num2str(floor(rest_time)),' seconds ...'],1);
end

% Megnetic Field from area 3
for i = 1 : Node_Number + 1
    for j = 1 : Node_Number * 2 + 1
        h32(i,j) = - h12(i,2*Node_Number+2-j);
        h33(i,j) = h13(i,2*Node_Number+2-j);
    end
end

MFS_y = h12 + h32;
MFS_z = h13 + h33;

% let the magnetic field strength inside the Manget to 0
for i = 1 : Node_Number + 1
    for j = 1 : Node_Number * 2 + 1
        Coordinate_q2 = (i - 1) * Area_Width / Node_Number;
        Coordinate_q3 = (j - 1) * Area_Length / 2 / Node_Number - Area_Length/2;
        if and((Coordinate_q2 <= Magnet_radius + Area_Width/Node_Number),(Coordinate_q3 <= Magnet_altitude/2+Area_Length/2/Node_Number))
            MFS_y(i,j) = NaN;
            MFS_z(i,j) = NaN;
        end
    end
end

%Symmetry to eliminate the numerical error on coordinate
for i = 1 : Node_Number + 1
    for j = 1 : Node_Number
        MFS_y(i,j) = - MFS_y(i,2*Node_Number+2-j);
        MFS_z(i,j) = MFS_z(i,2*Node_Number+2-j);
    end
end

i = 1 : Node_Number + 1;
j = 1 : Node_Number * 2 + 1;
Coordinate_q2 = (i - 1) * Area_Width / Node_Number;
Coordinate_q3 = (j - 1) * Area_Length / 2 / Node_Number - Area_Length/2;

if write == 1
    xlswrite(['Hy_',filename,'.xlsx'],MFS_y);
    xlswrite(['Hz_',filename,'.xlsx'],MFS_z);
    xlswrite(['q2_',filename,'.xlsx'],Coordinate_q2);
    xlswrite(['q3_',filename,'.xlsx'],Coordinate_q3);
end



