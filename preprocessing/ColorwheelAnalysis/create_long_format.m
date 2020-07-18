% This script combines all color wheel data into 1 big data set,
% combining all subjects and all sessions. Data will be in long format,
% which can be processed by R and mixed modelling in SPSS.
% If you want to make any changes to this script, please first tell Lieke
% Hofmans. 
% 
% Lieke Hofmans, February 2018 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; 
clc;

%% settings %%

% set directories
data_dir    = 'P:\3017048.01\bids\'; 
output_dir  = 'P:\3017048.01\bids\derivatives\beh\color_wheel\color_wheel\';
cd(data_dir);

addpath('P:\3017048.01\code\analysis\beh\CW\preprocessing\ColorwheelAnalysis\');

% set subjects and sessions to be used
n_sub   = [1:25,51:75];
n_ses   = 1:3;

%% retrieve data and store in one big dataset %%
data_long = [];
for j = n_sub
    for i = n_ses
          if exist(sprintf('sub-%03d', j),'dir') ~= 0  
              cd(fullfile(data_dir,sprintf('sub-%03d',j))); %subject specific folder
              sub_dir = pwd;
              if exist(fullfile(sub_dir,sprintf('ses-drug%d',i),'beh'),'dir') ~= 0 %D.P: changed this so it doesn't crush at 69
                  cd(fullfile(sub_dir,sprintf('ses-drug%d',i),'beh\'));
                  filename = sprintf('sub-%03d_ses-drug%d_task-colorwheel_beh.mat',j,i);
                  if exist(filename,'file') ~= 0
                      load(filename)
                      for b = 1:size(data,2)
                          for t = 1:length(data)
                              [rawDeviance] = retrieveDeviance(data, trial, b, t);                               
                              data_long = [data_long; j i (t+(b-1)*length(data)) b data(t,b).respDif rawDeviance data(t,b).rt data(t,b).setsize data(t,b).type data(t,b).lureDif trial(t,b).probeColNum trial(t,b).wheelStart trial(t,b).probeLocNum];                   
                          end
                      end
                  end 
              end 
          end
          cd(data_dir);
    end
end

%% save data %%
cd(output_dir);
names = {'sID' 'session' 'trial' 'block' 'absDeviance' 'rawDeviance' 'RT' 'set_size' 'type_IU' 'lure_deviance' 'probeColNum' 'wheelStart' 'probeLoc'};
l = length(data_long)+1;
cells = sprintf('A2:M%d',l);
xlswrite('CWdata_long_format.xlsx',names, 1, 'A1:M1');
xlswrite('CWdata_long_format.xlsx',data_long, 1,cells); 
csvwrite('CWdata_long_format.csv',data_long);


