% logreader.m
% Use this script to read data from your micro SD card

clear;
%clf;

folder = 'data';
filenum = '_sample_data'; % file number for the data you want to read
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

%% Process your data here
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
