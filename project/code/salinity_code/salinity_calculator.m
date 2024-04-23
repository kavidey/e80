function salinity = salinity_calculator(vin, vout, temp)
% Do FFT on vin and vout
% Calculate gain
load('salinityfits.mat');
salinity = Zpoly23(gain, temp);
end