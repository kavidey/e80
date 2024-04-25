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
    
    % tof_smooth = smoothdata(tof, 'gaussian', 10);
    
    % [l,s] = runlength(tof_smooth>0.25, 1e5);
    
    % total_time = mean(l(~s & l > 5 & l < 200)) * (t2(1)-t2(2));
    % d = 1500 * total_time/2;
    
    fs = 1 / ((t2(1) - t2(end)) / length(t2));
    
    tof_smooth2 = smoothdata(tof, "gaussian", 10);

    min_dist = 0.05; % [m]
    approx_speed_of_sound = 1500; % [m/s]
    min_time = min_dist / approx_speed_of_sound;
    
    max_dist = 5; % [m]
    max_time = max_dist / approx_speed_of_sound;
    
    [pk,lc] = findpeaks(tof_smooth2, fs, 'MinPeakDistance', min_time, 'MinPeakHeight', 0.15, 'MinPeakProminence', 0.1);
    
    filtered_tof = [];
    for i = 1:length(lc)-1
        tdiff = lc(i+1)-lc(i);
        if (tdiff < max_time)
            filtered_tof = [filtered_tof tdiff];
        end
    end
    d = 1500 * mean(filtered_tof)/2;
    
    dist = [dist d];
    dist_time = [dist_time t2(1)];
end
end

% Testing Code
% burst_file_name = "Dana Point/run 8-9/sonar_039"
% T = readtable(burst_file_name);
% data = table2array(T);

% num_samples = size(data, 1)/6

% teensy_conversion = 3.3/2^10;

% test_sample_no = 38;
% t1 = data(test_sample_no*6+1, :) * 1e-6;
% doppler = data(test_sample_no*6+2, :) * teensy_conversion;
% t2 = data(test_sample_no*6+4, :) * 1e-6;
% tof = data(test_sample_no*6+6, :) * teensy_conversion;

% fs = 1 / ((t2(1) - t2(end)) / length(t2));

% clf
% nexttile
% hold on
% plot(t2, tof);
% tof_smooth1 = smoothdata(tof, 'rloess', 10);
% plot(t2, tof_smooth1);
% tof_smooth2 = smoothdata(tof, "gaussian", 10);
% plot(t2, tof_smooth2);
% % xlim([151.328 151.33])
% hold off

% nexttile
% hold on

% min_dist = 0.05; % [m]
% approx_speed_of_sound = 1500; % [m/s]
% min_time = min_dist / approx_speed_of_sound;

% max_dist = 5; % [m]
% max_time = max_dist / approx_speed_of_sound;

% [pk,lc] = findpeaks(tof_smooth2, fs, 'MinPeakDistance', min_time, 'MinPeakHeight', 0.15, 'MinPeakProminence', 0.1);
% plot(t2, tof_smooth2)
% plot(t2(1) - lc,pk,'x')

% hold off

% filtered_tof = []
% for i = 1:length(lc)-1
%     tdiff = lc(i+1)-lc(i);
%     if (tdiff < max_time)
%         filtered_tof = [filtered_tof tdiff];
%     end
% end

% dist = 1500 * mean(filtered_tof)/2