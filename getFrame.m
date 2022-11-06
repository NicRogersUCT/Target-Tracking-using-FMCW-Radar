%--------------------------------------------------------------------------

% Filename:     getFrame.m
% Author:       William Bourn
% Version:      1.00
% Edit Date:    13/03/22

%--------------------------------------------------------------------------

% Description:

% Extract a single frame from the multidimensional data structure

%--------------------------------------------------------------------------

function[output_data] = getFrame(input_data, channel,frame)
    %Function Variables
    %----------------------------------------------------------------------
    % channel(int):     The channel index
    % frame(int):       The frame index
    %----------------------------------------------------------------------
    
    %Get frame dimensions
    chirps = size(input_data,3);
    adc_samples = size(input_data,4);
    
    
    output_data = reshape(input_data(channel, frame, :,:),chirps,adc_samples);
    
    %----------------------------------------------------------------------
end
%--------------------------------------------------------------------------