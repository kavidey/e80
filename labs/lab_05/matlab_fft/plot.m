[wfm, metadata] = read_h5('data.h5');

for i = 1:length(metadata(1, :))
    entry = metadata(1, i); 
    entry.Name
    entry.Value
    switch entry.Name
        case 'XInc'
            Fs = 1/entry.Value;
    end
end

t = (1:length(wfm(1,:))) / Fs;