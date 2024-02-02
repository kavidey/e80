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

Vrms = double((Vpp/2)/sqrt(2)) * (3.3/2^10)

% Y = fft(teensy_data);
% % Because Fourier transforms involve complex numbers, plot the complex magnitude of the fft spectrum.
% 
% plot(abs(Y),"LineWidth",3)
% title("Complex Magnitude of fft Spectrum")
% xlabel("f (Hz)")
% ylabel("|fft(X)|")