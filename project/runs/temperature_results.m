%%
addpath(genpath("../code"))

teensy_conversion = 3.3/2^10;
lat_origin = 33.462663;
lon_origin = -117.704884;

ground_truth_times = [datetime(2024,4,20,8,54,0) datetime(2024,4,20,10,16,0)];
ground_truth_temps = [15.9 16.4];

measured_times = [];
measured_temps = [];
%% run 1 (contains files 000-014) in general temp and gps are only working sensors (8:50 AM)

measured_times = [measured_times datetime(2024,4,20,8,50,0)];

[rollIMU,pitchIMU,headingIMU,accelX,accelY,accelZ,magX,magY,magZ,lat,lon,nsats,x,y,u,uL,uR,yaw,yaw_des,motorA,motorB,motorC,Current_Sense,A00,A01,A02,A03,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,ErrorFlagA,ErrorFlagB,ErrorFlagC] = read_data('run_014', 'Dana Point/run 1');
time = double(A14) * 1e-3;
temp_voltage = double(A00) * teensy_conversion;

start_t = 76;
end_t = 316;
f_time = time(time > start_t & time < end_t);
f_temp_voltage = temp_voltage(time > start_t & time < end_t);

measured_temps = [measured_temps mean(VtoT(f_temp_voltage))];

figure(1)
clf
tiledlayout()
nexttile([1 3])
hold on
plot(f_time, VtoT(f_temp_voltage), 'DisplayName', 'Raw Temperature');
plot(f_time, smoothdata(VtoT(f_temp_voltage) ,"rloess", 1000), 'DisplayName', 'Smoothed Temperature');
xlim([start_t end_t])
ylim([0 25])
ylabel("Temperature [C]")
xlabel("Time [s]")
legend()
hold off
%% run 3 (contains 018) only temp (9:13 AM)
% gps got really messed up, but temperature data looks super good, nice long deployment
measured_times = [measured_times datetime(2024,4,20,9,13,0)];
[rollIMU,pitchIMU,headingIMU,accelX,accelY,accelZ,magX,magY,magZ,lat,lon,nsats,x,y,u,uL,uR,yaw,yaw_des,motorA,motorB,motorC,Current_Sense,A00,A01,A02,A03,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,ErrorFlagA,ErrorFlagB,ErrorFlagC] = read_data('run_018', 'Dana Point/run 3');
time = double(A14) * 1e-3;
temp_voltage = double(A00) * teensy_conversion;

start_t = 200;
end_t = 367;
f_time = time(time > start_t & time < end_t);
f_temp_voltage = temp_voltage(time > start_t & time < end_t);

measured_temps = [measured_temps mean(VtoT(f_temp_voltage))];

%% run 4 (contains 022) only temp (9:25 AM)
% temp and gps both look pretty good!!
measured_times = [measured_times datetime(2024,4,20,9,25,0)];
[rollIMU,pitchIMU,headingIMU,accelX,accelY,accelZ,magX,magY,magZ,lat,lon,nsats,x,y,u,uL,uR,yaw,yaw_des,motorA,motorB,motorC,Current_Sense,A00,A01,A02,A03,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,ErrorFlagA,ErrorFlagB,ErrorFlagC] = read_data('run_022', 'Dana Point/run 4');
time = double(A14) * 1e-3;
temp_voltage = double(A00) * teensy_conversion;

start_t = 85;
end_t = 203;
f_time = time(time > start_t & time < end_t);
f_temp_voltage = temp_voltage(time > start_t & time < end_t);

measured_temps = [measured_temps mean(VtoT(f_temp_voltage))];
%% run 5 (contains 029) temp and salinity, gps is rlly messed up (10:10 AM)
measured_times = [measured_times datetime(2024,4,20,10,10,0)];
[rollIMU,pitchIMU,headingIMU,accelX,accelY,accelZ,magX,magY,magZ,lat,lon,nsats,x,y,u,uL,uR,yaw,yaw_des,motorA,motorB,motorC,Current_Sense,A00,A01,A02,A03,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,ErrorFlagA,ErrorFlagB,ErrorFlagC] = read_data('run_029', 'Dana Point/run 5');
time = double(A14) * 1e-3;
temp_voltage = double(A00) * teensy_conversion;

start_t = 100;
end_t = 290;
f_time = time(time > start_t & time < end_t);
f_temp_voltage = temp_voltage(time > start_t & time < end_t);

measured_temps = [measured_temps mean(VtoT(f_temp_voltage))];

%%
figure(2)
clf
hold on
scatter(ground_truth_times, ground_truth_temps, "filled", "DisplayName", "Ground Truth Temperature")
scatter(measured_times, measured_temps, "filled", "DisplayName", "Measured Temperature")
hold off
ylim([0 20])
legend('location', 'best')
set(gcf, "Color", 'w')
fontsize(gcf, 15, "points")