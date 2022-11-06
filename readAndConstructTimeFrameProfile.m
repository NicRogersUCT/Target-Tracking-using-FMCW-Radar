
%--------------------------------------------------------------------------

% Filename:     readAndConstructTimeFrameProfile.m
% Author:       William Bourn
% Modified by:  Nicholas Rogers
% Version:      1.00
% Edit Date:    13/03/22

%--------------------------------------------------------------------------

% Description:

% Reads the binary data from a .bin file and places it into into a
% multidimensional matrix structure. The structure collects samples
% together into chirps, frames and channels, where the final structure is a
% 4-dimensional array where the indices are determined as follows:
% [channel][frame][chirp][sample]

% N.B.:
% Modification of Matlab code provided in Texas Instrumentals
% documentation which can be found at:
% https://www.ti.com/lit/an/swra581b/swra581b.pdf

%--------------------------------------------------------------------------

function[data1,data2,data3] = readAndConstructTimeFrameProfile(p)
    %Function Variables
    %----------------------------------------------------------------------
    % filename (string):    Path of the .bin file to be read. Must contain
    %                       the '.bin suffix'.
    % adc_bits(int):        Number of bits used to produce ADC sample
    % adc_samples(int):     Number of ADC samples taken during a chirp
    % chirps(int):          Number of chirps taken during a frame
    % frames(int):          Number of time frames recorded
    %----------------------------------------------------------------------
    
    %Read the data from the .bin file
    raw_data = readFromBinFile(p);
    
    %Convert raw data into IQ time data
    time_iq_data = constructIQData(raw_data, p);
    
    tx1_data = [];
    tx2_data = [];
    tx3_data = [];
    t = 1;
    step = p.nChannels*p.nSamples;
    startInd = 1;
    endInd = step;
    
    for i = 1:(p.nChirpLoops*p.nTx*p.nFrames)
        if t == 1
            tx1_data = [tx1_data, time_iq_data(startInd:endInd)];
            t = 2;
        elseif t == 2
            tx2_data = [tx2_data, time_iq_data(startInd:endInd)];
            t = 3;
        elseif t == 3
            tx3_data = [tx3_data, time_iq_data(startInd:endInd)];
            t = 1;        
        end
        startInd = startInd+step;
        endInd = endInd+step;
    end
    
    %Create time frame profile structure
    data1 = constructTimeFrameProfile(tx1_data, p);
    data2 = constructTimeFrameProfile(tx2_data, p);
    data3 = constructTimeFrameProfile(tx3_data, p);
    
%     figure
%     %plot(real(time_iq_data(1:1024)))
%     plot(real(data1(1,1,4,:)))
%     hold on
% %     plot(angle(time_iq_data(1:1024)))
%     plot(angle(data1(1,1,4,:)))    
    %----------------------------------------------------------------------
end   

%--------------------------------------------------------------------------