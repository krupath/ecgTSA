% Extracting R-R Tachograms from collected data 

% Load EEGLAB 
% Load .mff file using EEGLAB 
% Minimize EEGLAB window

% Extract ECG data for meditation from the collected data 
idx_med = find(contains(extractfield(EEG.event, 'code'), 'medi'));
lat_med = round(EEG.event(idx_med).latency);

% Check Channel locations to find channel number for ECG 
ecg_loc = find(contains(extractfield(EEG.chanlocs, 'labels'), 'ECG')); 
ecg_dat = EEG.data(ecg_loc, lat_med:end);

% Identify R-Peaks 
[peaks,locs_Rwave] = findpeaks(ecg_dat,1000,...
    'MinPeakHeight', quantile(ecg_dat, 0.975),...
    'MinPeakDistance', 0.5, ...
    'MinPeakProminence', std(ecg_dat));
                                
% Mark R-Peaks
subplot(2,2,1)
plot(ecg_dat); hold on
plot(locs_Rwave*1000, peaks, 'ok'); hold off
title('R-peaks in ECG Data')

% Identify R-R intervals and save them 
RRintervals = locs_Rwave(2:end) - locs_Rwave(1:end-1);
save(strcat(EEG.filename(1:end-4), '_RRintervals.mat'), 'RRintervals');

% Plot R-R intervals as RR tachogram
figure
%subplot(2,2,3)
plot(RRintervals)
title("R-R Tachogram")
xlabel("Order")
ylabel("Time (ms)")
set(gcf,'PaperPositionMode','auto')
saveas(figure,strcat(EEG.filename(1:end-4), '_RRtachogram.png'))

% Poincare plot or phase portrait
figure(1)
subplot(2,2,[2,4])
plot(RRintervals(2:end), RRintervals(1:end-1), 'or')
title("Poincare plot for HRV")
xlabel("RR_(n) (ms)")
ylabel("RR_(n+1) (ms)")
set(gcf, 'Width',1000,'Height',1000)

% 300 dpi 
% poincare plot as a square
% 1000px wide x 1000 px tall (16 x 9 inches)
% code for eeglab
% save files for ECG data, RR intervals, RR tachograms 
