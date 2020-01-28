function [f,o] = Noising(MFD,Sensordata)
% Generate the output Voltage of a Sensor f
% o = 0: the MFD is out of the range.
% MFD is the magnetic flux density
% error is the error in sensitivity in percent for eg 1%: error = 1
% ZV is the zero voltage
% Range is the range of the sensor
% Sen is the sensitivity in V/G

error = Sensordata(1);
ZV = Sensordata(2);
Range = Sensordata(3);
Sen = Sensordata(4);

f = zeros(length(MFD),1);
for i = 1: length(MFD)

    if abs(MFD(i)) > Range
        o(i) = 0;
    else
        o(i) = 1;
    end


    f(i) = ((rand()-0.5)*2*error/100+1) * Sen * MFD(i) + ZV;
end


