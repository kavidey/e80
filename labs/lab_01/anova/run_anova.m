% load files
[accelX_zero, accelY_zero, accelZ] = read_data('sample_data', 'data');
[accelX, accelY, accelZ_zero] = read_data('sample_data', 'data');

% crop data to region we care about
f1start = 1;
f1end = 60;

f2start = 1;
f2end = 60;

accelX_zero = accelX_zero(f1start:f1end);
accelY_zero = accelY_zero(f1start:f1end);
accelZ_zero = accelZ_zero(f2start:f2end);

% plot all axes
teensyAccelerationUnits = 2;

fh = figure;
set(fh, 'color', [1 1 1]);  

subplot(3, 1, 1);
plot(accelX_zero*teensyAccelerationUnits);
title('X Acceleration');
xlabel('Time (Sample No.)') 
ylabel('Acceleration (m/s^2)') 

subplot(3, 1, 2);
plot(accelY_zero*teensyAccelerationUnits);
title('Y Acceleration');
xlabel('Time (Sample No.)') 
ylabel('Acceleration (m/s^2)') 

subplot(3, 1, 3);
plot(accelZ_zero*teensyAccelerationUnits);
title('Z Acceleration');
xlabel('Time (Sample No.)') 
ylabel('Acceleration (m/s^2)') 

print -dpng -r300 accel.png

% Run anova

zero_acceleration_matrix = horzcat(accelX_zero, accelY_zero, accelZ_zero);

[p,tbl,stats] = anova1(zero_acceleration_matrix)
set(gcf, 'color', [1 1 1]);

title('Zero Acceleration on All Axes');
xticks([1 2 3])
xticklabels({'X','Y','Z'})
xlabel('Axis');
ylabel('Acceleration (m/s^2)');

print -dpng -r300 anova_boxplot.png
% exportapp(gcf, 'anova_boxplot.png')