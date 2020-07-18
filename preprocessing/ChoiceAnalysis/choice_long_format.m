% This script combines all chocie data into 1 big data set,
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
output_dir  = 'P:\3017048.01\bids\derivatives\beh\color_wheel\choice\';
cd(data_dir);

% set subjects and sessions to be used
n_sub   = [1:25,51:75];
n_ses   = 1:3;

%% retrieve data and store in one big dataset %%
data_long = [];
for j = n_sub
    for i = n_ses
          if exist(sprintf('sub-%03d', j),'dir') ~= 0;  
              cd(fullfile(data_dir,sprintf('sub-%03d',j))); %subject specific folder
              sub_dir = pwd;
              if exist(fullfile(sub_dir,sprintf('ses-drug%d',i),'beh'),'dir') ~= 0; %DP changed this so it doesn't crush
                  cd(fullfile(sub_dir,sprintf('ses-drug%d',i),'beh\'));
                  filename = sprintf('sub-%03d_ses-drug%d_task-choice_beh.mat',j,i);    
                  if exist(filename,'file') ~= 0
                      load(filename);
                      data_long = [data_long; repmat(j,length(data.trialNumber),1) repmat(i,length(data.trialNumber),1) data.trialNumber data.block data.condition data.sz data.hardOffer data.easyOffer data.locationEasy data.choice data.choiceRT];                   
                  end 
              end 
          end
          cd(data_dir);
    end
end 

%% save data %%
cd(output_dir);
names = {'sID' 'session' 'trial' 'block' 'condition_IU' 'set_size' 'hardOffer' 'easyOffer' 'locationEasy_LR' 'choice_NR' 'RT'}; %choice_NR: 1 = no redo; 2 = redo
l = length(data_long)+1;
cells = sprintf('A2:K%d',l);
xlswrite('choicedata_long_format.xlsx',names, 1, 'A1:K1'); %DP fyi you don't need to define the end (K1), 'A1' would be ok
xlswrite('choicedata_long_format.xlsx',data_long, 1,cells); 
csvwrite('choicedata_long_format.csv',data_long);


