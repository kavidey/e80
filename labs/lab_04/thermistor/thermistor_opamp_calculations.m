R2 = 5000;
R1 =  15000;
Rf = 2200;
Ri = 2200;
Vdc = 5;
B = 4050;
Rd = 27000;
Rt = [158000 56300]

% R0 = 47000; % from datasheet
% T0 = 293.15; % 20 C
% % Tc = [-0.1 20.3] % temps in celcius
% Tc = [0 20]
% Tk = Tc + 273.15
% Rt = R0*exp(B*(1./Tk-1/T0))

Vin = Vdc*(Rd./(Rd+Rt))
Vout = (R2/(R1+R2))*(1+(Rf/Ri))*Vdc-(Rf/Ri).*Vin