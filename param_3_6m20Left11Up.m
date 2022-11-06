function[p] = param_3_6m20Left11Up()
    p.filename = './3_6m20Left11Up/adc_data.bin';  

    % Radar metadata
    p.nChannels = 4;            % Number of Rx channels
    p.nBits = 16;               % Number of ADC bits
    p.nTx = 1;
    
    % Chirp information
    p.nSamples = 256;           % Number of samples per chirp
    p.nChirpLoops = 128;        % Number of chirps per frame
    p.nChirps = p.nTx*p.nChirpLoops;
    p.nFrames = 100;            % Number of frames
    p.Fs = 10e6;                % Sampling rate
    p.t_sweep = 60e-6;          % Ramp end time [s]
    p.t_chirp = 40e-3;          % Chirp time (frame periodicity)
    p.bw = 1798.92e6;           % RF bandwidth
    p.Fc = 77e9+(p.bw/2);       % Center frequency
    
    %Target information
    p.theta = -20;              % Angle of Arrival
    p.elev = 0;                 % Angle of elevation 
    p.range = 3.6;              % Radial range of target in meters
    
    p.rBin = 23;                % Manually selected range bin of target
    p.dBin = 65;                % Manually selected doppler bin of target
end