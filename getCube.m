%--------------------------------------------------------------------------

% Filename:     getCube.m
% Author:       Nicholas Rogers
% Version:      1.00
% Edit Date:    28/09/22

%--------------------------------------------------------------------------

% Description:

% Extract a 3D data cube from the multidimensional data structure. Output
% cube will be of the form [Channel][Chirp][Sample]

%--------------------------------------------------------------------------

function[output_data] = getFrame(input_data, frame)
    %Function Variables
    %----------------------------------------------------------------------
    % frame(int):       The frame index
    %----------------------------------------------------------------------
    
    %Get frame dimensions
    receivers = size(input_data, 1);
    chirps = size(input_data, 3);
    adc_samples = size(input_data, 4);
    
    
    output_data = reshape(input_data(:, frame, :,:), receivers, chirps, adc_samples);
    
    %----------------------------------------------------------------------
end
%--------------------------------------------------------------------------

