% File: plot_open_loop_run.m
% Author: Miranda Brandt
% Email: mgaribaybrandt@hmc.edu
% Date: 26 January 2024

clear;
%clf;

folder = 'data';
filenum = '025'; % file number for the data you want to read
infofile = strcat(folder, '/', 'INF', filenum, '.TXT');
datafile = strcat(folder, '/', 'LOG', filenum, '.BIN');

%% map from datatype to length in bytes
dataSizes.('float') = 4;
dataSizes.('ulong') = 4;
dataSizes.('int') = 4;
dataSizes.('int32') = 4;
dataSizes.('uint8') = 1;
dataSizes.('uint16') = 2;
dataSizes.('char') = 1;
dataSizes.('bool') = 1;

%% read from info file to get log file structure
fileID = fopen(infofile);
items = textscan(fileID,'%s','Delimiter',',','EndOfLine','\r\n');
fclose(fileID);
[ncols,~] = size(items{1});
ncols = ncols/2;
varNames = items{1}(1:ncols)';
varTypes = items{1}(ncols+1:end)';
varLengths = zeros(size(varTypes));
colLength = 256;
for i = 1:numel(varTypes)
    varLengths(i) = dataSizes.(varTypes{i});
end
R = cell(1,numel(varNames));

%% read column-by-column from datafile
fid = fopen(datafile,'rb');
for i=1:numel(varTypes)
    %# seek to the first field of the first record
    fseek(fid, sum(varLengths(1:i-1)), 'bof');
    
    %# % read column with specified format, skipping required number of bytes
    R{i} = fread(fid, Inf, ['*' varTypes{i}], colLength-varLengths(i));
    eval(strcat(varNames{i},'=','R{',num2str(i),'};'));
end
fclose(fid);

%% Data Plot of the Acceleration in the X, Y, and Z Axes

startSampleNo = 340;
stopSampleNo = 475; %length(accelX)-1;
teensyAccelerationUnits = 0.0102;

fh = figure;
set(fh, 'color', [1 1 1]);  

hold on
plot(accelX(startSampleNo:stopSampleNo)*teensyAccelerationUnits, 'LineWidth', 1.5);
plot(accelY(startSampleNo:stopSampleNo)*teensyAccelerationUnits, 'LineWidth', 1.5);
plot(accelZ(startSampleNo:stopSampleNo)*teensyAccelerationUnits, 'LineWidth',1.5);
title('Tank Obstacle Course: Open Loop Acceleration');
xlabel('Time [Sample No.]') 
ylabel('Acceleration [m/s^2]') 
h = legend('x', 'y', 'z')
set(h, 'Location', 'best')
fontsize(14, "points")

print -dpng -r300 accel.png
