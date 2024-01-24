[accelX, accelY, accelZ] = read_data('sample_data', 'data');

startSampleNo = 1;
stopSampleNo = 10;%length(accelX)-1;
teensyAccelerationUnits = 2;

fh = figure;
set(fh, 'color', [1 1 1]);  

subplot(3, 1, 1);
plot(accelX(startSampleNo:stopSampleNo)*teensyAccelerationUnits);
title('X Acceleration');
xlabel('Time (Sample No.)') 
ylabel('Acceleration (m/s^2)') 

subplot(3, 1, 2);
plot(accelY(startSampleNo:stopSampleNo)*teensyAccelerationUnits);
title('Y Acceleration');
xlabel('Time (Sample No.)') 
ylabel('Acceleration (m/s^2)') 

subplot(3, 1, 3);
plot(accelZ(startSampleNo:stopSampleNo)*teensyAccelerationUnits);
title('Z Acceleration');
xlabel('Time (Sample No.)') 
ylabel('Acceleration (m/s^2)') 

print -dpng -r300 accel.png
