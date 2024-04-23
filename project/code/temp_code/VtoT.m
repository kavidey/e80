% v = voltage
% R = Resistance
% T = Temperature

function T = VtoT(v)
R = 1000.*((27^2)./(9.4144-v)-27);
load("temp_calibration.mat")
T = 1./f3(log(R)) - 273.15;