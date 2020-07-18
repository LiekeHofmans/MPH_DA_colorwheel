%This script calculates the ratio of redo choices relative to no redo
%choices per participant, in total, for update, for ignore, and per
%condition (update/ignore) per set size (1-4) per session (1-3). The lower the ratio, the
%less they valued cognitive demand (they rather wanted to stay in the
%cubicle and do nothing then to redo the task for money). 

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
% 'sID' 'session' 'trial' 'block' 'condition_IU' 'set_size' 'hardOffer' 'easyOffer' 'locationEasy_LR' 'choice_NR' 'RT'
subNo       = choicedata_long_format(:,1);
ses         = choicedata_long_format(:,2);
condition   = choicedata_long_format(:,5);
ss          = choicedata_long_format(:,6);
choice      = choicedata_long_format(:,10);
 

%% calculate redo ratios
%regarding choices: 1 represents easy (no redo) and 2 difficult (redo)

i = 1;
for j=n_sub
  
    %total ratio of redo
    redos = length(find(subNo==j & choice == 2)); 
    total = length(find(subNo==j & choice ~= 9));
    Total(i) = redos / total; 
    
    %ratio of redo for session 1
    redos = length(find(subNo==j & ses==1 & choice == 2)); 
    total = length(find(subNo==j & ses==1 & choice ~= 9));
    ses1(i) = redos / total;
    
    %ratio of redo for session 2  
    redos = length(find(subNo==j & ses==2 & choice == 2)); 
    total = length(find(subNo==j & ses==2 & choice ~= 9));
    ses2(i) = redos / total;
    
    %ratio of redo for session 3  
    redos = length(find(subNo==j & ses==3 & choice == 2)); 
    total = length(find(subNo==j & ses==3 & choice ~= 9));
    ses3(i) = redos / total;
    
    %ratio of redo for ignore                   
    redos = length(find(subNo==j & condition==0 & choice == 2)); 
    total = length(find(subNo==j & condition==0 & choice ~= 9));
    I(i) = redos / total; 
         
    %ratio of redo for update                   
    redos = length(find(subNo==j & condition==2 & choice == 2)); 
    total = length(find(subNo==j & condition==2 & choice ~= 9));
    U(i) = redos / total; 

    %ratio of redo for set size 1 
    redos = length(find(subNo==j & ss==1 & choice == 2)); 
    total = length(find(subNo==j & ss==1 & choice ~= 9));
    ss1(i) = redos / total; 
    
    %ratio of redo for set size 2  
    redos = length(find(subNo==j & ss==2 & choice == 2)); 
    total = length(find(subNo==j & ss==2 & choice ~= 9));
    ss2(i) = redos / total; 
    
    %ratio of redo for set size 3
    redos = length(find(subNo==j & ss==3 & choice == 2)); 
    total = length(find(subNo==j & ss==3 & choice ~= 9));
    ss3(i) = redos / total; 
    
    %ratio of redo for set size 4
    redos = length(find(subNo==j & ss==4 & choice == 2)); 
    total = length(find(subNo==j & ss==4 & choice ~= 9));
    ss4(i) = redos / total; 
    
    %ratio of redo for ignore per session                  
        redos = length(find(subNo==j & condition==0 & ses==1 & choice == 2)); 
        total = length(find(subNo==j & condition==0 & ses==1 & choice ~= 9));
    ses1_I(i) = redos / total; 
        redos = length(find(subNo==j & condition==0 & ses==2 & choice == 2)); 
        total = length(find(subNo==j & condition==0 & ses==2 & choice ~= 9));
    ses2_I(i) = redos / total; 
        redos = length(find(subNo==j & condition==0 & ses==3 & choice == 2)); 
        total = length(find(subNo==j & condition==0 & ses==3 & choice ~= 9));
    ses3_I(i) = redos / total;      
        
    %ratio of redo for update per session                  
        redos = length(find(subNo==j & condition==2 & ses==1 & choice == 2)); 
        total = length(find(subNo==j & condition==2 & ses==1 & choice ~= 9));
    ses1_U(i) = redos / total; 
        redos = length(find(subNo==j & condition==2 & ses==2 & choice == 2)); 
        total = length(find(subNo==j & condition==2 & ses==2 & choice ~= 9));
    ses2_U(i) = redos / total; 
        redos = length(find(subNo==j & condition==2 & ses==3 & choice == 2)); 
        total = length(find(subNo==j & condition==2 & ses==3 & choice ~= 9));
    ses3_U(i) = redos / total;     
    
    %ratio of redo for ignore per set size                  
        redos = length(find(subNo==j & condition==0 & ss==1 & choice == 2)); 
        total = length(find(subNo==j & condition==0 & ss==1 & choice ~= 9));
    I_ss1(i) = redos / total; 
        redos = length(find(subNo==j & condition==0 & ss==2 & choice == 2)); 
        total = length(find(subNo==j & condition==0 & ss==2 & choice ~= 9));
    I_ss2(i) = redos / total; 
        redos = length(find(subNo==j & condition==0 & ss==3 & choice == 2)); 
        total = length(find(subNo==j & condition==0 & ss==3 & choice ~= 9));
    I_ss3(i) = redos / total;      
        redos = length(find(subNo==j & condition==0 & ss==4 & choice == 2)); 
        total = length(find(subNo==j & condition==0 & ss==4 & choice ~= 9));
    I_ss4(i) = redos / total; 
    
    %ratio of redo for update per set size                  
        redos = length(find(subNo==j & condition==2 & ss==1 & choice == 2)); 
        total = length(find(subNo==j & condition==2 & ss==1 & choice ~= 9));
    U_ss1(i) = redos / total; 
        redos = length(find(subNo==j & condition==2 & ss==2 & choice == 2)); 
        total = length(find(subNo==j & condition==2 & ss==2 & choice ~= 9));
    U_ss2(i) = redos / total; 
        redos = length(find(subNo==j & condition==2 & ss==3 & choice == 2)); 
        total = length(find(subNo==j & condition==2 & ss==3 & choice ~= 9));
    U_ss3(i) = redos / total;      
        redos = length(find(subNo==j & condition==2 & ss==4 & choice == 2)); 
        total = length(find(subNo==j & condition==2 & ss==4 & choice ~= 9));
    U_ss4(i) = redos / total;   
    
    
    %ratio of redo for session 1 per set size                  
        redos = length(find(subNo==j & ses==1 & ss==1 & choice == 2)); 
        total = length(find(subNo==j & ses==1 & ss==1 & choice ~= 9));
    ses1_ss1(i) = redos / total; 
        redos = length(find(subNo==j & ses==1 & ss==2 & choice == 2)); 
        total = length(find(subNo==j & ses==1 & ss==2 & choice ~= 9));
    ses1_ss2(i) = redos / total; 
        redos = length(find(subNo==j & ses==1 & ss==3 & choice == 2)); 
        total = length(find(subNo==j & ses==1 & ss==3 & choice ~= 9));
    ses1_ss3(i) = redos / total;      
        redos = length(find(subNo==j & ses==1 & ss==4 & choice == 2)); 
        total = length(find(subNo==j & ses==1 & ss==4 & choice ~= 9));
    ses1_ss4(i) = redos / total;
    
    %ratio of redo for session 2 per set size                  
        redos = length(find(subNo==j & ses==2 & ss==1 & choice == 2)); 
        total = length(find(subNo==j & ses==2 & ss==1 & choice ~= 9));
    ses2_ss1(i) = redos / total; 
        redos = length(find(subNo==j & ses==2 & ss==2 & choice == 2)); 
        total = length(find(subNo==j & ses==2 & ss==2 & choice ~= 9));
    ses2_ss2(i) = redos / total; 
        redos = length(find(subNo==j & ses==2 & ss==3 & choice == 2)); 
        total = length(find(subNo==j & ses==2 & ss==3 & choice ~= 9));
    ses2_ss3(i) = redos / total;      
        redos = length(find(subNo==j & ses==2 & ss==4 & choice == 2)); 
        total = length(find(subNo==j & ses==2 & ss==4 & choice ~= 9));
    ses2_ss4(i) = redos / total; 

    %ratio of redo for session 3 per set size                  
        redos = length(find(subNo==j & ses==3 & ss==1 & choice == 2)); 
        total = length(find(subNo==j & ses==3 & ss==1 & choice ~= 9));
    ses3_ss1(i) = redos / total; 
        redos = length(find(subNo==j & ses==3 & ss==2 & choice == 2)); 
        total = length(find(subNo==j & ses==3 & ss==2 & choice ~= 9));
    ses3_ss2(i) = redos / total; 
        redos = length(find(subNo==j & ses==3 & ss==3 & choice == 2)); 
        total = length(find(subNo==j & ses==3 & ss==3 & choice ~= 9));
    ses3_ss3(i) = redos / total;      
        redos = length(find(subNo==j & ses==3 & ss==4 & choice == 2)); 
        total = length(find(subNo==j & ses==3 & ss==4 & choice ~= 9));
    ses3_ss4(i) = redos / total; 
        
    
    %ratio of redo per session per condition per set size
        redos = length(find(subNo==j & ses==1 & condition==0 & ss==1 & choice == 2)); 
        total = length(find(subNo==j & ses==1 & condition==0 & ss==1 & choice ~= 9));
    ses1_I_1(i) = redos / total; 
        redos = length(find(subNo==j & ses==1 & condition==0 & ss==2 & choice == 2)); 
        total = length(find(subNo==j & ses==1 & condition==0 & ss==2 & choice ~= 9));
    ses1_I_2(i) = redos / total; 
        redos = length(find(subNo==j & ses==1 & condition==0 & ss==3 & choice == 2)); 
        total = length(find(subNo==j & ses==1 & condition==0 & ss==3 & choice ~= 9));
    ses1_I_3(i) = redos / total; 
        redos = length(find(subNo==j & ses==1 & condition==0 & ss==4 & choice == 2)); 
        total = length(find(subNo==j & ses==1 & condition==0 & ss==4 & choice ~= 9));
    ses1_I_4(i) = redos / total; 
    
        redos = length(find(subNo==j & ses==2 & condition==0 & ss==1 & choice == 2)); 
        total = length(find(subNo==j & ses==2 & condition==0 & ss==1 & choice ~= 9));
    ses2_I_1(i) = redos / total; 
        redos = length(find(subNo==j & ses==2 & condition==0 & ss==2 & choice == 2)); 
        total = length(find(subNo==j & ses==2 & condition==0 & ss==2 & choice ~= 9));
    ses2_I_2(i) = redos / total; 
        redos = length(find(subNo==j & ses==2 & condition==0 & ss==3 & choice == 2)); 
        total = length(find(subNo==j & ses==2 & condition==0 & ss==3 & choice ~= 9));
    ses2_I_3(i) = redos / total; 
        redos = length(find(subNo==j & ses==2 & condition==0 & ss==4 & choice == 2)); 
        total = length(find(subNo==j & ses==2 & condition==0 & ss==4 & choice ~= 9));
    ses2_I_4(i) = redos / total; 
    
        redos = length(find(subNo==j & ses==3 & condition==0 & ss==1 & choice == 2)); 
        total = length(find(subNo==j & ses==3 & condition==0 & ss==1 & choice ~= 9));
    ses3_I_1(i) = redos / total; 
        redos = length(find(subNo==j & ses==3 & condition==0 & ss==2 & choice == 2)); 
        total = length(find(subNo==j & ses==3 & condition==0 & ss==2 & choice ~= 9));
    ses3_I_2(i) = redos / total; 
        redos = length(find(subNo==j & ses==3 & condition==0 & ss==3 & choice == 2)); 
        total = length(find(subNo==j & ses==3 & condition==0 & ss==3 & choice ~= 9));
    ses3_I_3(i) = redos / total; 
        redos = length(find(subNo==j & ses==3 & condition==0 & ss==4 & choice == 2)); 
        total = length(find(subNo==j & ses==3 & condition==0 & ss==4 & choice ~= 9));
    ses3_I_4(i) = redos / total; 
    
        redos = length(find(subNo==j & ses==1 & condition==2 & ss==1 & choice == 2)); 
        total = length(find(subNo==j & ses==1 & condition==2 & ss==1 & choice ~= 9));
    ses1_U_1(i) = redos / total; 
        redos = length(find(subNo==j & ses==1 & condition==2 & ss==2 & choice == 2)); 
        total = length(find(subNo==j & ses==1 & condition==2 & ss==2 & choice ~= 9));
    ses1_U_2(i) = redos / total; 
        redos = length(find(subNo==j & ses==1 & condition==2 & ss==3 & choice == 2)); 
        total = length(find(subNo==j & ses==1 & condition==2 & ss==3 & choice ~= 9));
    ses1_U_3(i) = redos / total; 
        redos = length(find(subNo==j & ses==1 & condition==2 & ss==4 & choice == 2)); 
        total = length(find(subNo==j & ses==1 & condition==2 & ss==4 & choice ~= 9));
    ses1_U_4(i) = redos / total; 
    
        redos = length(find(subNo==j & ses==2 & condition==2 & ss==1 & choice == 2)); 
        total = length(find(subNo==j & ses==2 & condition==2 & ss==1 & choice ~= 9));
    ses2_U_1(i) = redos / total; 
        redos = length(find(subNo==j & ses==2 & condition==2 & ss==2 & choice == 2)); 
        total = length(find(subNo==j & ses==2 & condition==2 & ss==2 & choice ~= 9));
    ses2_U_2(i) = redos / total; 
        redos = length(find(subNo==j & ses==2 & condition==2 & ss==3 & choice == 2)); 
        total = length(find(subNo==j & ses==2 & condition==2 & ss==3 & choice ~= 9));
    ses2_U_3(i) = redos / total; 
        redos = length(find(subNo==j & ses==2 & condition==2 & ss==4 & choice == 2)); 
        total = length(find(subNo==j & ses==2 & condition==2 & ss==4 & choice ~= 9));
    ses2_U_4(i) = redos / total; 
    
        redos = length(find(subNo==j & ses==3 & condition==2 & ss==1 & choice == 2)); 
        total = length(find(subNo==j & ses==3 & condition==2 & ss==1 & choice ~= 9));
    ses3_U_1(i) = redos / total; 
        redos = length(find(subNo==j & ses==3 & condition==2 & ss==2 & choice == 2)); 
        total = length(find(subNo==j & ses==3 & condition==2 & ss==2 & choice ~= 9));
    ses3_U_2(i) = redos / total; 
        redos = length(find(subNo==j & ses==3 & condition==2 & ss==3 & choice == 2)); 
        total = length(find(subNo==j & ses==3 & condition==2 & ss==3 & choice ~= 9));
    ses3_U_3(i) = redos / total; 
        redos = length(find(subNo==j & ses==3 & condition==2 & ss==4 & choice == 2)); 
        total = length(find(subNo==j & ses==3 & condition==2 & ss==4 & choice ~= 9));
    ses3_U_4(i) = redos / total; 

    i = i+1;
