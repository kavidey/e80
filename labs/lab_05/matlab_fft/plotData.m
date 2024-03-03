[wfm, metadata] = read_h5('rect_03.h5');

for i = 1:length(metadata(1, :))
    entry = metadata(1, i); 
    entry.Name
    entry.Value
    switch entry.Name
        case 'XInc'
            Fs = 1/entry.Value;
    end
end

T = 1/Fs; % Sampling period

% Signal 3
L = length(wfm); % Legth of signal
t = (1:length(wfm(1,:))) / Fs; % Time vector
s3 = wfm; % Signal 3
Y3 = fft(s3.*hann(L)');
% Y3 = fft(s3);
P23 = abs(Y3/L);
P13 = P23(1:L/2+1);
P13(2:end-1) = 2*P13(2:end-1);
f = Fs/L*(0:(L/2));

plot(f(1:1000),P13(1:1000))
title("Single-Sided Amplitude Spectrum of Signal 3 (Hanning Window)")
xlabel("F [Hz]")
ylabel("Magnitude")
yscale log