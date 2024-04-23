%%
addpath(genpath("../code"))

teensy_conversion = 3.3/2^10;

%% run 1 (contains files 000-014) in general temp and gps are only working sensors
% 000-001 has nothing
% 002 has a long deployment
% 003 super short deployment
% 004 medium deployment
% 005 medium deployment
% 006 super short deployment, data looks kinda weird
% 007 nothing
% 008 nothing
% 009 super short deployment
% 010-013 temp is high, out of water?
% 014 really good long deployment

% overall notes: 014 is best, 002-005 may have additional good data
[rollIMU,pitchIMU,headingIMU,accelX,accelY,accelZ,magX,magY,magZ,lat,lon,nsats,x,y,u,uL,uR,yaw,yaw_des,motorA,motorB,motorC,Current_Sense,A00,A01,A02,A03,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,ErrorFlagA,ErrorFlagB,ErrorFlagC] = read_data('run_014', 'Dana Point/run 1');
time = double(A14) * 1e-3;
temp_voltage = double(A00) * teensy_conversion;

tiledlayout("vertical")
nexttile
geoplot(lat(lat ~= 0), lon(lat ~= 0));
geobasemap satellite

nexttile
plot(time, VtoT(temp_voltage));
ylim([0 25])

nexttile
[salinity, salinity_time] = process_salinity("Dana Point/run 1/salinity_014", 3);
plot(salinity_time, salinity)
%% run 2 (contains 016) only temp
% still only temp working, but measuring several degrees too high - ignore (seems like robot never went in water?)
% [rollIMU,pitchIMU,headingIMU,accelX,accelY,accelZ,magX,magY,magZ,lat,lon,nsats,x,y,u,uL,uR,yaw,yaw_des,motorA,motorB,motorC,Current_Sense,A00,A01,A02,A03,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,ErrorFlagA,ErrorFlagB,ErrorFlagC] = read_data('run_016', 'Dana Point/run 2');
% time = double(A14) * 1e-3;
% temp_voltage = double(A00) * teensy_conversion;

% tiledlayout("vertical")
% nexttile
% geoplot(lat(lat ~= 0), lon(lat ~= 0));
% geobasemap satellite

% nexttile
% plot(time, VtoT(temp_voltage));
% ylim([0 25])

%% run 3 (contains 018) only temp
% gps got really messed up, but temperature data looks super good, nice long deployment
[rollIMU,pitchIMU,headingIMU,accelX,accelY,accelZ,magX,magY,magZ,lat,lon,nsats,x,y,u,uL,uR,yaw,yaw_des,motorA,motorB,motorC,Current_Sense,A00,A01,A02,A03,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,ErrorFlagA,ErrorFlagB,ErrorFlagC] = read_data('run_018', 'Dana Point/run 3');
time = double(A14) * 1e-3;
temp_voltage = double(A00) * teensy_conversion;

tiledlayout("vertical")
nexttile
geoplot(lat(lat ~= 0), lon(lat ~= 0));
geobasemap satellite

nexttile
plot(time, VtoT(temp_voltage));
ylim([0 25])

nexttile
[salinity, salinity_time] = process_salinity("Dana Point/run 3/salinity_018", 4);
plot(salinity_time, salinity)
%% run 4 (contains 022) only temp
% temp and gps both look pretty good!!
[rollIMU,pitchIMU,headingIMU,accelX,accelY,accelZ,magX,magY,magZ,lat,lon,nsats,x,y,u,uL,uR,yaw,yaw_des,motorA,motorB,motorC,Current_Sense,A00,A01,A02,A03,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,ErrorFlagA,ErrorFlagB,ErrorFlagC] = read_data('run_022', 'Dana Point/run 4');
time = double(A14) * 1e-3;
temp_voltage = double(A00) * teensy_conversion;

tiledlayout("vertical")
nexttile
geoplot(lat(lat ~= 0), lon(lat ~= 0));
geobasemap satellite

nexttile
plot(time, VtoT(temp_voltage));
ylim([0 25])

nexttile
[salinity, salinity_time] = process_salinity("Dana Point/run 4/salinity_022", 4);
plot(salinity_time, salinity)

%% run 5 (contains 029) temp and salinity, gps is rlly messed up
[rollIMU,pitchIMU,headingIMU,accelX,accelY,accelZ,magX,magY,magZ,lat,lon,nsats,x,y,u,uL,uR,yaw,yaw_des,motorA,motorB,motorC,Current_Sense,A00,A01,A02,A03,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,ErrorFlagA,ErrorFlagB,ErrorFlagC] = read_data('run_029', 'Dana Point/run 5');
time = double(A14) * 1e-3;
temp_voltage = double(A00) * teensy_conversion;

tiledlayout("vertical")
nexttile
geoplot(lat(lat ~= 0), lon(lat ~= 0));
geobasemap satellite

nexttile
plot(time, VtoT(temp_voltage));
ylim([0 25])

nexttile
[salinity, salinity_time] = process_salinity("Dana Point/run 5/salinity_029", 4);
plot(salinity_time, salinity)

%% run 6 (contains 030) sonar only, gps is really messed up
[rollIMU,pitchIMU,headingIMU,accelX,accelY,accelZ,magX,magY,magZ,lat,lon,nsats,x,y,u,uL,uR,yaw,yaw_des,motorA,motorB,motorC,Current_Sense,A00,A01,A02,A03,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,ErrorFlagA,ErrorFlagB,ErrorFlagC] = read_data('run_030', 'Dana Point/run 6');
time = double(A14) * 1e-3;

tiledlayout("vertical")
nexttile
geoplot(lat(lat ~= 0), lon(lat ~= 0), 'LineWidth', 2);
geobasemap satellite

nexttile
[dist, dist_time] = process_sonar("Dana Point/run 6/sonar_030", 90);
plot(dist_time, -dist);

%% run 7 (contains 033) sonar only, looks a bit wonky
[rollIMU,pitchIMU,headingIMU,accelX,accelY,accelZ,magX,magY,magZ,lat,lon,nsats,x,y,u,uL,uR,yaw,yaw_des,motorA,motorB,motorC,Current_Sense,A00,A01,A02,A03,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,ErrorFlagA,ErrorFlagB,ErrorFlagC] = read_data('run_033', 'Dana Point/run 7');
time = double(A14) * 1e-3;

tiledlayout("vertical")
nexttile
geoplot(lat(lat ~= 0), lon(lat ~= 0), 'LineWidth', 2);
geobasemap satellite

nexttile
[dist, dist_time] = process_sonar("Dana Point/run 7/sonar_033", 90);
plot(dist_time, -dist);

%% runs 8-9 (contains 034-039) sonar only
% 034 nothing
% 035 should have something because file is reasonably large and gps looks good, but sonar doesn't show anything (more investigation needed?)
% 036-038 nothing
% 039 having some trouble with processing sonar but looks like it will be REALLY good
[rollIMU,pitchIMU,headingIMU,accelX,accelY,accelZ,magX,magY,magZ,lat,lon,nsats,x,y,u,uL,uR,yaw,yaw_des,motorA,motorB,motorC,Current_Sense,A00,A01,A02,A03,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,ErrorFlagA,ErrorFlagB,ErrorFlagC] = read_data('run_039', 'Dana Point/run 8-9');
time = double(A14) * 1e-3;

tiledlayout("vertical")
nexttile
geoplot(lat(lat ~= 0), lon(lat ~= 0), 'LineWidth', 2);
geobasemap satellite

nexttile
[dist, dist_time] = process_sonar("Dana Point/run 8-9/sonar_039", 90);
plot(dist_time, -dist);