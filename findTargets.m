function [outputArg1,outputArg2] = findTargets(inputArg1,inputArg2)
%--------------------------------------------------------------------------

% Filename:     findTargets.m
% Author:       Nicholas Rogers
% Version:      1.00
% Edit Date:    20/09/22

%--------------------------------------------------------------------------

% Description:

% Plots an Amplitude-Range-Doppler plot for a given file of ADC sample
% radar data. 

%--------------------------------------------------------------------------
cfar2D = phased.CFARDetector2D('GuardBandSize',5,'TrainingBandSize',10,...
 'ProbabilityFalseAlarm',1e-5);
end