end


%% save ratio redo data in wide format
ratioRedo_wide_format=[n_sub' Total' ses1' ses2' ses3' I' U' ss1' ss2' ss3' ss4' ses1_I' ses2_I' ses3_I' ses1_U' ses2_U' ses3_U'...
    I_ss1' I_ss2' I_ss3' I_ss4' U_ss1' U_ss2' U_ss3' U_ss4' ses1_ss1' ses1_ss2' ses1_ss3' ses1_ss4' ses2_ss1' ses2_ss2' ses2_ss3' ses2_ss4'...
    ses3_ss1' ses3_ss2' ses3_ss3' ses3_ss4' ses1_I_1' ses1_I_2' ses1_I_3' ses1_I_4' ses2_I_1' ses2_I_2' ses2_I_3' ses2_I_4' ses3_I_1' ses3_I_2'...
    ses3_I_3' ses3_I_4' ses1_U_1' ses1_U_2' ses1_U_3' ses1_U_4' ses2_U_1' ses2_U_2' ses2_U_3' ses2_U_4' ses3_U_1' ses3_U_2' ses3_U_3' ses3_U_4'];
names={'sID' 'Total' 'ses1' 'ses2' 'ses3'  'I' 'U' 'ss1' 'ss2' 'ss3' 'ss4' 'ses1_I' 'ses2_I' 'ses3_I' 'ses1_U' 'ses2_U' 'ses3_U'...
    'I_ss1' 'I_ss2' 'I_ss3' 'I_ss4' 'U_ss1' 'U_ss2' 'U_ss3' 'U_ss4' 'ses1_ss1' 'ses1_ss2' 'ses1_ss3' 'ses1_ss4' 'ses2_ss1' 'ses2_ss2' 'ses2_ss3' 'ses2_ss4'...
    'ses3_ss1' 'ses3_ss2' 'ses3_ss3' 'ses3_ss4' 'ses1_I_1' 'ses1_I_2' 'ses1_I_3' 'ses1_I_4' 'ses2_I_1' 'ses2_I_2' 'ses2_I_3' 'ses2_I_4' 'ses3_I_1' 'ses3_I_2'... 
    'ses3_I_3' 'ses3_I_4' 'ses1_U_1' 'ses1_U_2' 'ses1_U_3' 'ses1_U_4' 'ses2_U_1' 'ses2_U_2' 'ses2_U_3' 'ses2_U_4' 'ses3_U_1' 'ses3_U_2' 'ses3_U_3' 'ses3_U_4'};
