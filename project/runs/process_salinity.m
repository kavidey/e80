function [salinity, time] = process_salinity(burst_file_name, rows_per_sample)
T = readtable(burst_file_name);
data = table2array(T);

num_samples = length(data)/rows_per_sample;

teensy_conversion = 3.3/2^10;

time = [];
salinity = [];
for i = 0:(num_samples-1)
    time = [time data(i*rows_per_sample+1, 1) * 1e-6];
    % THIS DOES NOT ACTUALLY CALCULATE SALINITY, IT JUST TELLS US IF THERE IS VALID DATA
    vin = data(i*rows_per_sample+2, :) * teensy_conversion;
    vout = data(i*rows_per_sample+3, :) * teensy_conversion;
    salinity = [salinity max(vin)];
end

end