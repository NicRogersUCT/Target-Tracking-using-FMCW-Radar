function ambiguousAngles(inputArg1,inputArg2)
clc;
clear all;
phase_difference = pi; % Measured between the two long baseline antennas
number_ambiguous_angles = 3; % long_seperation_distance*2/lambda
% Run loop to check
i = 1;
n = 0; 
% Start at n = 0 so we can get the first angle
k = 2; % Start at k = 2 so we don’t repeat the first angle
ambig_angles = [];

while i == 1 
    if(isreal(asin((phase_difference+pi*n)/(pi*number_ambiguous_angles))))
        ambig_angle = asin((phase_difference+pi*n)/(pi*number_ambiguous_angles));
        n = n + 2;
        ambig_angles = [ambig_angles ambig_angle];
    elseif(isreal(asin((phase_difference-pi*k)/(pi*number_ambiguous_angles))))
        ambig_angle = asin((phase_difference-pi*k)/(pi*number_ambiguous_angles));   
        k = k + 2;
        ambig_angles = [ambig_angles ambig_angle];
    else
        i = 0;
    end
end

x = ['Ambiguous Angles: ',num2str(sort(ambig_angles*180/pi))];
disp(x)

% Finding the best unambiguous estimate AoA
% To do this we find the ambiguous angle that is closest to the unambiguous coarse baseline angle.
Unambiguous_AoA = find(abs(ambig_angles-AoA_short_baseline) == min(abs(ambig_angles-AoA_short_baseline)));
x = ['Estimated AoA: ',num2str(ambig_angles(Unambiguous_AoA)), ' degrees'];
disp(x)
end

