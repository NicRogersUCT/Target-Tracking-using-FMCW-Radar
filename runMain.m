clc; clear all;
close all;

%--------------------------------------------------------------------------

addpath('./ardMakers/')
addpath('./readData/')
addpath('./findPosition/')
addpath('./radarParameters/')
addpath('./Angular Resolution Tests/')


% Read in radar parameter file
%p = param_3_6m20Left11Up();
%p = param_18d;
%p = param_4_25m30Right0Up();
p = param_3_6m20Left0UpRain();
%p = param_elev_test();
%p = param_3d();

calc_ard = 'n'; % y,n
% If plot_ard:

% ARD
p.plot_ard = 'n'; % y,n
p.video = 'n'; % y,n
p.videoName = 'adc_data_ard.avi';

% CFAR
p.cfar = 'y'; % y, n
p.plot_cfar = 'n'; % y, n
p.plot_cfar_total = 'n'; % y, n

% SPECTOGRAM
plot_spectogram = 'n'; % y,n
plot_phase = 'n'; % y,n

p.dynamicRange = 40; % dB

% Spectogram parameters
% Select which range bin(s) you want to examine
p.range_bin = [7]; % Must be an array
p.window_size = 8;
p.overlap = 0.99;
p.pad_multiplier = 4;

% Window functions
p.w_range = 'blackman'; % hamming, blackman, hann, none
p.w_doppler = 'blackman'; % hamming, blackman, hann, none
p.w_microDoppler = 'blackman'; % hamming, blackman, hann, none

% CFAR parameters
%p.kernel = [1;1;1;1;1;0;0;0;0;0;0;0;0;0;1;1;1;1;1;];
guard = 5;
reference = 10;
p.pfa = 10e-6;

total_cells = (guard+reference)*2+1;
p.kernel = ones(total_cells,total_cells);
p.kernel(reference+1:reference+guard*2+1,reference+1:reference+guard*2+1) = 0;

%--------------------------------------------------------------------------

p.c = 3e8;
p.lambda = p.c/p.Fc; % wavelength
p.range_factor = 2.0857;
p.srf = 1/p.t_sweep;
p.t_total = p.nChirps*p.t_chirp;
p.range_res = p.c/(2*p.bw)*p.range_factor; % Range resolution
p.doppler_res = 1/p.t_chirp; % Doppler resolution

p.pad_size = p.window_size*p.pad_multiplier;
p.range_ticks = p.range_res*(0:p.nSamples)*2;
p.doppler_ticks = p.doppler_res*(-1*floor((p.nChirps/2)): floor((p.nChirps/2)));

%--------------------------------------------------------------------------

data = readAndConstructTimeFrameProfile1Tx(p);
%[data1,data2,data3] = readAndConstructTimeFrameProfile(p);


ardPlot(data,p);
AoA = angleOfArrival(data, p);
plotPosition(p, AoA);

%% Angle Resolution Test
angles = [];
AoAs = [];
% for i = 1:10
%     switch i
%         case 1
%             p = param_0d();
%         case 2
%             p = param_3d();
%         case 3
%             p = param_5d();
%         case 4
%             p = param_7d();
%         case 5
%             p = param_10d();
%         case 6
%             p = param_15d();
%         case 7
%             p = param_20d();
%         case 8
%             p = param_25d();
%         case 9
%             p = param_30d();
%         case 10
%             p = param_45d();
%         otherwise
%             disp('default!');
%             p = param_0d();
%     end
%     p.c = 3e8;
%     p.lambda = p.c/p.Fc; % wavelength
% 
%     p.srf = 1/p.t_sweep;
%     p.t_total = p.nChirps*p.t_chirp;
%     p.range_res = p.c/(2*p.bw); % Range resolution
%     p.doppler_res = 1/p.t_chirp; % Doppler resolution
% 
%     p.range_ticks = p.range_res*(0:p.nSamples)*2;
%     p.doppler_ticks = p.doppler_res*(-1*floor((p.nChirps/2)): floor((p.nChirps/2)));
%     
%     data = readAndConstructTimeFrameProfile(p);
%     angles = [angles, p.theta];
%     AoAs = [AoAs, angleOfArrival(data, p)]
%     error = angles - AoAs
    
%end

%% Plotting the Range-Doppler Map and Calculating Angle of Arrival

if strcmp(calc_ard,"y")
    ard = ardMaker(data, p);
    
    if strcmp(p.plot_ard,"y")
        figure()
        imagesc(p.range_ticks, p.doppler_ticks, 20*log10(abs(ard)))
        title('Amplitude Range Doppler Plot (Main)')
        xlabel('Range [m]')
        ylabel('Doppler [Hz]')
        
    end
    
end
%% Plotting the spectogram
if strcmp(plot_spectogram,"y")
   frequency_time = spectogram(data, p);

   N = size(frequency_time,1);
   M = size(frequency_time,2);
   
   % Plot the result
   % This needs to be fixed
   x = linspace(0,p.t_total,M);
   y = (-1*N/2:(N/2)-1)*(1/(p.t_sweep*N));
   
   raw_spectogram_data = frequency_time;
   writematrix(raw_spectogram_data,'raw_spectogram_data.csv') 
   
   figure()
   frequency_time = 20*log10(abs(frequency_time)) - max(max(20*log10(abs(frequency_time))));
   imagesc(frequency_time)
   title('Spectogram results')
   %xlabel('time [s]')
   %ylabel('frequency [Hz]')
   colorbar
   caxis([-p.dynamicRange 0])
end

%% Plotting the phase
if strcmp(plot_phase, "y")
   phase_time = unwrap(phase(data, p));
   
   figure()
   plot(phase_time)
   grid on
   title('Phase-time plot')
   xlabel('Time [samples]')
   ylabel('Phase [rad]')
end
%}