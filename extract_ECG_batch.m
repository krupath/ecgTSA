% Script for batch processing

% INITIALIZE PATHS

% Initialize path to folder
root_dir = '/home/nithin/Desktop/Krupa/Satyam Data/Raw';

% VALIDATE PATHS 

% Populate files from the root folder
files = dir(fullfile(root_dir,'**', '*_S2*.mff'));

% Sanity check for existence of data files, halt if doesn't exist
if isempty(files)
    error('ERROR - No .mff files found')
end

% LAUNCH EEGLAB & ITERATE 

% Initialize eeglab
[ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab;

for file=files'
    eegfile = fullfile(file.folder, file.name);
    
    % READ FILE 

    % Read EGI file using plugin
    EEG = pop_mffimport(eegfile,{'classid','code','description','label','mffkeys','mffkeysbackup','name','relativebegintime','sourcedevice','tracktype'});
    [ALLEEG, EEG, CURRENTSET] = pop_newset(ALLEEG, EEG, 0, 'gui', 'off');
    
    % EXTRACT ECG 
    
    % Extract ECG data for meditation from the collected data 
    idx_med = find(contains(extractfield(EEG.event, 'code'), 'medi'));
    
    if ~isempty(idx_med)
        
        lat_med = round(EEG.event(idx_med).latency);

        % Check Channel locations to find channel number for ECG 
        ecg_loc = find(contains(extractfield(EEG.chanlocs, 'labels'), 'ECG')); 
        ecg_dat = EEG.data(ecg_loc, lat_med:end);
        
        % Save ECG data
        save(strcat(eegfile(1:end-4), '_ECGdata.mat'), 'ecg_dat');
        
    else
        
        fprintf('%s\t has no events', file.name)
        
    end
    
    % Flush EEGLAB variables
    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];
    
end