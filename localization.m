function Os = localization(MFD_detected, initial_Orientation, MFD_y, MFD_z, GBy, GBz, Coordinate_q2, Coordinate_q3, Area_Length, Area_Width, Node_Number, Sensor_number, Sensorposition_w)
% to localize the Orientation of Magnet
for Node_Number = 1 : 30
    for j = 1 : Sensor_number^2
         [rcs, thetak]= coordinatew2i(initial_Orientation,Sensorposition_w(:,j));
         [ByV,BzV] = itplt(rcs(2,2),rcs(2,3),Coordinate_q2,Coordinate_q3,MFD_y,MFD_z,Area_Length,Area_Width,Node_Number);
         [BxS, ByS, BzS] = coordinatei2w(initial_Orientation(3),initial_Orientation(4),thetak,ByV,BzV);
         BxO0 = BxS;
         [GB22V,GB32V] = itplt(rcs(2,2),rcs(2,3),Coordinate_q2,Coordinate_q3,GBy(:,:,1),GBz(:,:,1),Area_Length,Area_Width,Node_Number);
         [GB23V,GB33V] = itplt(rcs(2,2),rcs(2,3),Coordinate_q2,Coordinate_q3,GBy(:,:,2),GBz(:,:,2),Area_Length,Area_Width,Node_Number);
         A = [-cos(initial_Orientation(5)),0,-sin(initial_Orientation(4));
             -sin(initial_Orientation(4))*sin(initial_Orientation(5)),-cos(initial_Orientation(4)),sin(initial_Orientation(4))*cos(initial_Orientation(5));
             cos(initial_Orientation(4))*sin(initial_Orientation(5)),-sin(initial_Orientation(4)),-cos(initial_Orientation(4))*cos(initial_Orientation(5));
             (-initial_Orientation(2)+Sensorposition_w(2,j))*cos(initial_Orientation(4))*sin(initial_Orientation(5))-initial_Orientation(3)*sin(initial_Orientation(4))*sin(initial_Orientation(5)),...
                 (initial_Orientation(2)-Sensorposition_w(2,j))*sin(initial_Orientation(4))-initial_Orientation(3)*cos(initial_Orientation(4)),...
                 (initial_Orientation(2)-Sensorposition_w(2,j))*cos(initial_Orientation(4))*cos(initial_Orientation(5))+initial_Orientation(3)*sin(initial_Orientation(4))*cos(initial_Orientation(5));
             (initial_Orientation(1)-Sensorposition_w(1,j))*sin(initial_Orientation(5))+(-initial_Orientation(2)+Sensorposition_w(2,j))*sin(initial_Orientation(4))*cos(initial_Orientation(5))+initial_Orientation(3)*cos(initial_Orientation(4))*cos(initial_Orientation(5)),...
                 0,...
                 (-initial_Orientation(1)+Sensorposition_w(1,j))*cos(initial_Orientation(5))+(-initial_Orientation(2)+Sensorposition_w(2,j))*sin(initial_Orientation(4))*sin(initial_Orientation(5))+initial_Orientation(3)*cos(initial_Orientation(4))*sin(initial_Orientation(5))];
        pj(:,j) = (MFD_detected(j)-BxO0) * A * [0,-sin(thetak),0;0,cos(thetak),0;0,0,1] * [0,0,0;0,GB22V,GB32V;0,GB23V,GB33V] * [0;-sin(thetak)*cos(initial_Orientation(5));sin(initial_Orientation(5))];
        p = nansum(pj')';
        p = p / norm(p);
    end
    alpha(1) = 0.0002;
    for i = 2 : 20
        alpha(i) = alpha(i-1) * 1.7;
    end
    for i = 1 : 10
        O1 = initial_Orientation + p * alpha(i);
        O1(1) = min(O1(1),0.05);
        O1(1) = max(O1(1),-0.05);
        O1(2) = min(O1(2),0.05);
        O1(2) = max(O1(2),-0.05);
        O1(3) = min(O1(3),0.05);
        O1(3) = max(O1(3),0);

        for j = 1 : Sensor_number^2
            [rcs, thetak]= coordinatew2i(O1,Sensorposition_w(:,j));
            [ByV,BzV] = itplt(rcs(2,2),rcs(2,3),Coordinate_q2,Coordinate_q3,MFD_y,MFD_z,Area_Length,Area_Width,Node_Number);
            [BxS, ByS, BzS] = coordinatei2w(O1(3),O1(4),thetak,ByV,BzV);
            BxO0 = BxS;
            Gj(j) = 0.5 * norm(MFD_detected(j)-BxS)^2;
        end
        G(i) = nansum(Gj);
        if i >= 3
            if G(i-2)> G(i-1) & G(i-1) < G(i)
                initial_Orientation = initial_Orientation + alpha(i-1)*p;
                break
            end
        end
    end
end
Os = initial_Orientation;

        
        
        
        
        
        
        
        
        
        
        
        
    
