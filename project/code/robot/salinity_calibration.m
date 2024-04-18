clc
% High Salinity Resolution Trials
hs_waterMass = [81.1 55.4 55.6 69.1 38.0 56.6 58.4 60.6 89.7]; % [mL]
hs_saltMass = [0.8 0.8 1.0 1.6 1.0 1.9 2.0 2.3 3.8]; % [g]
hs_temp = 21.5 * ones(size(hs_waterMass)); % [C]
hs_vout = [1.86 1.98 2.04 2.10 2.11 2.13 2.12 2.15 2.18]; % [V]
hs_vin = [2.20 2.18 2.17 2.15 2.15 2.15 2.14 2.14 2.14]; % [V]

hs_salinity = 1000 * hs_saltMass ./ (hs_saltMass + hs_waterMass); % [ppt]
hs_gain = hs_vout ./ hs_vin;

% High Temp Resolution Trials
ht_waterMass = [81.1 81.1 81.1 81.1 81.1 56.6 56.6 56.6 56.6 89.7 89.7 89.7 89.7]; % [mL]
ht_saltMass = [0.8 0.8 0.8 0.8 0.8 1.9 1.9 1.9 1.9 3.8 3.8 3.8 3.8]; % [g]
ht_temp = [26.8 26.1 39.3 35.3 31.7 41.8 36.2 30.4 25.8 40.2 34.8 29.6 25.6]; % [C]
ht_vout = [1.88 1.75 2.04 1.98 1.96 2.23 2.20 2.19 2.17 2.27 2.23 2.40 2.23]; % [V]
ht_vin  = [1.53 1.52 1.50 1.51 1.51 1.48 1.48 1.48 1.48 1.47 1.47 1.47 1.47]; % [V]
% there were outliers in the 2nd and 12th entries... removing them here
err1 = 2;
err2 = 11;
ht_waterMass(err1) = [];
ht_waterMass(err2) = [];
ht_saltMass(err1) = [];
ht_saltMass(err2) = [];
ht_temp(err1) = [];
ht_temp(err2) = [];
ht_vout(err1) = [];
ht_vout(err2) = [];
ht_vin(err1) = [];
ht_vin(err2) = [];

ht_salinity = 1000 * ht_saltMass ./ (ht_saltMass + ht_waterMass); % [ppt]
ht_gain = ht_vout ./ ht_vin;

% Low temp resolution trials
lt_waterMass = [81.1 81.1 81.1 56.6 56.6 56.6 89.7 89.7 89.7]; % [mL]
lt_saltMass = [0.8 0.8 0.8 1.9 1.9 1.9 3.8 3.8 3.8]; % [g]
lt_temp = [10.4 16.5 24.1 11.8 15.6 20.1 9.8 15.1 20.3]; % [C]
lt_vout = [1.82 1.83 1.90 2.01 2.12 2.12 2.11 2.15 2.19]; % [V]
lt_vin = [1.53 1.52 1.51 1.50 1.48 1.48 1.48 1.48 1.48]; % [V]

lt_salinity = 1000 * lt_saltMass ./ (lt_saltMass + lt_waterMass); % [ppt]
lt_gain = lt_vout ./ lt_vin;

% more low temp resolution trials
x_waterMass = [38.0 38.0 38.0 38.0 38.0 38.0 38.0 69.1 69.1 69.1 69.1 69.1 69.1 69.1 89.7 89.7 89.7 89.7 89.7 89.7 89.7 81.1 81.1 81.1 81.1 81.1 81.1 81.1];
x_saltMass = [1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.6 1.6 1.6 1.6 1.6 1.6 1.6 3.8 3.8 3.8 3.8 3.8 3.8 3.8 0.8 0.8 0.8 0.8 0.8 0.8 0.8];
x_temp = [9.8 14.6 19.4 24.6 30.4 35.2 39.8 11.0 14.8 19.9 24.3 29.7 35.0 40.5 10 15.1 20.1 25.0 29.9 34.8 40.6 10.1 15.3 20.1 25.0 30.0 35.2 39.5];
x_vout =[1.955 1.987 2.016 2.042 2.088 2.097 2.139 1.994 2.008 2.053 2.070 2.092 2.142 2.162 2.075 2.094 2.147 2.188 2.182 2.212 2.225 1.735 1.758 1.835 1.867 1.908 1.938 2.021];
x_vin = [1.500 1.496 1.494 1.489 1.485 1.484 1.481 1.491 1.490 1.486 1.485 1.484 1.479 1.477 1.500 1.484 1.486 1.491 1.479 1.479 1.472 1.534 1.533 1.521 1.519 1.515 1.509 1.496];
x_salinity = 1000 * x_saltMass ./ (x_saltMass + x_waterMass);
x_gain = x_vout ./ x_vin;

salinity = [ht_salinity lt_salinity x_salinity];
temp = [ht_temp lt_temp x_temp];
gain = [ht_gain lt_gain x_gain];




% griddata fit
figure(1)
clf
hold on
view(3)
scatter3(salinity, temp, gain, 'filled', 'SizeData', 100)
[X, Y] = meshgrid(linspace(min(salinity), max(salinity), 100), linspace(min(temp), max(temp), 100));
Z = griddata(salinity, temp, gain, X, Y, "cubic");
surf(X, Y, Z);

xlabel("Salinity [ppt]")
ylabel("Temp [C]")
zlabel("Gain")
hold off

%trying to do polynomial fit here
% 2nd/3rd degree

figure(2)
clf
subplot(1, 2, 1);
hold on
view(3)
scatter3(salinity, temp, gain, 'filled', 'SizeData', 100);
[x,y,z] = meshgrid(linspace(min(salinity), max(salinity), 100), linspace(min(temp), max(temp), 100), linspace(min(gain), max(gain), 100));
[Zpoly23, gof23] = fit([salinity' temp'], gain', 'poly23')
plot(Zpoly23);
hold off
title("poly23")
xlabel("Salinity [ppt]")
ylabel("Temp [C]")
zlabel("Gain")


% 3rd/4th degree
subplot(1, 2, 2);
view(3)
hold on
scatter3(salinity, temp, gain, 'filled', 'SizeData', 100);
[x,y,z] = meshgrid(linspace(min(salinity), max(salinity), 100), linspace(min(temp), max(temp), 100), linspace(min(gain), max(gain), 100));
[Zpoly34, gof34] = fit([salinity' temp'], gain', 'poly34')
plot(Zpoly34);
title("poly34")
xlabel("Salinity [ppt]")
ylabel("Temp [C]")
zlabel("Gain")
hold off

