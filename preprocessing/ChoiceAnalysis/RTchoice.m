%This script takes the RT on the choices per participant, in total, 
%for update, for ignore, and per condition (update/ignore) per set size 
%(1-4) per session (1-3). 

clear; 
clc;

%% settings %%

% set directories
data_dir    = 'P:\3017048.01\bids\derivatives\beh\color_wheel\choice\';
cd(data_dir);

% set subjects and sessions to be used
n_sub   = [1:25,51:75];
n_ses   = 1:3;

% load and define data
load('choicedata_long_format.csv');
% First, set all trials where RT == 0 (participant was too late) to NaN
choicedata_long_format(choicedata_long_format(:,11)==0,11) = NaN;

% 'sID' 'session' 'trial' 'block' 'condition_IU' 'set_size' 'hardOffer' 'easyOffer' 'locationEasy_LR' 'choice_NR' 'RT'
subNo       = choicedata_long_format(:,1);
ses         = choicedata_long_format(:,2);
condition   = choicedata_long_format(:,5);
ss          = choicedata_long_format(:,6);
choice_NR   = choicedata_long_format(:,10);
rt          = choicedata_long_format(:,11);

 

%% take RTs

i = 1;
for j=n_sub
  
    % Median RT overall    
    Total(i)=nanmedian(rt(subNo==j));    

    % Median RT per session
    ses1(i)=nanmedian(rt(subNo==j & ses==1));
    ses2(i)=nanmedian(rt(subNo==j & ses==2));
    ses3(i)=nanmedian(rt(subNo==j & ses==3));

    % Median RT per condition
    I(i)=nanmedian(rt(subNo==j & condition==0));
    U(i)=nanmedian(rt(subNo==j & condition==2));

    % Median RT per set size
    ss1(i)=nanmedian(rt(subNo==j & ss==1));
    ss2(i)=nanmedian(rt(subNo==j & ss==2));
    ss3(i)=nanmedian(rt(subNo==j & ss==3));
    ss4(i)=nanmedian(rt(subNo==j & ss==4));

    % Median RT per session per condition
    ses1_I(i)=nanmedian(rt(subNo==j & ses==1 & condition==0));
    ses2_I(i)=nanmedian(rt(subNo==j & ses==2 & condition==0));
    ses3_I(i)=nanmedian(rt(subNo==j & ses==3 & condition==0));
    ses1_U(i)=nanmedian(rt(subNo==j & ses==1 & condition==2));
    ses2_U(i)=nanmedian(rt(subNo==j & ses==2 & condition==2));
    ses3_U(i)=nanmedian(rt(subNo==j & ses==3 & condition==2));
    
    % Median RT per condition per set size
    I_ss1(i)=nanmedian(rt(subNo==j & ss==1 & condition==0));
    I_ss2(i)=nanmedian(rt(subNo==j & ss==2 & condition==0));
    I_ss3(i)=nanmedian(rt(subNo==j & ss==3 & condition==0));
    I_ss4(i)=nanmedian(rt(subNo==j & ss==4 & condition==0));
    U_ss1(i)=nanmedian(rt(subNo==j & ss==1 & condition==2));
    U_ss2(i)=nanmedian(rt(subNo==j & ss==2 & condition==2));
    U_ss3(i)=nanmedian(rt(subNo==j & ss==3 & condition==2));
    U_ss4(i)=nanmedian(rt(subNo==j & ss==4 & condition==2));

    % Median RT per session per set size
    ses1_ss1(i)=nanmedian(rt(subNo==j & ses==1 & ss==1));
    ses1_ss2(i)=nanmedian(rt(subNo==j & ses==1 & ss==2));
    ses1_ss3(i)=nanmedian(rt(subNo==j & ses==1 & ss==3));
    ses1_ss4(i)=nanmedian(rt(subNo==j & ses==1 & ss==4));
    ses2_ss1(i)=nanmedian(rt(subNo==j & ses==2 & ss==1));
    ses2_ss2(i)=nanmedian(rt(subNo==j & ses==2 & ss==2));
    ses2_ss3(i)=nanmedian(rt(subNo==j & ses==2 & ss==3));
    ses2_ss4(i)=nanmedian(rt(subNo==j & ses==2 & ss==4));
    ses3_ss1(i)=nanmedian(rt(subNo==j & ses==3 & ss==1));
    ses3_ss2(i)=nanmedian(rt(subNo==j & ses==3 & ss==2));
    ses3_ss3(i)=nanmedian(rt(subNo==j & ses==3 & ss==3));
    ses3_ss4(i)=nanmedian(rt(subNo==j & ses==3 & ss==4));
    
    % Median RT per session per condition per set size
    ses1_I_1(i)=nanmedian(rt(subNo==j & ses==1 & condition==0 & ss==1)); %session 1, Ignore, set size 1; calculating median while ignoring NaN values 
    ses1_I_2(i)=nanmedian(rt(subNo==j & ses==1 & condition==0 & ss==2));
    ses1_I_3(i)=nanmedian(rt(subNo==j & ses==1 & condition==0 & ss==3));
    ses1_I_4(i)=nanmedian(rt(subNo==j & ses==1 & condition==0 & ss==4));

    ses2_I_1(i)=nanmedian(rt(subNo==j & ses==2 & condition==0 & ss==1));  
    ses2_I_2(i)=nanmedian(rt(subNo==j & ses==2 & condition==0 & ss==2));
    ses2_I_3(i)=nanmedian(rt(subNo==j & ses==2 & condition==0 & ss==3));
    ses2_I_4(i)=nanmedian(rt(subNo==j & ses==2 & condition==0 & ss==4));

    ses3_I_1(i)=nanmedian(rt(subNo==j & ses==3 & condition==0 & ss==1)); 
    ses3_I_2(i)=nanmedian(rt(subNo==j & ses==3 & condition==0 & ss==2));
    ses3_I_3(i)=nanmedian(rt(subNo==j & ses==3 & condition==0 & ss==3));
    ses3_I_4(i)=nanmedian(rt(subNo==j & ses==3 & condition==0 & ss==4));


    ses1_U_1(i)=nanmedian(rt(subNo==j & ses==1 & condition==2 & ss==1));
    ses1_U_2(i)=nanmedian(rt(subNo==j & ses==1 & condition==2 & ss==2));
    ses1_U_3(i)=nanmedian(rt(subNo==j & ses==1 & condition==2 & ss==3));
    ses1_U_4(i)=nanmedian(rt(subNo==j & ses==1 & condition==2 & ss==4));

    ses2_U_1(i)=nanmedian(rt(subNo==j & ses==2 & condition==2 & ss==1));
    ses2_U_2(i)=nanmedian(rt(subNo==j & ses==2 & condition==2 & ss==2));
    ses2_U_3(i)=nanmedian(rt(subNo==j & ses==2 & condition==2 & ss==3));
    ses2_U_4(i)=nanmedian(rt(subNo==j & ses==2 & condition==2 & ss==4));

    ses3_U_1(i)=nanmedian(rt(subNo==j & ses==3 & condition==2 & ss==1));
    ses3_U_2(i)=nanmedian(rt(subNo==j & ses==3 & condition==2 & ss==2));
    ses3_U_3(i)=nanmedian(rt(subNo==j & ses==3 & condition==2 & ss==3));
    ses3_U_4(i)=nanmedian(rt(subNo==j & ses==3 & condition==2 & ss==4));

