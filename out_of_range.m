function D1 = out_of_range(Coordinate_q2,Coordinate_q3,Sensor_data,MFD_value)
D1 = zeros(length(Coordinate_q2),length(Coordinate_q3));
for i = 1 : length(Coordinate_q2)
    for j = 1 : length(Coordinate_q3)
        if MFD_value(i,j) > Sensor_data(3)
            D1(i,j) = 1;
        elseif isnan(MFD_value(i,j)) == 1
            D1(i,j) = 1;
        else
            D1(i,j) = 0;
        end
    end
end
