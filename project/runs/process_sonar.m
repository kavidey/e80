function [dist, dist_time] = process_sonar(burst_file_name, angle)
T = readtable(burst_file_name);
data = table2array(T);

num_samples = size(data, 1)/6;

teensy_conversion = 3.3/2^10;

dist_time = [];
dist = [];
for i = 0:(num_samples-1)
    t1 = data(i*6+1, :) * 1e-6;
    doppler = data(i*6+2, :) * teensy_conversion;
    t2 = data(i*6+4, :) * 1e-6;
    tof = data(i*6+6, :) * teensy_conversion;
    tof_smooth = smoothdata(tof, 'gaussian', 10);
    
    [l,s] = runlength(tof_smooth>0.25, 1e5);
    
    total_time = mean(l(~s & l > 5 & l < 200)) * (t2(1)-t2(2));
    dist = [dist 1500 * total_time/2];
    dist_time = [dist_time t2(1)];
end

end

% Testing Code
% burst_file_name = "Dana Point/run 6/sonar_030"
% T = readtable(burst_file_name);
% data = table2array(T);

% num_samples = size(data, 1)/6

% teensy_conversion = 3.3/2^10;

% test_sample_no = 15
% t1 = data(test_sample_no*6+1, :) * 1e-6;
% doppler = data(test_sample_no*6+2, :) * teensy_conversion;
% t2 = data(test_sample_no*6+4, :) * 1e-6;
% tof = data(test_sample_no*6+6, :) * teensy_conversion;
% tof_smooth = smoothdata(tof, 'gaussian', 10);

% nexttile
% plot(t1, doppler)

% nexttile
% plot(t2, tof_smooth)

% [l,s] = runlength(tof_smooth>0.25, 1e5);

% total_time = mean(l(~s & l > 5 & l < 200)) * (t2(1)-t2(2));
% dist = 1500 * total_time/2