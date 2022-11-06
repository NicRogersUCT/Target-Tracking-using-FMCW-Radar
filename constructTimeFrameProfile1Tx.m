
%--------------------------------------------------------------------------

% Filename:     constructTimeFrameProfile.m
% Author:       William Bourn
% Version:      1.00
% Edit Date:    13/03/22

%--------------------------------------------------------------------------

% Description:

% Converts the unordered IQ (In-phase & Quadrature) time data into a
% multidimensional matrix structure. The structure collects samples
% together into chirps, frames and channels, where the final structure is a
% 4-dimensional array where the indices are determined as follows:
% [channel][frame][chirp][sample]

% N.B.:
% Modification of Matlab code provided in Texas Instrumentals
% documentation which can be found at:
% https://www.ti.com/lit/an/swra581b/swra581b.pdf

%--------------------------------------------------------------------------

function[output_data] = constructTimeFrameProfile(input_data, p)
    %Function Variables
    %----------------------------------------------------------------------
    % input_data(complex double[]): Unordered IQ time data array
    % adc_samples(int):             Number of ADC samples taken during a
    %                               chirp
    % chirps(int):                  Number of chirps taken during a frame
    % frames(int):                  Number of time frames recorded
    %----------------------------------------------------------------------
    
    %Determine the size of the input data array
    input_size = size(input_data, 2);
    
    %Determine whether the input data has the correct number of values
    if input_size ~= p.nChannels*p.nFrames*p.nChirps*p.nSamples
        %Throw error
        error("Error: Data array does not contain the correct number of samples.")
    end
    
    %Define the empty output array
    output_data = complex(zeros(p.nChannels, p.nFrames, p.nChirps, p.nSamples));
    
    %Reshape the unordered data into a 4-dimensional array
    input_data = reshape(input_data, p.nSamples, p.nChannels, p.nChirps, []);
    
    %Rearrange the indices
    for w = 1:p.nChannels
        for x = 1:p.nFrames
            for y = 1:p.nChirps
                for z = 1:p.nSamples
                    output_data(w,x,y,z) = input_data(z,w,y,x);
                end
            end
        end
    end
    
    %----------------------------------------------------------------------
end

%--------------------------------------------------------------------------
