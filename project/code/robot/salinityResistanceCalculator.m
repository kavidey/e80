Vindiv = [1.59 2.20 1.54 1.53 1.53 2.0]';
Rin1 = 10070
Rin2 = 14760
Vin = Vindiv/(Rin2/(Rin1+Rin2));

Vout = [1.67 1.93 1.95 1.96 1.94 1.54]';
R2 = 67;
Rprobe = (Vin-Vout)*R2./Vout
salinity = [10.67 32.75 31.25 33.93 34.69 40.85]';

scatter(salinity, Rprobe, "filled")
xlabel('Salinity (ppt)')
ylabel('Rprobe (\Omega)')