xlswrite('ratioRedo_wide_format.xlsx',names,1,'A1:BI1');
xlswrite('ratioRedo_wide_format.xlsx',ratioRedo_wide_format,1,'A2:BI51');
csvwrite('ratioRedo_wide_format.csv',ratioRedo_wide_format);

%% save ratio redo data in long format
subs                    = repmat(n_sub',24,1);
session                 = repmat([1 2 3], 200, 1); session = session(:); session = repmat(session, 2, 1);
setsize                 = repmat([1 2 3 4], 50, 1); setsize = setsize(:); setsize = repmat(setsize, 6, 1);
cond                    = repmat([0 2], 600, 1); cond = cond(:); 
ratio                   = [ses1_I_1'; ses1_I_2'; ses1_I_3'; ses1_I_4'; ses2_I_1'; ses2_I_2'; ses2_I_3'; ses2_I_4'; ses3_I_1'; ses3_I_2'; ses3_I_3'; ses3_I_4'; ses1_U_1'; ses1_U_2'; ses1_U_3'; ses1_U_4'; ses2_U_1'; ses2_U_2'; ses2_U_3'; ses2_U_4'; ses3_U_1'; ses3_U_2'; ses3_U_3'; ses3_U_4'];
ratioRedo_long_format   = [subs session cond setsize ratio];

names={'sID' 'session' 'condition' 'setsize' 'ratio_redo'};
xlswrite('ratioRedo_long_format.xlsx',names,1,'A1:EI1');
xlswrite('ratioRedo_long_format.xlsx',ratioRedo_long_format,1,'A2:E1201');
csvwrite('ratioRedo_long_format.csv',ratioRedo_long_format);
