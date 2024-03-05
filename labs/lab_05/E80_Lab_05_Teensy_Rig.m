%% Lab 5 Interface

samplingFreq = 100E3; % Hz [100E3 max]
numSamples = 1000; % the higher this is the longer sampling will take

bytesPerSample = 2; % DO NOT CHANGE
micSignal = zeros(numSamples,1); % DO NOT CHANGE

% close and delete serial ports in case desired port is still open
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end

% Modify first argument of serial to match Teensy port under Tools tab of Arduino IDE.  Second to match baud rate.
% Note that the timeout is set to 60 to accommodate long sampling times.
s = serial('COM10','BaudRate',115200); 
set(s,{'InputBufferSize','OutputBufferSize'},{numSamples*bytesPerSample,4});
s.Timeout = 60; 

fopen(s);
pause(2);
fwrite(s,[numSamples,samplingFreq/2],'uint16');
dat = fread(s,numSamples,'uint16');
fclose(s);

% Some convenience code to begin converting data for you.
micSignal = dat.*(3.3/1023); % convert from Teensy Units to Volts
samplingPeriod = 1/samplingFreq; % s
totalTime = numSamples*samplingPeriod; % s
t = linspace(0,totalTime,numSamples)'; % time vector of signal

% saving data
filename = append('teensy_sampling_data_', int2str(samplingFreq) )
save(filename, "micSignal", "samplingFreq", "numSamples")

% % make fake data
% micSignal = sin(2*pi*t*samplingFreq/10);

% plotting ... a lot of this data is from matlab fft documentation
signalFull = fft(micSignal);
signalCropped = signalFull(1:numSamples/2+1);
signal = (1/numSamples)*abs(signalCropped);
signal(2:end) = 2*signal(2:end)
figure(1)
clf
f = samplingFreq/numSamples*(0:numSamples/2)
plot(f, signal);
title(sprintf('Plot of FFT of Teensy Data, Sampling Rate of ', samplingFreq, ' samples per seccond'))

figure(2)
clf
plot(t(1:100), micSignal(1:100))
title(sprintf('First 100 Samples of Data from Teensy with Sampling Rate of ', samplingFreq, ' Hz'))