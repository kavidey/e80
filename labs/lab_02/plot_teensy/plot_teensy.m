% If you get an error that looks like:
%
% Error using serial/fopen
% Open failed: Port: COM7 is not available
%
% open matlablogging.m and replace COM7 with the correct port as described
% in the lab manual

teensy_data = matlablogging();

plot(teensy_data);

max_t = max(teensy_data)
min_t = min(teensy_data)

Vpp = max_t - min_t

Vrms = (Vpp/2)/sqrt(2)