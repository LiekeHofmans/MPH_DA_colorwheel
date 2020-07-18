% This script calculates median deviances and rt's per subject on the color wheel task. 
% Data comes from CWdata_long_format, a derivative of the raw datafiles, which summarizes the most relevant data from the total data from the colorwheel task
% subNo = subject number
% condition 0 = ignore (distracter resistance working memory trials); Type 2 = update (flexible updating working memory trials)
% ss = set size: 1-4 items to be remembered


clear; 
clc;

%% settings %%

% set directories
data_dir    = 'P:\3017048.01\bids\derivatives\beh\color_wheel\color_wheel\';
cd(data_dir);

% set subjects and sessions to be used
n_sub   = [1:25,51:75];
n_ses   = 1:3;

% load and define data
load('CWdata_long_format.csv');
% 'sID' 'session' 'trial' 'block' 'absDeviance' 'rawDeviance' 'RT' 'set_size' 'type_IU' 'lure_deviance' 'probeColNum' 'wheelStart' 'probeLoc'
subNo       = CWdata_long_format(:,1);
ses         = CWdata_long_format(:,2);
absdev      = CWdata_long_format(:,5);
rawdev      = CWdata_long_format(:,6);
rt          = CWdata_long_format(:,7);
ss          = CWdata_long_format(:,8);
condition   = CWdata_long_format(:,9);

%% calculate median deviances %% 

i = 1;
for j=n_sub

% Median deviance overall    
Total(i)=nanmedian(absdev(subNo==j));    

% Median deviance per session
ses1(i)=nanmedian(absdev(subNo==j & ses==1));
ses2(i)=nanmedian(absdev(subNo==j & ses==2));
ses3(i)=nanmedian(absdev(subNo==j & ses==3));

% Median deviance per condition
I(i)=nanmedian(absdev(subNo==j & condition==0));
U(i)=nanmedian(absdev(subNo==j & condition==2));

% Median deviance per set size
ss1(i)=nanmedian(absdev(subNo==j & ss==1));
ss2(i)=nanmedian(absdev(subNo==j & ss==2));
ss3(i)=nanmedian(absdev(subNo==j & ss==3));
ss4(i)=nanmedian(absdev(subNo==j & ss==4));

% Median deviance per session per condition
ses1_I(i)=nanmedian(absdev(subNo==j & ses==1 & condition==0));
ses2_I(i)=nanmedian(absdev(subNo==j & ses==2 & condition==0));
ses3_I(i)=nanmedian(absdev(subNo==j & ses==3 & condition==0));
ses1_U(i)=nanmedian(absdev(subNo==j & ses==1 & condition==2));
ses2_U(i)=nanmedian(absdev(subNo==j & ses==2 & condition==2));
ses3_U(i)=nanmedian(absdev(subNo==j & ses==3 & condition==2));

% Median deviance per condition per set size
I_ss1(i)=nanmedian(absdev(subNo==j & ss==1 & condition==0));
I_ss2(i)=nanmedian(absdev(subNo==j & ss==2 & condition==0));
I_ss3(i)=nanmedian(absdev(subNo==j & ss==3 & condition==0));
I_ss4(i)=nanmedian(absdev(subNo==j & ss==4 & condition==0));
U_ss1(i)=nanmedian(absdev(subNo==j & ss==1 & condition==2));
U_ss2(i)=nanmedian(absdev(subNo==j & ss==2 & condition==2));
U_ss3(i)=nanmedian(absdev(subNo==j & ss==3 & condition==2));
U_ss4(i)=nanmedian(absdev(subNo==j & ss==4 & condition==2));

% Median deviance per session per set size
ses1_ss1(i)=nanmedian(absdev(subNo==j & ses==1 & ss==1));
ses1_ss2(i)=nanmedian(absdev(subNo==j & ses==1 & ss==2));
ses1_ss3(i)=nanmedian(absdev(subNo==j & ses==1 & ss==3));
ses1_ss4(i)=nanmedian(absdev(subNo==j & ses==1 & ss==4));
ses2_ss1(i)=nanmedian(absdev(subNo==j & ses==2 & ss==1));
ses2_ss2(i)=nanmedian(absdev(subNo==j & ses==2 & ss==2));
ses2_ss3(i)=nanmedian(absdev(subNo==j & ses==2 & ss==3));
ses2_ss4(i)=nanmedian(absdev(subNo==j & ses==2 & ss==4));
ses3_ss1(i)=nanmedian(absdev(subNo==j & ses==3 & ss==1));
ses3_ss2(i)=nanmedian(absdev(subNo==j & ses==3 & ss==2));
ses3_ss3(i)=nanmedian(absdev(subNo==j & ses==3 & ss==3));
ses3_ss4(i)=nanmedian(absdev(subNo==j & ses==3 & ss==4));

