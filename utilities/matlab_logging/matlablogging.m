% matlablogging
% reads from Teensy data stream

function teensyanalog=matlablogging(length)
    length = 10000;  % 5000 is hardcoded buffer size on Teensy
    s = serial('/dev/cu.usbmodem138398401','BaudRate',115200);
    set(s,'InputBufferSize',2*length)
    fopen(s);
    fprintf(s,'%d',2*length)         % Send length to Teensy
    dat = fread(s,2*length,'uint8');      
    fclose(s);
    teensyanalog = uint8(dat);
    teensyanalog = typecast(teensyanalog,'uint16');
    teensyanalog = cast(teensyanalog, 'double');
end


%str = fscanf(s);
%teensyanalog = str2num(str);,

%[teensyanalog, count] = fscanf(s,['%d']);