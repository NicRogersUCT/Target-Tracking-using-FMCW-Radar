
%--------------------------------------------------------------------------

% Filename:     constructIQData.m
% Author:       William Bourn
% Version:      1.00
% Edit Date:    13/03/22

%--------------------------------------------------------------------------

% Description:

% Converts binary data from an array into complex values corresponding to
% the IQ (In-phase & Quadrature) time data for the receiver of a DCA1000EVM
% and an associated AWR1642BOOST module.

% N.B.:
% Modification of Matlab code provided in Texas Instrumentals
% documentation which can be found at:
% https://www.ti.com/lit/an/swra581b/swra581b.pdf

%--------------------------------------------------------------------------

function[output_data] = constructIQData(input_data, p)
    %Function Variables
    %----------------------------------------------------------------------
    % input_data(double[]): Raw binary data array
    % adc_bits(int):        Number of bits used to produce ADC sample
    %----------------------------------------------------------------------
    
    %Determine the size of the input data array
    input_size = size(input_data,2);
    
    %Check if input array size is multiple of 4
    if mod(input_size,4) ~= 0
        %Throw error
        error("Error: Data array does not contain the correct number of samples.")
    end
    
    %Define the empty output array.
    output_data = complex(zeros(2,input_size/4));
    
    %Compensate for sign extension in ADC where the sample size is less
    %than 16 bits
    if p.nBits < 16
        max = 2^(p.nBits -1) -1;
        input_data(input_data > max) = input_data(input_data > max) - 2^p.nBits;
    end
    
    %Reshape the raw data into a 4xN matrix
    input_data = reshape(input_data, 4, []);
    
    %Combine the four elements of each column into two complex values
    for x = 1: input_size/4
        output_data(1, x) = input_data(1, x) + 1j*input_data(3, x);
        output_data(2, x) = input_data(2, x) + 1j*input_data(4, x);
    end
    
    %Reshape the output data into an array
    output_data = reshape(output_data, 1, []);
    
    %----------------------------------------------------------------------
end

%--------------------------------------------------------------------------