% Median deviance per session per condition per set size
ses1_I_1(i)=nanmedian(absdev(subNo==j & ses==1 & condition==0 & ss==1)); %session 1, Ignore, set size 1; calculating median while ignoring NaN values 
ses1_I_2(i)=nanmedian(absdev(subNo==j & ses==1 & condition==0 & ss==2));
ses1_I_3(i)=nanmedian(absdev(subNo==j & ses==1 & condition==0 & ss==3));
ses1_I_4(i)=nanmedian(absdev(subNo==j & ses==1 & condition==0 & ss==4));

ses2_I_1(i)=nanmedian(absdev(subNo==j & ses==2 & condition==0 & ss==1));  
ses2_I_2(i)=nanmedian(absdev(subNo==j & ses==2 & condition==0 & ss==2));
ses2_I_3(i)=nanmedian(absdev(subNo==j & ses==2 & condition==0 & ss==3));
ses2_I_4(i)=nanmedian(absdev(subNo==j & ses==2 & condition==0 & ss==4));

ses3_I_1(i)=nanmedian(absdev(subNo==j & ses==3 & condition==0 & ss==1)); 
ses3_I_2(i)=nanmedian(absdev(subNo==j & ses==3 & condition==0 & ss==2));
ses3_I_3(i)=nanmedian(absdev(subNo==j & ses==3 & condition==0 & ss==3));
ses3_I_4(i)=nanmedian(absdev(subNo==j & ses==3 & condition==0 & ss==4));


ses1_U_1(i)=nanmedian(absdev(subNo==j & ses==1 & condition==2 & ss==1));
ses1_U_2(i)=nanmedian(absdev(subNo==j & ses==1 & condition==2 & ss==2));
ses1_U_3(i)=nanmedian(absdev(subNo==j & ses==1 & condition==2 & ss==3));
ses1_U_4(i)=nanmedian(absdev(subNo==j & ses==1 & condition==2 & ss==4));

ses2_U_1(i)=nanmedian(absdev(subNo==j & ses==2 & condition==2 & ss==1));
ses2_U_2(i)=nanmedian(absdev(subNo==j & ses==2 & condition==2 & ss==2));
ses2_U_3(i)=nanmedian(absdev(subNo==j & ses==2 & condition==2 & ss==3));
ses2_U_4(i)=nanmedian(absdev(subNo==j & ses==2 & condition==2 & ss==4));

ses3_U_1(i)=nanmedian(absdev(subNo==j & ses==3 & condition==2 & ss==1));
ses3_U_2(i)=nanmedian(absdev(subNo==j & ses==3 & condition==2 & ss==2));
ses3_U_3(i)=nanmedian(absdev(subNo==j & ses==3 & condition==2 & ss==3));
ses3_U_4(i)=nanmedian(absdev(subNo==j & ses==3 & condition==2 & ss==4));

i = i+1;
end 

% save median deviances
median_deviance=[n_sub' Total' ses1' ses2' ses3' I' U' ss1' ss2' ss3' ss4' ses1_I' ses2_I' ses3_I' ses1_U' ses2_U' ses3_U'...
    I_ss1' I_ss2' I_ss3' I_ss4' U_ss1' U_ss2' U_ss3' U_ss4' ses1_ss1' ses1_ss2' ses1_ss3' ses1_ss4' ses2_ss1' ses2_ss2' ses2_ss3' ses2_ss4'...
    ses3_ss1' ses3_ss2' ses3_ss3' ses3_ss4' ses1_I_1' ses1_I_2' ses1_I_3' ses1_I_4' ses2_I_1' ses2_I_2' ses2_I_3' ses2_I_4' ses3_I_1' ses3_I_2'...
    ses3_I_3' ses3_I_4' ses1_U_1' ses1_U_2' ses1_U_3' ses1_U_4' ses2_U_1' ses2_U_2' ses2_U_3' ses2_U_4' ses3_U_1' ses3_U_2' ses3_U_3' ses3_U_4'];
