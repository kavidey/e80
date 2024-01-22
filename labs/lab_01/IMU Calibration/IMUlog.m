% logreader.m
% Use this script to read data from your micro SD card

clear;
%clf;

filenam = '_SampleData'; % file name for the data you want to read
infofile = strcat('INF', filenam, '.TXT');
datafile = strcat('LOG', filenam, '.BIN');

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
Prompt = "Choose Acceleration Axis ";
x = input(Prompt);

plot(x)
xlabel('Time(Sample Number)'), ylabel('Acceleration')
title('Acceleration vs. Time')
M = mean(x) %plot mean as horizontal line 
yline(M)
S = std(x)
SE = std(x)/sqrt(x(4:29))
confLev=0.95
%y=filter(y-10,:);

%accelX, accelY, accelZ plots
%choose, plot + calculations 
%sample number to start and stop start at 10th, stop at 50th example
% 95 percent confidence
%bounds for a static acceleration measurement in the z direction 
%zero acceleration on each axis?
% find one 'accelerometer unit'
%teensy units divide gravity by mean of z axis
%ANOVA for comparing zero values 

