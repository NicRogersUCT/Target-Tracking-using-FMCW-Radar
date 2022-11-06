function[p] = param_Small3m()
    p.filename = './SmallTarget3m/adc_data.bin';

    % Radar metadata
    p.nChannels = 4;            % Number of Rx channels
    p.nBits = 16;               % Number of ADC bits
    
    % Chirp information
    p.nSamples = 256;           % Number of samples per chirp
    p.nChirps = 128;            % Number of chirps per frame
    p.nFrames = 100;            % Number of frames

    p.Fs = 10e6;                % Sampling rate
    p.t_sweep = 60e-6;          % Ramp end time [s]
    p.t_chirp = 40e-3;          % Chirp time (frame periodicity)
    p.bw = 1798.92e6;           % RF bandwidth
    p.Fc = 77e9+(p.bw/2);       % Center frequency
       
end