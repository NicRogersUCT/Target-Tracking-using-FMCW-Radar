function AoA = angleOfArrival(input_data,p)
%--------------------------------------------------------------------------

% Filename:     angleOfArrival.m
% Author:       Nicholas Rogers
% Version:      1.00
% Edit Date:    20/09/22

%--------------------------------------------------------------------------

% Description:

% Calculates the angel of arrival of a target in a given range and 
% doppler bin from an ARD object of a given frame

%--------------------------------------------------------------------------
 angles = [];
 unam = [];
 xpos = [];
 ypos = [];
 p.range_res = p.c/(2*p.bw)*p.range_factor;
 range = p.rBin*p.range_res

 for f = 1:p.nFrames   
    %frameTarget = 4;
    lambda = p.c/p.Fc; % wavelength

    chan1 = getFrame(input_data,1,f);
    ard1 = fft(chan1,[],1);
    ard1 = fftshift(fft(ard1,[],2),1);
    phase1 = angle(ard1(p.dBin, p.rBin));
    
    chan2 = getFrame(input_data,2,f);
    ard2 = fft(chan2,[],1);
    ard2 = fftshift(fft(ard2,[],2),1);
    phase2 = angle(ard2(p.dBin, p.rBin));
    
    chan4 = getFrame(input_data,4,f);
    ard4 = fft(chan4,[],1);
    ard4 = fftshift(fft(ard4,[],2),1);
    phase4 = angle(ard4(p.dBin, p.rBin));
    
%    phase_diff_short = phase1 - phase2;
    if phase1 > phase2
        phase_diff_short = -(abs(phase2) - abs(phase1));
    else
        phase_diff_short = abs(phase2) - abs(phase1);
    end
        
    AoA_unam = asin((lambda*phase_diff_short)/(2*pi*(lambda/2)))*(180/pi)
    unam = [unam, AoA_unam];
    
    %disp((lambda*phase_diff_short)/(2*pi*(lambda/2)))

    phase_diff_long = phase4 - phase1; % Measured between the two long baseline antennas
    nAmAngles = ((3/2)*lambda*2)/lambda; %long_seperation_distance*2/lambda
    
    % Run loop to check
    i = 1;
    n = 0; % Start at n = 0 so we can get the first angle
    k = 2; % Start at k = 2 so we don’t repeat the first angle
    ambig_angles = [];
    
    while i == 1
        if(isreal(asin((phase_diff_long+pi*n)/(pi*nAmAngles))))
            ambig_angle = asin((phase_diff_long+pi*n)/(pi*nAmAngles));
            n = n + 2;
            ambig_angles = [ambig_angles, ambig_angle];
            
        elseif(isreal(asin((phase_diff_long-pi*k)/(pi*nAmAngles))))
            ambig_angle = asin((phase_diff_long-pi*k)/(pi*nAmAngles)); 
            k = k + 2;
            ambig_angles = [ambig_angles, ambig_angle];
        else
            i = 0;
        end
    end
    ambig_angles = sort(ambig_angles*(180/pi));
    x = ['Ambiguous Angles: ',num2str(ambig_angles)];
    disp(x)

    % Finding the best unambiguous estimate AoA
    %To do this we find the ambiguous angle that is closest to the unambiguous coarse baseline angle.
    differences = [];
    for i = 1:length(ambig_angles)
        differences = [differences, abs(ambig_angles(i) - AoA_unam)];
    end
    
    index = find(differences == min(differences));
    AoAest = ambig_angles(index);
    angles = [angles, AoAest];
    
    %x = ['Estimated AoA: ', num2str(AoAest), ' degrees'];
    %disp(x);
 end
 
%  xpos = range*sind(angles);
%  ypos = range*cosd(angles); 
%  x = p.range*sind(p.theta);
%  y = p.range*cosd(p.theta);
%  
%  figure
%  hold on;
%  plot(x, y, 'rx', 'MarkerSize', 10, 'LineWidth', 1.2);
%  plot(xpos, ypos, 'bo', 'MarkerSize', 6, 'LineWidth', 1.5);
%  grid on;
%  title("Calculated vs Actual X-Y postion of target");
%  xlabel('x coordinates [m]');
%  ylabel('y coordinates [m]');
%  legend('Actual','Calculated');
%  
 unamFinal = mean(unam)
 stdUnam = std(unam)
 AoA = mean(angles)
 stdAoA = std(angles)
end

