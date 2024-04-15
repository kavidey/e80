% Miranda Brandt
% Salinity Code Analysis

%lists of outputs (L2) and inputs (L1) for salinity
clear
L1 = [121   186   587   779   582   244   112   268   681   764   491   177   120   374   744   722   399   139   145   493   777   653   305   117   201   610   777   561   227   112   290   699 757   470   165   124   402   753   709   379   134   153   515   779   636   294   116   212   624   776   549   217   113   305   709   752   457   159   127   419   758   700   366   131 159   536   780   625   281   114   225   640   773   534   206   115   325   720   744   441   153   131   438   764   688   352   127   168   552   780   610   268   113   239   654   771 521   197   116   340];
L2 = [0     1     0     0     1     0     0     0     0     0     0     1     2     0     0     0     0     0     5     0     0     0     0     0     0     0     0     0     0     0     0     0  0     0     0     4     0     0     0     0     0     5     0     0     0     0     0     0     0     0     0     0     0     0     1     0     0     1     4     0     0     0     0     0 4     0     0     0     0     0     0     0     0     0     0     1     0     0     0     0     0     5     0     0     0     1     0     3     0     0     1     0     0     0     0     0 0     0     2     0];
t_data = [4452910     4452901     4452891     4452882     4452872     4452863     4452853     4452844     4452834     4452825     4452815     4452805     4452796     4452786     4452777     4452767 4452758     4452748     4452739     4452729     4452720     4452710     4452700     4452691     4452681     4452672     4452662     4452652     4452643     4452633     4452624     4452614 4452605     4452595     4452586     4452576     4452567     4452557     4452547     4452538     4452528     4452519     4452509     4452500     4452490     4452481     4452471     4452462 4452452     4452442     4452433     4452423     4452414     4452404     4452395     4452385     4452376     4452366     4452357     4452347     4452337     4452328     4452318     4452309 4452299     4452290     4452280     4452271     4452261     4452251     4452242     4452232     4452223     4452213     4452204     4452194     4452185     4452175     4452166     4452156 4452146     4452137     4452127     4452118     4452108     4452099     4452089     4452080     4452070     4452061     4452051     4452041     4452032     4452022     4452013     4452003 4451994     4451984     4451975     4451964];

%sampling rate; converted from 100kHz
fs = 10^5; %Hz

%Fourier Transform of L1
N = length(L1);
f0 = fs/N; %Fundamental Frequency
X = fft(L1)/N;
k = [floor(-N/2):floor(N/2)-1];
f = k*f0;

%Plot 

% 
% %Fourier Transform of L2
% N2 = length(L2);
% f0 = fs/N2; %Fundamental Frequency
% X = fft(L2)/N2;
% 
% %Plot 2
% 
% 
% 
% 
% 
% 
% fft() % only consider poisitve frequencies 
% 
% 
% mag_freq = 
% 
% v_in = 
% v_out = 
% 
% %apply voltage divider equation
% R2 = 67 %Ohms
% p_res = ((v_in-v_out)*R2)/v_out; 
% 
% Write voltage to salinity/temperature code
% Write resistance to salinity code (will require voltage to resistance code)
% 
% Write matlab function that takes two lists of 100 measurements (100 of the input, 100 of the output) and calculates the resistance of the probe
% Write matlab function that takes probe resistance and calculates salinity
% This can either be based on the physics or just the result of a fit
% 
% 1. take the fourier transform of both signals
% 2. find the magnitude of the frequency bin that corresponds to frequency of the phase shift oscillator (those magnitudes are vin and vout of the voltage divider)
% 3. use the voltage divider formula and known resistance of r2 (~67 ohm) to determine the resistance of the salinity sensor