names={'sID' 'Total' 'ses1' 'ses2' 'ses3'  'I' 'U' 'ss1' 'ss2' 'ss3' 'ss4' 'ses1_I' 'ses2_I' 'ses3_I' 'ses1_U' 'ses2_U' 'ses3_U'...
    'I_ss1' 'I_ss2' 'I_ss3' 'I_ss4' 'U_ss1' 'U_ss2' 'U_ss3' 'U_ss4' 'ses1_ss1' 'ses1_ss2' 'ses1_ss3' 'ses1_ss4' 'ses2_ss1' 'ses2_ss2' 'ses2_ss3' 'ses2_ss4'...
    'ses3_ss1' 'ses3_ss2' 'ses3_ss3' 'ses3_ss4' 'ses1_I_1' 'ses1_I_2' 'ses1_I_3' 'ses1_I_4' 'ses2_I_1' 'ses2_I_2' 'ses2_I_3' 'ses2_I_4' 'ses3_I_1' 'ses3_I_2'... 
    'ses3_I_3' 'ses3_I_4' 'ses1_U_1' 'ses1_U_2' 'ses1_U_3' 'ses1_U_4' 'ses2_U_1' 'ses2_U_2' 'ses2_U_3' 'ses2_U_4' 'ses3_U_1' 'ses3_U_2' 'ses3_U_3' 'ses3_U_4'};
xlswrite('median_deviance_abs.xlsx',names,1,'A1:BI1');
xlswrite('median_deviance_abs.xlsx',median_deviance,1,'A2:BI51');
csvwrite('median_deviance_abs.csv',median_deviance);


%% calculate median reaction times %% 

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

i = i+1;
end 

% save median RT
median_RT=[n_sub' Total' ses1' ses2' ses3' I' U' ss1' ss2' ss3' ss4' ses1_I' ses2_I' ses3_I' ses1_U' ses2_U' ses3_U'...
    I_ss1' I_ss2' I_ss3' I_ss4' U_ss1' U_ss2' U_ss3' U_ss4' ses1_ss1' ses1_ss2' ses1_ss3' ses1_ss4' ses2_ss1' ses2_ss2' ses2_ss3' ses2_ss4'...
    ses3_ss1' ses3_ss2' ses3_ss3' ses3_ss4' ses1_I_1' ses1_I_2' ses1_I_3' ses1_I_4' ses2_I_1' ses2_I_2' ses2_I_3' ses2_I_4' ses3_I_1' ses3_I_2'...
    ses3_I_3' ses3_I_4' ses1_U_1' ses1_U_2' ses1_U_3' ses1_U_4' ses2_U_1' ses2_U_2' ses2_U_3' ses2_U_4' ses3_U_1' ses3_U_2' ses3_U_3' ses3_U_4'];
names={'sID' 'Total' 'ses1' 'ses2' 'ses3'  'I' 'U' 'ss1' 'ss2' 'ss3' 'ss4' 'ses1_I' 'ses2_I' 'ses3_I' 'ses1_U' 'ses2_U' 'ses3_U'...
    'I_ss1' 'I_ss2' 'I_ss3' 'I_ss4' 'U_ss1' 'U_ss2' 'U_ss3' 'U_ss4' 'ses1_ss1' 'ses1_ss2' 'ses1_ss3' 'ses1_ss4' 'ses2_ss1' 'ses2_ss2' 'ses2_ss3' 'ses2_ss4'...
    'ses3_ss1' 'ses3_ss2' 'ses3_ss3' 'ses3_ss4' 'ses1_I_1' 'ses1_I_2' 'ses1_I_3' 'ses1_I_4' 'ses2_I_1' 'ses2_I_2' 'ses2_I_3' 'ses2_I_4' 'ses3_I_1' 'ses3_I_2'... 
    'ses3_I_3' 'ses3_I_4' 'ses1_U_1' 'ses1_U_2' 'ses1_U_3' 'ses1_U_4' 'ses2_U_1' 'ses2_U_2' 'ses2_U_3' 'ses2_U_4' 'ses3_U_1' 'ses3_U_2' 'ses3_U_3' 'ses3_U_4'};
xlswrite('median_RT.xlsx',names,1,'A1:BI1');
xlswrite('median_RT.xlsx',median_RT,1,'A2:BI51');
csvwrite('median_RT.csv',median_RT);

