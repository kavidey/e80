% Miranda Brandt
% Kavi Dey 
% Salinity Processing Code 

function [salinity, time] = process_salinity(burst_file_name, rows_per_sample, temp)
T = readtable(burst_file_name);
data = table2array(T);

num_samples = length(data)/rows_per_sample;

teensy_conversion = 3.3/2^10;

time = [];
salinity = [];

load('salinityfits.mat')

for i = 0:(num_samples-1)
    %create sample time array 
    time = [time data(i*rows_per_sample+1, 1) * 1e-6]; %Fix Time 
    samp_time = data(i*rows_per_sample+1, :) * 1e-6;
    % VALID DATA CHECK
    vin = data(i*rows_per_sample+2, :) * teensy_conversion;
    vout = data(i*rows_per_sample+3, :) * teensy_conversion;
    %Finding the gain
    diff = samp_time(1) - samp_time(2);
    fs = 1/diff;
    N = length(vin);
    f0 = fs/N; %Fundamental Frequency
    X = fft(vin)/N;
    X2 = fft(vout)/N;

    true_vin = max(X);
    true_vout = max(X2);
    %L1 vin L2 vout new_t is time 
    Gain = true_vout/true_vin;
    salinity = [salinity Zpoly23(Gain, temp)];
end

end

% %Plot vin and vout
% plot(f, abs(X), 'b');
% hold on 
% plot(f, abs(X2), 'r');
% hold off
% legend('vin', 'vout')
% xlabel('Frequency (Hz)');
% ylabel('Values (Voltage)');
% xlim([0,inf]);
% 
% temps = 16;
% salinity = Zpoly23(Gain, temps)