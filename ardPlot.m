function ardPlot(input_data,p)
%--------------------------------------------------------------------------

% Filename:     ardPlot.m
% Author:       Nicholas Rogers
% Version:      1.00
% Edit Date:    20/09/22

%--------------------------------------------------------------------------

% Description:

% Plots an Amplitude-Range-Doppler plot for a given file of ADC sample
% radar data. 

%--------------------------------------------------------------------------
for m = 5  %p.nFrames        %frames
    for n = 1:1     %channels
        x = linspace(0,p.nSamples,p.nSamples+1);
        xRange = x*p.range_res;
        y = linspace(-(p.nChirps/2),(p.nChirps/2),(p.nChirps+1));
        yDoppler = y*p.doppler_res;
        
        data_frame = getFrame(input_data,n,m);
        ard = fft(data_frame,[],1);             %Fast-time FFT
        ard = fftshift(fft(ard,[],2),1);        %Slow-time FFT
        
        %yVelocity = -(yDoppler).*(p.lambda)/2;
        figure();
        %subplot(2,2,n);
        imagesc(xRange,yDoppler,20*log10(abs(ard)));
        title("Amplitude, Range, Doppler Plot for Rx ",n);
        drawnow
        pause(0.1)
    end
    hold on;
    plot(p.range_res*(p.rBin-1),((p.nChirps/2)*p.doppler_res - p.doppler_res*(p.dBin-1)+0.5*p.doppler_res), 'ro', 'MarkerSize', 12, 'LineWidth', 1.2);
    xlabel('Range [m]');
    ylabel('Doppler Frequency [Hz]');
    %   disp(p.range_res*(p.rBin-1));
    %   disp(((p.nChirps/2)*p.doppler_res - p.doppler_res*(p.dBin-1)+0.5*p.doppler_res));  
end

end