%     %--------------------------------------------------------------------
%     % RTs per choice (whether they chose the task or the no redo option
%     Total_task(i)=nanmedian(rt(subNo==j & choice_NR==2));  
%     Total_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1));
%     
%     ses1_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==1));
%     ses2_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==2));
%     ses3_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==3));
%     ses1_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==1));
%     ses2_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==2));
%     ses3_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==3));
%     
%     I_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & condition==0));
%     U_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & condition==2));
%     I_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & condition==0));
%     U_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & condition==2));
% 
%     ss1_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ss==1));
%     ss2_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ss==2));
%     ss3_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ss==3));
%     ss4_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ss==4));
%     ss1_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ss==1));
%     ss2_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ss==2));
%     ss3_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ss==3));
%     ss4_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ss==4));
%     
%     ses1_I_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==1 & condition==0));
%     ses2_I_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==2 & condition==0));
%     ses3_I_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==3 & condition==0));
%     ses1_U_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==1 & condition==2));
%     ses2_U_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==2 & condition==2));
%     ses3_U_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==3 & condition==2));
%     ses1_I_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==1 & condition==0));
%     ses2_I_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==2 & condition==0));
%     ses3_I_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==3 & condition==0));
%     ses1_U_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==1 & condition==2));
%     ses2_U_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==2 & condition==2));
%     ses3_U_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==3 & condition==2));
%     
%     I_ss1_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ss==1 & condition==0));
%     I_ss2_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ss==2 & condition==0));
%     I_ss3_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ss==3 & condition==0));
%     I_ss4_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ss==4 & condition==0));
%     U_ss1_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ss==1 & condition==2));
%     U_ss2_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ss==2 & condition==2));
%     U_ss3_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ss==3 & condition==2));
%     U_ss4_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ss==4 & condition==2));
%     I_ss1_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ss==1 & condition==0));
%     I_ss2_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ss==2 & condition==0));
%     I_ss3_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ss==3 & condition==0));
%     I_ss4_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ss==4 & condition==0));
%     U_ss1_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ss==1 & condition==2));
%     U_ss2_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ss==2 & condition==2));
%     U_ss3_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ss==3 & condition==2));
%     U_ss4_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ss==4 & condition==2));
%     
%     ses1_ss1_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==1 & ss==1));
%     ses1_ss2_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==1 & ss==2));
%     ses1_ss3_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==1 & ss==3));
%     ses1_ss4_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==1 & ss==4));
%     ses2_ss1_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==2 & ss==1));
%     ses2_ss2_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==2 & ss==2));
%     ses2_ss3_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==2 & ss==3));
%     ses2_ss4_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==2 & ss==4));
%     ses3_ss1_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==3 & ss==1));
%     ses3_ss2_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==3 & ss==2));
%     ses3_ss3_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==3 & ss==3));
%     ses3_ss4_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==3 & ss==4));
%     ses1_ss1_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==1 & ss==1));
%     ses1_ss2_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==1 & ss==2));
%     ses1_ss3_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==1 & ss==3));
%     ses1_ss4_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==1 & ss==4));
%     ses2_ss1_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==2 & ss==1));
%     ses2_ss2_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==2 & ss==2));
%     ses2_ss3_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==2 & ss==3));
%     ses2_ss4_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==2 & ss==4));
%     ses3_ss1_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==3 & ss==1));
%     ses3_ss2_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==3 & ss==2));
%     ses3_ss3_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==3 & ss==3));
%     ses3_ss4_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==3 & ss==4));
%     
%     ses1_I_1_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==1 & condition==0 & ss==1)); %session 1, Ignore, set size 1; calculating median while ignoring NaN values 
%     ses1_I_2_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==1 & condition==0 & ss==2));
%     ses1_I_3_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==1 & condition==0 & ss==3));
%     ses1_I_4_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==1 & condition==0 & ss==4));
% 
%     ses2_I_1_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==2 & condition==0 & ss==1));  
%     ses2_I_2_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==2 & condition==0 & ss==2));
%     ses2_I_3_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==2 & condition==0 & ss==3));
%     ses2_I_4_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==2 & condition==0 & ss==4));
% 
%     ses3_I_1_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==3 & condition==0 & ss==1)); 
%     ses3_I_2_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==3 & condition==0 & ss==2));
%     ses3_I_3_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==3 & condition==0 & ss==3));
%     ses3_I_4_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==3 & condition==0 & ss==4));
% 
% 
%     ses1_U_1_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==1 & condition==2 & ss==1));
%     ses1_U_2_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==1 & condition==2 & ss==2));
%     ses1_U_3_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==1 & condition==2 & ss==3));
%     ses1_U_4_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==1 & condition==2 & ss==4));
% 
%     ses2_U_1_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==2 & condition==2 & ss==1));
%     ses2_U_2_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==2 & condition==2 & ss==2));
%     ses2_U_3_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==2 & condition==2 & ss==3));
%     ses2_U_4_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==2 & condition==2 & ss==4));
% 
%     ses3_U_1_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==3 & condition==2 & ss==1));
%     ses3_U_2_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==3 & condition==2 & ss==2));
%     ses3_U_3_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==3 & condition==2 & ss==3));
%     ses3_U_4_task(i)=nanmedian(rt(subNo==j & choice_NR==2 & ses==3 & condition==2 & ss==4));
%     
%     ses1_I_1_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==1 & condition==0 & ss==1)); %session 1, Ignore, set size 1; calculating median while ignoring NaN values 
%     ses1_I_2_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==1 & condition==0 & ss==2));
%     ses1_I_3_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==1 & condition==0 & ss==3));
%     ses1_I_4_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==1 & condition==0 & ss==4));
% 
%     ses2_I_1_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==2 & condition==0 & ss==1));  
%     ses2_I_2_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==2 & condition==0 & ss==2));
%     ses2_I_3_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==2 & condition==0 & ss==3));
%     ses2_I_4_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==2 & condition==0 & ss==4));
% 
%     ses3_I_1_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==3 & condition==0 & ss==1)); 
%     ses3_I_2_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==3 & condition==0 & ss==2));
%     ses3_I_3_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==3 & condition==0 & ss==3));
%     ses3_I_4_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==3 & condition==0 & ss==4));
% 
% 
%     ses1_U_1_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==1 & condition==2 & ss==1));
%     ses1_U_2_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==1 & condition==2 & ss==2));
%     ses1_U_3_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==1 & condition==2 & ss==3));
%     ses1_U_4_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==1 & condition==2 & ss==4));
% 
%     ses2_U_1_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==2 & condition==2 & ss==1));
%     ses2_U_2_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==2 & condition==2 & ss==2));
%     ses2_U_3_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==2 & condition==2 & ss==3));
%     ses2_U_4_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==2 & condition==2 & ss==4));
% 
%     ses3_U_1_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==3 & condition==2 & ss==1));
%     ses3_U_2_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==3 & condition==2 & ss==2));
%     ses3_U_3_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==3 & condition==2 & ss==3));
%     ses3_U_4_noRedo(i)=nanmedian(rt(subNo==j & choice_NR==1 & ses==3 & condition==2 & ss==4));
%     
    
    
    
    i = i+1;
    

