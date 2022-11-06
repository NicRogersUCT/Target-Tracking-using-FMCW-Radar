function[p] = param_4elev_test()
    p.filename = './ElevTest/adc_data.bin';  

    % Radar metadata
    p.nChannels = 4;            % Number of Rx channels
    p.nTx = 3;                  % Number of Tx channels
    p.nBits = 16;               % Number of ADC bits
    
    % Chirp information
    p.nSamples = 256;           % Number of samples per chirp
    p.nChirpLoops = 43;         % Number of chirp loops per frame
    p.nChirps = p.nTx*p.nChirpLoops;
    p.nFrames = 8;              % Number of frames
    p.Fs = 10007e3;             % Sampling rate
    p.t_sweep = 60e-6;          % Ramp end time [s]
    p.t_chirp = 40e-3;          % Chirp time (frame periodicity)
    p.bw = 1798.92e6;           % RF bandwidth
    p.Fc = 77e9+(p.bw/2);       % Center frequency
    
    %Target information
    p.theta = 20;               % Angle of Arrival
    p.elev = 8;                 % Angle of elevation 
    p.range = 4;                % Radial range of target in meters
    
    p.rBin = 24;                % Manually selected range bin of target
    p.dBin = 65;                % Manually selected doppler bin of target
end