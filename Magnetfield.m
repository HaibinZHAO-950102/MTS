function [Hy,Hz,q2,q3] = Magnetfield(Ra,L,Br,B,H,n)
% Hy and Hz are magnetic field strength in i2 and i3 direction
% q2 is the coordinaten in i2 direction in Meter (m)
% q3 is the coordinaten in i3 direction in Meter (m)
% Ra is the radius of the magnet
% L is the altitude of the magnet
% Br is the Magnetic Remanenz
% B und H die area on which the megnetic field be calculated
% n number of the nodes



% m is the magnetization of the Magnets. Dor Permanetmagnet is m = Br/mu_0
m = Br / (4*pi*10^(-7));


% Megnetic Field from area 1
for i = 1 : n + 1;
    for j = 1 : n * 2 + 1;
        q2 = (i - 1) * B / n;
        q3 = (j - 1) * H / 2 / n - H/2;
        h12(i,j) = H12(q2,q3,m,Ra,L);
        h13(i,j) = H13(q2,q3,m,Ra,L);
    end
end

% Megnetic Field from area 3
for i = 1 : n + 1;
    for j = 1 : n * 2 + 1;
        h32(i,j) = - h12(i,2*n+2-j);
        h33(i,j) = h13(i,2*n+2-j);
    end
end

Hy = h12 + h32;
Hz = h13 + h33;

% let the magnetic field strength inside the Manget to 0
for i = 1 : n + 1;
    for j = 1 : n * 2 + 1;
        q2 = (i - 1) * B / n;
        q3 = (j - 1) * H / 2 / n - H/2;
        if and((q2 <= Ra + B/n),(q3 <= L/2+H/2/n))
            Hy(i,j) = NaN;
            Hz(i,j) = NaN;
        end
    end
end

%Symmetry to eliminate the numerical error on coordinate
for i = 1 : n + 1;
    for j = 1 : n;
        Hy(i,j) = - Hy(i,2*n+2-j);
        Hz(i,j) = Hz(i,2*n+2-j);
        end
    end

i = 1 : n + 1;
j = 1 : n * 2 + 1;
q2 = (i - 1) * B / n;
q3 = (j - 1) * H / 2 / n - H/2;
% 
% xlswrite('Hy.xlsx',Hy);
% xlswrite('Hz.xlsx',Hz);
% xlswrite('q2.xlsx',q2);
% xlswrite('q3.xlsx',q3);




