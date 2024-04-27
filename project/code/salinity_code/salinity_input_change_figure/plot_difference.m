%% Air
[wfm_air, metadata] = read_h5('data/scope_0.h5');

for i = 1:length(metadata(1, :))
    entry = metadata(1, i); 
    entry.Name;
    entry.Value;
    switch entry.Name
        case 'XInc'
            Fs = 1/entry.Value;
    end
end

t_air = (1:length(wfm(1,:))) / Fs;
%% Water
[wfm_water, metadata] = read_h5('data/scope_72.h5');

for i = 1:length(metadata(1, :))
    entry = metadata(1, i); 
    entry.Name;
    entry.Value;
    switch entry.Name
        case 'XInc'
            Fs = 1/entry.Value;
    end
end

t_water = (1:length(wfm(1,:))) / Fs;
%%
R2 = 15e3;
R1 = 10e3;
divider = R2/(R1+R2);

clf
set(0,'DefaultLineLineWidth',1.5)
title("Phase Shift Oscillator Output in Air and Water")
hold on
plot(t_air, smoothdata(wfm_air,"movmean", 2)/divider, "DisplayName", "Air");
plot(t_water, smoothdata(wfm_water,"movmean", 2)/divider, "DisplayName", "Water (50ppt Salinity)");
hold off

ylabel("Voltage [V]")
xlabel("Time [s]")
legend("Orientation", 'horizontal', 'Location', 'best')

ylim([0 5])

set(gcf, "Color", 'w')
fontsize(gcf, 15, "points")

exportgraphics(gca,'salinity_oscillator_output.eps','BackgroundColor','none', 'Resolution', 300)