end


%% save ratio redo data in wide format
RTchoice_wide_format=[n_sub' Total' ses1' ses2' ses3' I' U' ss1' ss2' ss3' ss4' ses1_I' ses2_I' ses3_I' ses1_U' ses2_U' ses3_U'...
    I_ss1' I_ss2' I_ss3' I_ss4' U_ss1' U_ss2' U_ss3' U_ss4' ses1_ss1' ses1_ss2' ses1_ss3' ses1_ss4' ses2_ss1' ses2_ss2' ses2_ss3' ses2_ss4'...
    ses3_ss1' ses3_ss2' ses3_ss3' ses3_ss4' ses1_I_1' ses1_I_2' ses1_I_3' ses1_I_4' ses2_I_1' ses2_I_2' ses2_I_3' ses2_I_4' ses3_I_1' ses3_I_2'...
    ses3_I_3' ses3_I_4' ses1_U_1' ses1_U_2' ses1_U_3' ses1_U_4' ses2_U_1' ses2_U_2' ses2_U_3' ses2_U_4' ses3_U_1' ses3_U_2' ses3_U_3' ses3_U_4'];
names={'sID' 'Total' 'ses1' 'ses2' 'ses3'  'I' 'U' 'ss1' 'ss2' 'ss3' 'ss4' 'ses1_I' 'ses2_I' 'ses3_I' 'ses1_U' 'ses2_U' 'ses3_U'...
    'I_ss1' 'I_ss2' 'I_ss3' 'I_ss4' 'U_ss1' 'U_ss2' 'U_ss3' 'U_ss4' 'ses1_ss1' 'ses1_ss2' 'ses1_ss3' 'ses1_ss4' 'ses2_ss1' 'ses2_ss2' 'ses2_ss3' 'ses2_ss4'...
    'ses3_ss1' 'ses3_ss2' 'ses3_ss3' 'ses3_ss4' 'ses1_I_1' 'ses1_I_2' 'ses1_I_3' 'ses1_I_4' 'ses2_I_1' 'ses2_I_2' 'ses2_I_3' 'ses2_I_4' 'ses3_I_1' 'ses3_I_2'... 
    'ses3_I_3' 'ses3_I_4' 'ses1_U_1' 'ses1_U_2' 'ses1_U_3' 'ses1_U_4' 'ses2_U_1' 'ses2_U_2' 'ses2_U_3' 'ses2_U_4' 'ses3_U_1' 'ses3_U_2' 'ses3_U_3' 'ses3_U_4'};
