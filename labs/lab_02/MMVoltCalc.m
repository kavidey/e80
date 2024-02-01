%error propogation for multimeter: measured in AC
%Range from 50 Hz to 400 Hz: in range
%accuracy: 60.00mv = +- (1.0% + 0.05 mV)
%          600.0mv = +- (1.0% + 0.5 mV)
%          (increase by powers of ten to 600.0)
%          1000V = +- (1.0% +5V)
%Input Impedance 10 mega ohms over 50 pF
% Mega -> Ohm = 10^-6 Conversion

Prompt = 'Value for Z1 in Ohms: ';
z1 = input(Prompt);

Prompt = 'Value for Z2 in Ohms: ';
z2 = input(Prompt);


%Finding Z equivalences 
zeq1 = 50 + z1;
zeq2 = (z2*10^7)/(10^7+z2);

%Find VRMS
vpp = 1;  %in volts
% vp = 1/2V -> vpout = 1/2V 
vp = 1/2*vpp;

RMS = vp/sqrt(2);
% amplitude is vin?
% vout is 1/2 vin

%voltage divider equation 
vin = vp;
vout = vin*(zeq2/(zeq1+zeq2));

%uncertainty calculations
erz1 = z1*0.05;
erz2 = z2*0.05;
erv = vp*0.02;
erm = 0.01*vout + 0.005;
err = sqrt(((-1/(z1+z2))^2)*erz1^2 + (z1/z2)*(1/(z1+z2))^2*erz2^2+(1/vin)^2*(erv^2) + erm^2);

%Printing Results
fprintf("%.3f +/- %.3f\n",vout/sqrt(2),err/sqrt(2));

% voltage, resistors, multimeter
%Consider Resistances: 5% for z1 and z2
%voltage highest when it is equal to the amplitude (max or min) then
%uncertainty is greatest


