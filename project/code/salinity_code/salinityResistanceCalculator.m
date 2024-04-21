% all voltages are peak-to-peak; enter data in 4 arrays below
clear
clc
clf

Vindiv = [1.52
1.5
1.50
1.49
1.49
1.48
1.48
1.48
1.48];

Vout = [1.86
1.98
2.04
2.10
2.11
2.13
2.12
2.15
2.18];

waterMasses = [81.1
55.4
55.6
69.1
38.0
56.6
58.4
60.6
89.7];

saltMasses = [0.8
0.8
1.0
1.6
1.0
1.9
2.0
2.3
3.8];

% process datta here

Rin1 = 10070
Rin2 = 14760
Vin = Vindiv/(Rin2/(Rin1+Rin2));

R2 = 67;
Rprobe = (Vin-Vout)*R2./Vout;

salinity = saltMasses./(saltMasses+waterMasses);

hold on
% scatter(salinity, Rprobe, "filled")
scatter(salinity, Vout./Vin)
hold off
xlabel('Salinity (ppt)')
ylabel('Rprobe (\Omega)')