xlswrite('RTchoice_wide_format.xlsx',names,1,'A1:BI1');
xlswrite('RTchoice_wide_format.xlsx',RTchoice_wide_format,1,'A2:BI51');
csvwrite('RTchoice_wide_format.csv',RTchoice_wide_format);

%% save ratio redo data in long format
subs                    = repmat(n_sub',24,1);
session                 = repmat([1 2 3], 200, 1); session = session(:); session = repmat(session, 2, 1);
setsize                 = repmat([1 2 3 4], 50, 1); setsize = setsize(:); setsize = repmat(setsize, 6, 1);
cond                    = repmat([0 2], 600, 1); cond = cond(:); 
RT                      = [ses1_I_1'; ses1_I_2'; ses1_I_3'; ses1_I_4'; ses2_I_1'; ses2_I_2'; ses2_I_3'; ses2_I_4'; ses3_I_1'; ses3_I_2'; ses3_I_3'; ses3_I_4'; ses1_U_1'; ses1_U_2'; ses1_U_3'; ses1_U_4'; ses2_U_1'; ses2_U_2'; ses2_U_3'; ses2_U_4'; ses3_U_1'; ses3_U_2'; ses3_U_3'; ses3_U_4'];
RTchoice_long_format   = [subs session cond setsize RT];

names={'sID' 'session' 'condition' 'setsize' 'RT'};
xlswrite('RTchoice_long_format.xlsx',names,1,'A1:EI1');
xlswrite('RTchoice_long_format.xlsx',RTchoice_long_format,1,'A2:E1201');
csvwrite('RTchoice_long_format.csv',RTchoice_long_format);


% %% save ratio redo data per choice in wide format
% RTchoice_task_wide_format=[n_sub' Total_task' ses1_task' ses2_task' ses3_task' I_task' U_task' ss1_task' ss2_task' ss3_task' ss4_task' ses1_I_task' ses2_I_task' ses3_I_task' ses1_U_task' ses2_U_task' ses3_U_task'...
%     I_ss1_task' I_ss2_task' I_ss3_task' I_ss4_task' U_ss1_task' U_ss2_task' U_ss3_task' U_ss4_task' ses1_ss1_task' ses1_ss2_task' ses1_ss3_task' ses1_ss4_task' ses2_ss1_task' ses2_ss2_task' ses2_ss3_task' ses2_ss4_task'...
%     ses3_ss1_task' ses3_ss2_task' ses3_ss3_task' ses3_ss4_task' ses1_I_1_task' ses1_I_2_task' ses1_I_3_task' ses1_I_4_task' ses2_I_1_task' ses2_I_2_task' ses2_I_3_task' ses2_I_4_task' ses3_I_1_task' ses3_I_2_task'...
%     ses3_I_3_task' ses3_I_4_task' ses1_U_1_task' ses1_U_2_task' ses1_U_3_task' ses1_U_4_task' ses2_U_1_task' ses2_U_2_task' ses2_U_3_task' ses2_U_4_task' ses3_U_1_task' ses3_U_2_task' ses3_U_3_task' ses3_U_4_task'];
% xlswrite('RTchoice_task_wide_format.xlsx',names,1,'A1:BI1');
% xlswrite('RTchoice_task_wide_format.xlsx',RTchoice_task_wide_format,1,'A2:BI51');
% csvwrite('RTchoice_task_wide_format.csv',RTchoice_task_wide_format);
% 
% RTchoice_noRedo_wide_format=[n_sub' Total_noRedo' ses1_noRedo' ses2_noRedo' ses3_noRedo' I_noRedo' U_noRedo' ss1_noRedo' ss2_noRedo' ss3_noRedo' ss4_noRedo' ses1_I_noRedo' ses2_I_noRedo' ses3_I_noRedo' ses1_U_noRedo' ses2_U_noRedo' ses3_U_noRedo'...
%     I_ss1_noRedo' I_ss2_noRedo' I_ss3_noRedo' I_ss4_noRedo' U_ss1_noRedo' U_ss2_noRedo' U_ss3_noRedo' U_ss4_noRedo' ses1_ss1_noRedo' ses1_ss2_noRedo' ses1_ss3_noRedo' ses1_ss4_noRedo' ses2_ss1_noRedo' ses2_ss2_noRedo' ses2_ss3_noRedo' ses2_ss4_noRedo'...
%     ses3_ss1_noRedo' ses3_ss2_noRedo' ses3_ss3_noRedo' ses3_ss4_noRedo' ses1_I_1_noRedo' ses1_I_2_noRedo' ses1_I_3_noRedo' ses1_I_4_noRedo' ses2_I_1_noRedo' ses2_I_2_noRedo' ses2_I_3_noRedo' ses2_I_4_noRedo' ses3_I_1_noRedo' ses3_I_2_noRedo'...
%     ses3_I_3_noRedo' ses3_I_4_noRedo' ses1_U_1_noRedo' ses1_U_2_noRedo' ses1_U_3_noRedo' ses1_U_4_noRedo' ses2_U_1_noRedo' ses2_U_2_noRedo' ses2_U_3_noRedo' ses2_U_4_noRedo' ses3_U_1_noRedo' ses3_U_2_noRedo' ses3_U_3_noRedo' ses3_U_4_noRedo'];
% xlswrite('RTchoice_noRedo_wide_format.xlsx',names,1,'A1:BI1');
% xlswrite('RTchoice_noRedo_wide_format.xlsx',RTchoice_noRedo_wide_format,1,'A2:BI51');
% csvwrite('RTchoice_noRedo_wide_format.csv',RTchoice_noRedo_wide_format);
% 
% 
