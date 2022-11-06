function[p] = param_Small7m()
    p.filename = './SmallTarget7m/adc_data.bin';  

    % Radar metadata
    p.nChannels = 4;            % Number of Rx channels
    p.nBits = 16;               % Number of ADC bits
    
    % Chirp information
    p.nSamples = 512;           % Number of samples per chirp
    p.nChirps = 255;            % Number of chirps per frame
    p.nFrames = 500;            % Number of frames

    p.Fs = 2e6;                 % Sampling rate
    p.Fc = 60e9;                % Center frequency
    p.t_sweep = 1001e-6;        % Ramp end time [s]
    p.t_chirp = 260e-3;         % Chirp time (frame periodicity)
    p.bw = 3986.98e6;           % RF bandwidth
end