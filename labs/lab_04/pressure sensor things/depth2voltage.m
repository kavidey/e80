%% need to change resistor values to get everything within range
%% need to make sure circuit actually works as planed w simulator
%% need to make schematic with bypass capacitors
%% write up uncertainty calculations
R1 = 100;
dR1 = 0.05*R1;
R2 = 10000;
dR2 = 0.05*R2;
R3 = 2200;
dR3 = 0.05*R3;
R4 = 470;
dR4 = 0.05*R4;
depthsCm = [0 10 20 30 40]
dDepthsCm = [1 1 1 1 1] % assuming we are off by +/- 1 cm
power = 5;
x = size(depthsCm)
n = x(2)

% voltage calculations
V1 = power*R4/(R3+R4); % voltage divider equation
depthsM = depthsCm / 100;
waterPressures = depthsM*10 % depth to pressure in kPa
atm = 101.325 % ambient atmospheric pressure in kPa
Vin = 5*(0.0012858*(waterPressures + atm) +0.04)
dVin = .025*Vin;
gain = (1+R2/R1)
offset = V1*R2/R1
Vout = (1+R2/R1)*Vin - V1*R2/R1

% error calculation. VoutYucky is the same as Vout, but it has all of our
% original variables for partial derivative purposes
syms r1 r2 r3 r4 depths
VoutYucky = @(r1, r2, r3, r4, depths) 5*(0.0012858*(depths/10 + atm) +0.04)*(1+r2/r1) - power*r4*r2/(r1*(r3+r4));
% find partial derivative of each variable wrt Vout
DR1 = @(r1, r2, r3, r4, depths) diff(VoutYucky, r1)
DR2 = diff(VoutYucky, r2)
DR3 = diff(VoutYucky, r3);
DR4 = diff(VoutYucky, r4);
Ddepths = diff(VoutYucky, depths);
% evaluate partials at actual variable values
r1 = R1;
r2 = R2;
r3 = R3;
r4 = R4;
depths = depthsCm;
% im confused what code is doinig here
% derivR1 = DR1(R1, R2, R3, R4, depthsCm)
DR1 = abs(subs(DR1));
DR2 = abs(subs(DR2));
DR3 = abs(subs(DR3));
DR4 = abs(subs(DR4));
Ddepths = abs(subs(Ddepths));
% find contribution to error; (uncertainty)*(partial derivative wrt Vout)
contribution1 = dR1*DR1
contribution2 = dR2*DR2
contribution3 = dR3*DR3
contribution4 = dR4*DR4
contributionDepth = dDepthsCm*Ddepths
uncertainty = sqrt(contribution1.^2+contribution2.^2+contribution3.^2+contribution4.^2+ ...
    contributionDepth.^2);
uncertainty = double(uncertainty)
for x = 1:n
    [x depths(x), Vout(x), uncertainty(x)]
end

