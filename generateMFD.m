function [Bx,By,Bz] = generateMFD(Orientation_Given,Sensorposition_w,Coordinate_q2,Coordinate_q3,MFD_y,MFD_z,Area_Length,Area_Width,Node_Number)
for s = 1 : length(Sensorposition_w)
    [r_cs, theta_k]= coordinatew2i(Orientation_Given,Sensorposition_w(:,s));
    [MFD_y_Vglpunkt,MFD_z_Vglpunkt] = itplt(r_cs(2,2),r_cs(2,3),Coordinate_q2,Coordinate_q3,MFD_y,MFD_z,Area_Length,Area_Width,Node_Number);
    [MFD_at_Sensor_x, MFD_at_Sensor_y, MFD_at_Sensor_z] = coordinatei2w(Orientation_Given(3),Orientation_Given(4),theta_k,MFD_y_Vglpunkt,MFD_z_Vglpunkt);
    Bx(s) =  MFD_at_Sensor_x;
    By(s) =  MFD_at_Sensor_y;
    Bz(s) =  MFD_at_Sensor_z;
end