% %% calculate SD raw deviance (=inverse precision) %% 
% 
% i = 1;
% for j=n_sub
% 
% % SD overall    
% Total(i)=nanstd(rawdev(subNo==j));    
% 
% % SD per session
% ses1(i)=nanstd(rawdev(subNo==j & ses==1));
% ses2(i)=nanstd(rawdev(subNo==j & ses==2));
% ses3(i)=nanstd(rawdev(subNo==j & ses==3));
% 
% % SD per condition
% I(i)=nanstd(rawdev(subNo==j & condition==0));
% U(i)=nanstd(rawdev(subNo==j & condition==2));
% 
% % SD per set size
% ss1(i)=nanstd(rawdev(subNo==j & ss==1));
% ss2(i)=nanstd(rawdev(subNo==j & ss==2));
% ss3(i)=nanstd(rawdev(subNo==j & ss==3));
% ss4(i)=nanstd(rawdev(subNo==j & ss==4));
% 
% % SD per session per condition
% ses1_I(i)=nanstd(rawdev(subNo==j & ses==1 & condition==0));
% ses2_I(i)=nanstd(rawdev(subNo==j & ses==2 & condition==0));
% ses3_I(i)=nanstd(rawdev(subNo==j & ses==3 & condition==0));
% ses1_U(i)=nanstd(rawdev(subNo==j & ses==1 & condition==2));
% ses2_U(i)=nanstd(rawdev(subNo==j & ses==2 & condition==2));
% ses3_U(i)=nanstd(rawdev(subNo==j & ses==3 & condition==2));
% 
% % SD per condition per set size
% I_ss1(i)=nanstd(rawdev(subNo==j & ss==1 & condition==0));
% I_ss2(i)=nanstd(rawdev(subNo==j & ss==2 & condition==0));
% I_ss3(i)=nanstd(rawdev(subNo==j & ss==3 & condition==0));
% I_ss4(i)=nanstd(rawdev(subNo==j & ss==4 & condition==0));
% U_ss1(i)=nanstd(rawdev(subNo==j & ss==1 & condition==2));
% U_ss2(i)=nanstd(rawdev(subNo==j & ss==2 & condition==2));
% U_ss3(i)=nanstd(rawdev(subNo==j & ss==3 & condition==2));
% U_ss4(i)=nanstd(rawdev(subNo==j & ss==4 & condition==2));
% 
% % SD per session per set size
% ses1_ss1(i)=nanstd(rawdev(subNo==j & ses==1 & ss==1));
% ses1_ss2(i)=nanstd(rawdev(subNo==j & ses==1 & ss==2));
% ses1_ss3(i)=nanstd(rawdev(subNo==j & ses==1 & ss==3));
% ses1_ss4(i)=nanstd(rawdev(subNo==j & ses==1 & ss==4));
% ses2_ss1(i)=nanstd(rawdev(subNo==j & ses==2 & ss==1));
% ses2_ss2(i)=nanstd(rawdev(subNo==j & ses==2 & ss==2));
% ses2_ss3(i)=nanstd(rawdev(subNo==j & ses==2 & ss==3));
% ses2_ss4(i)=nanstd(rawdev(subNo==j & ses==2 & ss==4));
% ses3_ss1(i)=nanstd(rawdev(subNo==j & ses==3 & ss==1));
% ses3_ss2(i)=nanstd(rawdev(subNo==j & ses==3 & ss==2));
% ses3_ss3(i)=nanstd(rawdev(subNo==j & ses==3 & ss==3));
% ses3_ss4(i)=nanstd(rawdev(subNo==j & ses==3 & ss==4));
% 
% % SD per session per condition per set size
% ses1_I_1(i)=nanstd(rawdev(subNo==j & ses==1 & condition==0 & ss==1)); %session 1, Ignore, set size 1; calculating median while ignoring NaN values 
% ses1_I_2(i)=nanstd(rawdev(subNo==j & ses==1 & condition==0 & ss==2));
% ses1_I_3(i)=nanstd(rawdev(subNo==j & ses==1 & condition==0 & ss==3));
% ses1_I_4(i)=nanstd(rawdev(subNo==j & ses==1 & condition==0 & ss==4));
% 
% ses2_I_1(i)=nanstd(rawdev(subNo==j & ses==2 & condition==0 & ss==1));  
% ses2_I_2(i)=nanstd(rawdev(subNo==j & ses==2 & condition==0 & ss==2));
% ses2_I_3(i)=nanstd(rawdev(subNo==j & ses==2 & condition==0 & ss==3));
% ses2_I_4(i)=nanstd(rawdev(subNo==j & ses==2 & condition==0 & ss==4));
% 
% ses3_I_1(i)=nanstd(rawdev(subNo==j & ses==3 & condition==0 & ss==1)); 
% ses3_I_2(i)=nanstd(rawdev(subNo==j & ses==3 & condition==0 & ss==2));
% ses3_I_3(i)=nanstd(rawdev(subNo==j & ses==3 & condition==0 & ss==3));
% ses3_I_4(i)=nanstd(rawdev(subNo==j & ses==3 & condition==0 & ss==4));
% 
% 
% ses1_U_1(i)=nanstd(rawdev(subNo==j & ses==1 & condition==2 & ss==1));
% ses1_U_2(i)=nanstd(rawdev(subNo==j & ses==1 & condition==2 & ss==2));
% ses1_U_3(i)=nanstd(rawdev(subNo==j & ses==1 & condition==2 & ss==3));
% ses1_U_4(i)=nanstd(rawdev(subNo==j & ses==1 & condition==2 & ss==4));
% 
% ses2_U_1(i)=nanstd(rawdev(subNo==j & ses==2 & condition==2 & ss==1));
% ses2_U_2(i)=nanstd(rawdev(subNo==j & ses==2 & condition==2 & ss==2));
% ses2_U_3(i)=nanstd(rawdev(subNo==j & ses==2 & condition==2 & ss==3));
% ses2_U_4(i)=nanstd(rawdev(subNo==j & ses==2 & condition==2 & ss==4));
% 
% ses3_U_1(i)=nanstd(rawdev(subNo==j & ses==3 & condition==2 & ss==1));
% ses3_U_2(i)=nanstd(rawdev(subNo==j & ses==3 & condition==2 & ss==2));
% ses3_U_3(i)=nanstd(rawdev(subNo==j & ses==3 & condition==2 & ss==3));
% ses3_U_4(i)=nanstd(rawdev(subNo==j & ses==3 & condition==2 & ss==4));
% 
% i = i+1;
% end 
% 
% % save SD
% SD=[n_sub' Total' ses1' ses2' ses3' I' U' ss1' ss2' ss3' ss4' ses1_I' ses2_I' ses3_I' ses1_U' ses2_U' ses3_U'...
%     I_ss1' I_ss2' I_ss3' I_ss4' U_ss1' U_ss2' U_ss3' U_ss4' ses1_ss1' ses1_ss2' ses1_ss3' ses1_ss4' ses2_ss1' ses2_ss2' ses2_ss3' ses2_ss4'...
%     ses3_ss1' ses3_ss2' ses3_ss3' ses3_ss4' ses1_I_1' ses1_I_2' ses1_I_3' ses1_I_4' ses2_I_1' ses2_I_2' ses2_I_3' ses2_I_4' ses3_I_1' ses3_I_2'...
%     ses3_I_3' ses3_I_4' ses1_U_1' ses1_U_2' ses1_U_3' ses1_U_4' ses2_U_1' ses2_U_2' ses2_U_3' ses2_U_4' ses3_U_1' ses3_U_2' ses3_U_3' ses3_U_4'];
% names={'sID' 'Total' 'ses1' 'ses2' 'ses3'  'I' 'U' 'ss1' 'ss2' 'ss3' 'ss4' 'ses1_I' 'ses2_I' 'ses3_I' 'ses1_U' 'ses2_U' 'ses3_U'...
%     'I_ss1' 'I_ss2' 'I_ss3' 'I_ss4' 'U_ss1' 'U_ss2' 'U_ss3' 'U_ss4' 'ses1_ss1' 'ses1_ss2' 'ses1_ss3' 'ses1_ss4' 'ses2_ss1' 'ses2_ss2' 'ses2_ss3' 'ses2_ss4'...
%     'ses3_ss1' 'ses3_ss2' 'ses3_ss3' 'ses3_ss4' 'ses1_I_1' 'ses1_I_2' 'ses1_I_3' 'ses1_I_4' 'ses2_I_1' 'ses2_I_2' 'ses2_I_3' 'ses2_I_4' 'ses3_I_1' 'ses3_I_2'... 
%     'ses3_I_3' 'ses3_I_4' 'ses1_U_1' 'ses1_U_2' 'ses1_U_3' 'ses1_U_4' 'ses2_U_1' 'ses2_U_2' 'ses2_U_3' 'ses2_U_4' 'ses3_U_1' 'ses3_U_2' 'ses3_U_3' 'ses3_U_4'};
% xlswrite('SD_rawdeviances.xlsx',names,1,'A1:BI1');
% xlswrite('SD_rawdeviances.xlsx',SD,1,'A2:BI51');
% csvwrite('SD_rawdeviances.csv',SD);
% 

