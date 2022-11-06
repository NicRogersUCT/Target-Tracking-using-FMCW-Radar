function  AngResTest()
%--------------------------------------------------------------------------

% Filename:     AngResTest.m
% Author:       Nicholas Rogers
% Version:      1.00
% Edit Date:    10/10/22

%--------------------------------------------------------------------------

% Description:

% Test to determine and visualise the error of the AoA determination versus
% angle of arrival to infer the angular resolution.

%--------------------------------------------------------------------------
addpath('./Angular Resolution Tests/')
file = [];
angles = [0,3,5,7,10,15,20,25,30,45];
for i = 1:10
    file = ['./', num2str(angles(i)), 'd/adc_data.bin'];
    filename = string(file);
    
    
end

