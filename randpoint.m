function [O Bb] = randpoint(Sensorposition_w,Sensornumber,Coordinate_q2,Coordinate_q3,MFD_y,MFD_z,Area_Length,Area_Width,Node_Number)
flag = 0;
while flag == 0
    O(1) = rand()*0.1-0.05;
    O(2) = rand()*0.1-0.05;
    O(3) = rand()*0.05;
    O(4) = rand()*2*pi;
    O(5) = rand()*2*pi;
    [Bx,By,Bz] = generateMFD(O,Sensorposition_w,Coordinate_q2,Coordinate_q3,MFD_y,MFD_z,Area_Length,Area_Width,Node_Number);
    Bb = Bx;
    collision = isnan(sum(Bb));
    if collision == 0
        flag = 1;
    end
end

