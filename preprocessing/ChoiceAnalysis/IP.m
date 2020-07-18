%% plots for choice data per participant showing amounts offered for the easy option (not redoing the task) on the x axis and
% choice between easy (value = 1) and hard (value = 0) on the y axis. Running this function will
% also save the plots. IPmatrix is an 40*6 matrix, every row is a
% participant and every column the IP for different setsizes. (i1, i2, i3, i4,
% u1, u2, u3, u4)
%
% This script calls LogisticRegressionFunction.m to calculate the IPs

clear; 
clc; 

%% settings %%

% set directories
script_dir  = pwd;
data_dir    = 'P:\3017048.01\bids\derivatives\beh\color_wheel\choice\';
cd(data_dir);
addpath(script_dir);

% set subjects and sessions to be used
subNo   = [1:25,51:75];
sesNo   = 1:3;

% load and define data
load('choicedata_long_format.csv');
% 'sID' 'session' 'trial' 'block' 'condition_IU' 'set_size' 'hardOffer' 'easyOffer' 'locationEasy_LR' 'choice_NR' 'RT'
% % subNo       = choicedata_long_format(:,1);
% % ses         = choicedata_long_format(:,2);
% % condition   = choicedata_long_format(:,5);
% % ss          = choicedata_long_format(:,6);
% % choice      = choicedata_long_format(:,10);

% set parameters
fixedValue=2; %offer for hard option = redo
easyOffer=[0.1 round((0.2:0.2:2.2)*10)/10];
maxValue=max(easyOffer);
minValue=min(easyOffer);
IPforRegression = []; 

% create plots?
doPlots = 0; 


%% select data

% preallocate data arrays
    IPTotal      = [];
    
    IPses1       = [];
    IPses2       = [];
    IPses3       = [];
    
    IPI          = [];
    IPU          = [];

    IPss1        = [];
    IPss2        = [];
    IPss3        = [];
    IPss4        = [];    
    
    IPses1_I      = [];
    IPses2_I      = [];
    IPses3_I      = [];
    IPses1_U      = [];
    IPses2_U      = [];
    IPses3_U      = [];
    
    IPI_ss1      = [];
    IPI_ss2      = [];
    IPI_ss3      = [];
    IPI_ss4      = [];
    IPU_ss1      = [];
    IPU_ss2      = [];
    IPU_ss3      = [];
    IPU_ss4      = [];
    
    IPses1_ss1       = [];
    IPses1_ss2       = [];
    IPses1_ss3       = [];
    IPses1_ss4       = [];  
    IPses2_ss1       = [];
    IPses2_ss2       = [];
    IPses2_ss3       = [];
    IPses2_ss4       = []; 
    IPses3_ss1       = [];
    IPses3_ss2       = [];
    IPses3_ss3       = [];
    IPses3_ss4       = []; 
    
    
    IPses1_I_1   = [];
    IPses1_I_2   = [];
    IPses1_I_3   = [];
    IPses1_I_4   = [];
    
    IPses2_I_1   = [];
    IPses2_I_2   = [];
    IPses2_I_3   = [];
    IPses2_I_4   = [];
    
    IPses3_I_1   = [];
    IPses3_I_2   = [];
    IPses3_I_3   = [];
    IPses3_I_4   = [];
    
    IPses1_U_1   = [];
    IPses1_U_2   = [];
    IPses1_U_3   = [];
    IPses1_U_4   = [];
    
    IPses2_U_1   = [];
    IPses2_U_2   = [];
    IPses2_U_3   = [];
    IPses2_U_4   = [];
    
    IPses3_U_1   = [];
    IPses3_U_2   = [];
    IPses3_U_3   = [];
    IPses3_U_4   = [];

i = 1;    
for j=subNo

    data                        = choicedata_long_format((choicedata_long_format(:,1)==j),:); % select subject specific rows
    data(data(:,10)==9,:)       = []; 
    data(data(:,10)==2,10)      = 0; %recode: easy offer/No redo = 1; hard offer/redo = 0
             
    % prepare data for IP over all trials
    Total       = data(:,8);
    yTotal      = data(:,10);

    % prepare data for IP per session
    ses1        = data(data(:,2)==1,8);
    yses1       = data(data(:,2)==1,10);
    ses2        = data(data(:,2)==2,8);
    yses2       = data(data(:,2)==2,10);
    ses3        = data(data(:,2)==3,8);
    yses3       = data(data(:,2)==3,10);

    % prepare data for IP per condition
    I           = data(data(:,5)==0,8);
    yI          = data(data(:,5)==0,10);
    U           = data(data(:,5)==2,8);
    yU          = data(data(:,5)==2,10);

    % prepare data for IP per set size
    ss1         = data(data(:,6)==1,8);
    yss1        = data(data(:,6)==1,10);
    ss2         = data(data(:,6)==2,8);
    yss2        = data(data(:,6)==2,10);
    ss3         = data(data(:,6)==3,8);
    yss3        = data(data(:,6)==3,10);
    ss4         = data(data(:,6)==4,8);
    yss4        = data(data(:,6)==4,10);
    
    % prepare data for IP per condition per session
    ses1_I    = data((data(:,2)==1 & data(:,5)==0),8);
    yses1_I   = data((data(:,2)==1 & data(:,5)==0),10);
    ses2_I    = data((data(:,2)==2 & data(:,5)==0),8);
    yses2_I   = data((data(:,2)==2 & data(:,5)==0),10);
    ses3_I    = data((data(:,2)==3 & data(:,5)==0),8);
    yses3_I   = data((data(:,2)==3 & data(:,5)==0),10);
    ses1_U    = data((data(:,2)==1 & data(:,5)==2),8);
    yses1_U   = data((data(:,2)==1 & data(:,5)==2),10);
    ses2_U    = data((data(:,2)==2 & data(:,5)==2),8);
    yses2_U   = data((data(:,2)==2 & data(:,5)==2),10);
    ses3_U    = data((data(:,2)==3 & data(:,5)==2),8);
    yses3_U   = data((data(:,2)==3 & data(:,5)==2),10);

    % prepare data for IP per condition per set size
    I_ss1    = data((data(:,6)==1 & data(:,5)==0),8);
    yI_ss1   = data((data(:,6)==1 & data(:,5)==0),10);
    I_ss2    = data((data(:,6)==2 & data(:,5)==0),8);
    yI_ss2   = data((data(:,6)==2 & data(:,5)==0),10);
    I_ss3    = data((data(:,6)==3 & data(:,5)==0),8);
    yI_ss3   = data((data(:,6)==3 & data(:,5)==0),10);
    I_ss4    = data((data(:,6)==4 & data(:,5)==0),8);
    yI_ss4   = data((data(:,6)==4 & data(:,5)==0),10);
    U_ss1    = data((data(:,6)==1 & data(:,5)==2),8);
    yU_ss1   = data((data(:,6)==1 & data(:,5)==2),10);
    U_ss2    = data((data(:,6)==2 & data(:,5)==2),8);
    yU_ss2   = data((data(:,6)==2 & data(:,5)==2),10);
    U_ss3    = data((data(:,6)==3 & data(:,5)==2),8);
    yU_ss3   = data((data(:,6)==3 & data(:,5)==2),10);
    U_ss4    = data((data(:,6)==4 & data(:,5)==2),8);
    yU_ss4   = data((data(:,6)==4 & data(:,5)==2),10);    

    % prepare data for IP per session per set size
    ses1_ss1    = data((data(:,2)==1 & data(:,6)==1),8);
    yses1_ss1   = data((data(:,2)==1 & data(:,6)==1),10);
    ses2_ss1    = data((data(:,2)==2 & data(:,6)==1),8);
    yses2_ss1   = data((data(:,2)==2 & data(:,6)==1),10);
    ses3_ss1    = data((data(:,2)==3 & data(:,6)==1),8);
    yses3_ss1   = data((data(:,2)==3 & data(:,6)==1),10);
    ses1_ss2    = data((data(:,2)==1 & data(:,6)==2),8);
    yses1_ss2   = data((data(:,2)==1 & data(:,6)==2),10);
    ses2_ss2    = data((data(:,2)==2 & data(:,6)==2),8);
    yses2_ss2   = data((data(:,2)==2 & data(:,6)==2),10);
    ses3_ss2    = data((data(:,2)==3 & data(:,6)==2),8);
    yses3_ss2   = data((data(:,2)==3 & data(:,6)==2),10);
    ses1_ss3    = data((data(:,2)==1 & data(:,6)==3),8);
    yses1_ss3   = data((data(:,2)==1 & data(:,6)==3),10);
    ses2_ss3    = data((data(:,2)==2 & data(:,6)==3),8);
    yses2_ss3   = data((data(:,2)==2 & data(:,6)==3),10);
    ses3_ss3    = data((data(:,2)==3 & data(:,6)==3),8);
    yses3_ss3   = data((data(:,2)==3 & data(:,6)==3),10);
    ses1_ss4    = data((data(:,2)==1 & data(:,6)==4),8);
    yses1_ss4   = data((data(:,2)==1 & data(:,6)==4),10);
    ses2_ss4    = data((data(:,2)==2 & data(:,6)==4),8);
    yses2_ss4   = data((data(:,2)==2 & data(:,6)==4),10);
    ses3_ss4    = data((data(:,2)==3 & data(:,6)==4),8);
    yses3_ss4   = data((data(:,2)==3 & data(:,6)==4),10);
    
    % prepare data for IP per session per condition per set size
    ses1_I_1    = data((data(:,2)==1 & data(:,5)==0 & data(:,6)==1),8);
    yses1_I_1   = data((data(:,2)==1 & data(:,5)==0 & data(:,6)==1),10);
    ses1_I_2    = data((data(:,2)==1 & data(:,5)==0 & data(:,6)==2),8);
    yses1_I_2   = data((data(:,2)==1 & data(:,5)==0 & data(:,6)==2),10);
    ses1_I_3    = data((data(:,2)==1 & data(:,5)==0 & data(:,6)==3),8);
    yses1_I_3   = data((data(:,2)==1 & data(:,5)==0 & data(:,6)==3),10);
    ses1_I_4    = data((data(:,2)==1 & data(:,5)==0 & data(:,6)==4),8);
    yses1_I_4   = data((data(:,2)==1 & data(:,5)==0 & data(:,6)==4),10);

    ses2_I_1    = data((data(:,2)==2 & data(:,5)==0 & data(:,6)==1),8);
    yses2_I_1   = data((data(:,2)==2 & data(:,5)==0 & data(:,6)==1),10);
    ses2_I_2    = data((data(:,2)==2 & data(:,5)==0 & data(:,6)==2),8);
    yses2_I_2   = data((data(:,2)==2 & data(:,5)==0 & data(:,6)==2),10);
    ses2_I_3    = data((data(:,2)==2 & data(:,5)==0 & data(:,6)==3),8);
    yses2_I_3   = data((data(:,2)==2 & data(:,5)==0 & data(:,6)==3),10);
    ses2_I_4    = data((data(:,2)==2 & data(:,5)==0 & data(:,6)==4),8);
    yses2_I_4   = data((data(:,2)==2 & data(:,5)==0 & data(:,6)==4),10);

    ses3_I_1    = data((data(:,2)==3 & data(:,5)==0 & data(:,6)==1),8);
    yses3_I_1   = data((data(:,2)==3 & data(:,5)==0 & data(:,6)==1),10);
    ses3_I_2    = data((data(:,2)==3 & data(:,5)==0 & data(:,6)==2),8);
    yses3_I_2   = data((data(:,2)==3 & data(:,5)==0 & data(:,6)==2),10);
    ses3_I_3    = data((data(:,2)==3 & data(:,5)==0 & data(:,6)==3),8);
    yses3_I_3   = data((data(:,2)==3 & data(:,5)==0 & data(:,6)==3),10);
    ses3_I_4    = data((data(:,2)==3 & data(:,5)==0 & data(:,6)==4),8);
    yses3_I_4   = data((data(:,2)==3 & data(:,5)==0 & data(:,6)==4),10);

    ses1_U_1    = data((data(:,2)==1 & data(:,5)==2 & data(:,6)==1),8);
    yses1_U_1   = data((data(:,2)==1 & data(:,5)==2 & data(:,6)==1),10);
    ses1_U_2    = data((data(:,2)==1 & data(:,5)==2 & data(:,6)==2),8);
    yses1_U_2   = data((data(:,2)==1 & data(:,5)==2 & data(:,6)==2),10);
    ses1_U_3    = data((data(:,2)==1 & data(:,5)==2 & data(:,6)==3),8);
    yses1_U_3   = data((data(:,2)==1 & data(:,5)==2 & data(:,6)==3),10);
    ses1_U_4    = data((data(:,2)==1 & data(:,5)==2 & data(:,6)==4),8);
    yses1_U_4   = data((data(:,2)==1 & data(:,5)==2 & data(:,6)==4),10);

    ses2_U_1    = data((data(:,2)==2 & data(:,5)==2 & data(:,6)==1),8);
    yses2_U_1   = data((data(:,2)==2 & data(:,5)==2 & data(:,6)==1),10);
    ses2_U_2    = data((data(:,2)==2 & data(:,5)==2 & data(:,6)==2),8);
    yses2_U_2   = data((data(:,2)==2 & data(:,5)==2 & data(:,6)==2),10);
    ses2_U_3    = data((data(:,2)==2 & data(:,5)==2 & data(:,6)==3),8);
    yses2_U_3   = data((data(:,2)==2 & data(:,5)==2 & data(:,6)==3),10);
    ses2_U_4    = data((data(:,2)==2 & data(:,5)==2 & data(:,6)==4),8);
    yses2_U_4   = data((data(:,2)==2 & data(:,5)==2 & data(:,6)==4),10);

    ses3_U_1    = data((data(:,2)==3 & data(:,5)==2 & data(:,6)==1),8);
    yses3_U_1   = data((data(:,2)==3 & data(:,5)==2 & data(:,6)==1),10);
    ses3_U_2    = data((data(:,2)==3 & data(:,5)==2 & data(:,6)==2),8);
    yses3_U_2   = data((data(:,2)==3 & data(:,5)==2 & data(:,6)==2),10);
    ses3_U_3    = data((data(:,2)==3 & data(:,5)==2 & data(:,6)==3),8);
    yses3_U_3   = data((data(:,2)==3 & data(:,5)==2 & data(:,6)==3),10);
    ses3_U_4    = data((data(:,2)==3 & data(:,5)==2 & data(:,6)==4),8);
    yses3_U_4   = data((data(:,2)==3 & data(:,5)==2 & data(:,6)==4),10);
            
    %% Logistic Regression analyses
    [yfitTotal,IPTotal(i), betas_Total(i)]          = LogisticRegressionFunction(Total,yTotal,minValue,maxValue);
    
    [yfitses1,IPses1(i), betas_ses1(i)]             = LogisticRegressionFunction(ses1,yses1,minValue,maxValue);
    [yfitses2,IPses2(i), betas_ses2(i)]             = LogisticRegressionFunction(ses2,yses2,minValue,maxValue);
    [yfitses3,IPses3(i), betas_ses3(i)]             = LogisticRegressionFunction(ses3,yses3,minValue,maxValue);
    
    [yfitI,IPI(i), betas_I(i)]                      = LogisticRegressionFunction(I,yI,minValue,maxValue);
    [yfitU,IPU(i), betas_U(i)]                      = LogisticRegressionFunction(U,yU,minValue,maxValue);

    [yfitss1,IPss1(i), betas_ss1(i)]              = LogisticRegressionFunction(ss1,yss1,minValue,maxValue);
    [yfitss2,IPss2(i), betas_ss2(i)]              = LogisticRegressionFunction(ss2,yss2,minValue,maxValue);
    [yfitss3,IPss3(i), betas_ss3(i)]              = LogisticRegressionFunction(ss3,yss3,minValue,maxValue);
    [yfitss4,IPss4(i), betas_ss4(i)]              = LogisticRegressionFunction(ss4,yss4,minValue,maxValue);
    
    [yfitses1_I,IPses1_I(i), betas_ses1_I(i)]        = LogisticRegressionFunction(ses1_I,yses1_I,minValue,maxValue);
    [yfitses2_I,IPses2_I(i), betas_ses2_I(i)]        = LogisticRegressionFunction(ses2_I,yses2_I,minValue,maxValue);
    [yfitses3_I,IPses3_I(i), betas_ses3_I(i)]        = LogisticRegressionFunction(ses3_I,yses3_I,minValue,maxValue);
    [yfitses1_U,IPses1_U(i), betas_ses1_U(i)]        = LogisticRegressionFunction(ses1_U,yses1_U,minValue,maxValue);
    [yfitses2_U,IPses2_U(i), betas_ses2_U(i)]        = LogisticRegressionFunction(ses2_U,yses2_U,minValue,maxValue);
    [yfitses3_U,IPses3_U(i), betas_ses3_U(i)]        = LogisticRegressionFunction(ses3_U,yses3_U,minValue,maxValue);

    [yfitI_ss1,IPI_ss1(i), betas_I_ss1(i)]        = LogisticRegressionFunction(I_ss1,yI_ss1,minValue,maxValue);
    [yfitI_ss2,IPI_ss2(i), betas_I_ss2(i)]        = LogisticRegressionFunction(I_ss2,yI_ss2,minValue,maxValue);
    [yfitI_ss3,IPI_ss3(i), betas_I_ss3(i)]        = LogisticRegressionFunction(I_ss3,yI_ss3,minValue,maxValue);
    [yfitI_ss4,IPI_ss4(i), betas_I_ss4(i)]        = LogisticRegressionFunction(I_ss4,yI_ss4,minValue,maxValue);
    [yfitU_ss1,IPU_ss1(i), betas_U_ss1(i)]        = LogisticRegressionFunction(U_ss1,yU_ss1,minValue,maxValue);
    [yfitU_ss2,IPU_ss2(i), betas_U_ss2(i)]        = LogisticRegressionFunction(U_ss2,yU_ss2,minValue,maxValue);
    [yfitU_ss3,IPU_ss3(i), betas_U_ss3(i)]        = LogisticRegressionFunction(U_ss3,yU_ss3,minValue,maxValue);
    [yfitU_ss4,IPU_ss4(i), betas_U_ss4(i)]        = LogisticRegressionFunction(U_ss4,yU_ss4,minValue,maxValue);
    
    [yfitses1_ss1,IPses1_ss1(i), betas_ses1_ss1(i)]        = LogisticRegressionFunction(ses1_ss1,yses1_ss1,minValue,maxValue);
    [yfitses2_ss1,IPses2_ss1(i), betas_ses2_ss1(i)]        = LogisticRegressionFunction(ses2_ss1,yses2_ss1,minValue,maxValue);
    [yfitses3_ss1,IPses3_ss1(i), betas_ses3_ss1(i)]        = LogisticRegressionFunction(ses3_ss1,yses3_ss1,minValue,maxValue);
    [yfitses1_ss2,IPses1_ss2(i), betas_ses1_ss2(i)]        = LogisticRegressionFunction(ses1_ss2,yses1_ss2,minValue,maxValue);
    [yfitses2_ss2,IPses2_ss2(i), betas_ses2_ss2(i)]        = LogisticRegressionFunction(ses2_ss2,yses2_ss2,minValue,maxValue);
    [yfitses3_ss2,IPses3_ss2(i), betas_ses3_ss2(i)]        = LogisticRegressionFunction(ses3_ss2,yses3_ss2,minValue,maxValue);    
    [yfitses1_ss3,IPses1_ss3(i), betas_ses1_ss3(i)]        = LogisticRegressionFunction(ses1_ss3,yses1_ss3,minValue,maxValue);
    [yfitses2_ss3,IPses2_ss3(i), betas_ses2_ss3(i)]        = LogisticRegressionFunction(ses2_ss3,yses2_ss3,minValue,maxValue);
    [yfitses3_ss3,IPses3_ss3(i), betas_ses3_ss3(i)]        = LogisticRegressionFunction(ses3_ss3,yses3_ss3,minValue,maxValue);
    [yfitses1_ss4,IPses1_ss4(i), betas_ses1_ss4(i)]        = LogisticRegressionFunction(ses1_ss4,yses1_ss4,minValue,maxValue);
    [yfitses2_ss4,IPses2_ss4(i), betas_ses2_ss4(i)]        = LogisticRegressionFunction(ses2_ss4,yses2_ss4,minValue,maxValue);
    [yfitses3_ss4,IPses3_ss4(i), betas_ses3_ss4(i)]        = LogisticRegressionFunction(ses3_ss4,yses3_ss4,minValue,maxValue);  
    
    [yfitses1_I_1,IPses1_I_1(i), betas_ses1_I_1(i)]    = LogisticRegressionFunction(ses1_I_1,yses1_I_1,minValue,maxValue);
    [yfitses1_I_2,IPses1_I_2(i), betas_ses1_I_2(i)]    = LogisticRegressionFunction(ses1_I_2,yses1_I_2,minValue,maxValue);
    [yfitses1_I_3,IPses1_I_3(i), betas_ses1_I_3(i)]    = LogisticRegressionFunction(ses1_I_3,yses1_I_3,minValue,maxValue);
    [yfitses1_I_4,IPses1_I_4(i), betas_ses1_I_4(i)]    = LogisticRegressionFunction(ses1_I_4,yses1_I_4,minValue,maxValue);
    
    [yfitses2_I_1,IPses2_I_1(i), betas_ses2_I_1(i)]    = LogisticRegressionFunction(ses2_I_1,yses2_I_1,minValue,maxValue);
    [yfitses2_I_2,IPses2_I_2(i), betas_ses2_I_2(i)]    = LogisticRegressionFunction(ses2_I_2,yses2_I_2,minValue,maxValue);
    [yfitses2_I_3,IPses2_I_3(i), betas_ses2_I_3(i)]    = LogisticRegressionFunction(ses2_I_3,yses2_I_3,minValue,maxValue);
    [yfitses2_I_4,IPses2_I_4(i), betas_ses2_I_4(i)]    = LogisticRegressionFunction(ses2_I_4,yses2_I_4,minValue,maxValue);
    
    [yfitses3_I_1,IPses3_I_1(i), betas_ses3_I_1(i)]    = LogisticRegressionFunction(ses3_I_1,yses3_I_1,minValue,maxValue);
    [yfitses3_I_2,IPses3_I_2(i), betas_ses3_I_2(i)]    = LogisticRegressionFunction(ses3_I_2,yses3_I_2,minValue,maxValue);
    [yfitses3_I_3,IPses3_I_3(i), betas_ses3_I_3(i)]    = LogisticRegressionFunction(ses3_I_3,yses3_I_3,minValue,maxValue);
    [yfitses3_I_4,IPses3_I_4(i), betas_ses3_I_4(i)]    = LogisticRegressionFunction(ses3_I_4,yses3_I_4,minValue,maxValue);
    
    [yfitses1_U_1,IPses1_U_1(i), betas_ses1_U_1(i)]    = LogisticRegressionFunction(ses1_U_1,yses1_U_1,minValue,maxValue);
    [yfitses1_U_2,IPses1_U_2(i), betas_ses1_U_2(i)]    = LogisticRegressionFunction(ses1_U_2,yses1_U_2,minValue,maxValue);
    [yfitses1_U_3,IPses1_U_3(i), betas_ses1_U_3(i)]    = LogisticRegressionFunction(ses1_U_3,yses1_U_3,minValue,maxValue);
    [yfitses1_U_4,IPses1_U_4(i), betas_ses1_U_4(i)]    = LogisticRegressionFunction(ses1_U_4,yses1_U_4,minValue,maxValue);
    
    [yfitses2_U_1,IPses2_U_1(i), betas_ses2_U_1(i)]    = LogisticRegressionFunction(ses2_U_1,yses2_U_1,minValue,maxValue);
    [yfitses2_U_2,IPses2_U_2(i), betas_ses2_U_2(i)]    = LogisticRegressionFunction(ses2_U_2,yses2_U_2,minValue,maxValue);
    [yfitses2_U_3,IPses2_U_3(i), betas_ses2_U_3(i)]    = LogisticRegressionFunction(ses2_U_3,yses2_U_3,minValue,maxValue);
    [yfitses2_U_4,IPses2_U_4(i), betas_ses2_U_4(i)]    = LogisticRegressionFunction(ses2_U_4,yses2_U_4,minValue,maxValue);
    
    [yfitses3_U_1,IPses3_U_1(i), betas_ses3_U_1(i)]    = LogisticRegressionFunction(ses3_U_1,yses3_U_1,minValue,maxValue);
    [yfitses3_U_2,IPses3_U_2(i), betas_ses3_U_2(i)]    = LogisticRegressionFunction(ses3_U_2,yses3_U_2,minValue,maxValue);
    [yfitses3_U_3,IPses3_U_3(i), betas_ses3_U_3(i)]    = LogisticRegressionFunction(ses3_U_3,yses3_U_3,minValue,maxValue);
    [yfitses3_U_4,IPses3_U_4(i), betas_ses3_U_4(i)]    = LogisticRegressionFunction(ses3_U_4,yses3_U_4,minValue,maxValue);
    
 
%% Plots 
if doPlots == 1
   
    % horizontal line at y=0.5
    lineX = 0:0.1:maxValue;
    lineY = 0.5 * ones(size(lineX));
    
    % regression plots
    xx = easyOffer;
    aI1_1=unique([ses1_I_1,yfitses1_I_1],'rows');
    aI1_2=unique([ses1_I_2,yfitses1_I_2],'rows');
    aI1_3=unique([ses1_I_3,yfitses1_I_3],'rows');
    aI1_4=unique([ses1_I_4,yfitses1_I_4],'rows');
    
    aI2_1=unique([ses2_I_1,yfitses2_I_1],'rows');
    aI2_2=unique([ses2_I_2,yfitses2_I_2],'rows');
    aI2_3=unique([ses2_I_3,yfitses2_I_3],'rows');
    aI2_4=unique([ses2_I_4,yfitses2_I_4],'rows');

    aI3_1=unique([ses3_I_1,yfitses3_I_1],'rows');
    aI3_2=unique([ses3_I_2,yfitses3_I_2],'rows');
    aI3_3=unique([ses3_I_3,yfitses3_I_3],'rows');
    aI3_4=unique([ses3_I_4,yfitses3_I_4],'rows');
    
    aU1_1=unique([ses1_U_1,yfitses1_U_1],'rows');
    aU1_2=unique([ses1_U_2,yfitses1_U_2],'rows');
    aU1_3=unique([ses1_U_3,yfitses1_U_3],'rows');
    aU1_4=unique([ses1_U_4,yfitses1_U_4],'rows');
    
    aU2_1=unique([ses2_U_1,yfitses2_U_1],'rows');
    aU2_2=unique([ses2_U_2,yfitses2_U_2],'rows');
    aU2_3=unique([ses2_U_3,yfitses2_U_3],'rows');
    aU2_4=unique([ses2_U_4,yfitses2_U_4],'rows');

    aU3_1=unique([ses3_U_1,yfitses3_U_1],'rows');
    aU3_2=unique([ses3_U_2,yfitses3_U_2],'rows');
    aU3_3=unique([ses3_U_3,yfitses3_U_3],'rows');
    aU3_4=unique([ses3_U_4,yfitses3_U_4],'rows');
    
    for ses = 1:3
        
        % IGNORE
        figure;
        hold all;
        switch ses
                  
            case 1 % ses 1 
            plot(aI1_1(:,1),aI1_1(:,2),'m', 'LineWidth',2); % plot easyoffer on x axis and logistic regressioni on y axis. 
            plot(aI1_2(:,1),aI1_2(:,2),'b', 'LineWidth',2);
            plot(aI1_3(:,1),aI1_3(:,2),'r', 'LineWidth',2);
            plot(aI1_4(:,1),aI1_4(:,2),'g', 'LineWidth',2);
            plot(lineX,lineY,'w', 'LineWidth',2, 'LineStyle', '--'); %plot IP line

            scatter(ses1_I_1,yses1_I_1,'m', 'filled', 'jitter','on');
            scatter(ses1_I_2,yses1_I_2,'b', 'filled','jitter','on');
            scatter(ses1_I_3,yses1_I_3,'r', 'filled','jitter','on');
            scatter(ses1_I_4,yses1_I_4,'g', 'filled','jitter','on');

            case 2 % ses 2
            plot(aI2_1(:,1),aI2_1(:,2),'m', 'LineWidth',2); % plot easyoffer on x axis and logistic regressioni on y axis. 
            plot(aI2_2(:,1),aI2_2(:,2),'b', 'LineWidth',2);
            plot(aI2_3(:,1),aI2_3(:,2),'r', 'LineWidth',2);
            plot(aI2_4(:,1),aI2_4(:,2),'g', 'LineWidth',2);
            plot(lineX,lineY,'w', 'LineWidth',2, 'LineStyle', '--'); %plot IP line

            scatter(ses2_I_1,yses2_I_1,'m', 'filled', 'jitter','on');
            scatter(ses2_I_2,yses2_I_2,'b', 'filled','jitter','on');
            scatter(ses2_I_3,yses2_I_3,'r', 'filled','jitter','on');
            scatter(ses2_I_4,yses2_I_4,'g', 'filled','jitter','on');

            case 3 % ses 3
            plot(aI3_1(:,1),aI3_1(:,2),'m', 'LineWidth',2); % plot easyoffer on x axis and logistic regressioni on y axis. 
            plot(aI3_2(:,1),aI3_2(:,2),'b', 'LineWidth',2);
            plot(aI3_3(:,1),aI3_3(:,2),'r', 'LineWidth',2);
            plot(aI3_4(:,1),aI3_4(:,2),'g', 'LineWidth',2);
            plot(lineX,lineY,'w', 'LineWidth',2, 'LineStyle', '--'); %plot IP line

            scatter(ses3_I_1,yses3_I_1,'m', 'filled', 'jitter','on');
            scatter(ses3_I_2,yses3_I_2,'b', 'filled','jitter','on');
            scatter(ses3_I_3,yses3_I_3,'r', 'filled','jitter','on');
            scatter(ses3_I_4,yses3_I_4,'g', 'filled','jitter','on');
        end 
        
        set(gcf,'Color','k');
        set(gca,'Color','k');
        ylabel('Probability of accepting No Redo', 'Color', 'w','FontSize', 14, 'Position', [-0.1 0.5000 -1]);
        xlabel('Offer for No Redo', 'Color', 'w','FontSize', 14, 'Position', [1.1500 -0.0778 -1]);
        legend({'Ignore 1','Ignore 2','Ignore 3','Ignore 4'},'location','southeastoutside', 'TextColor', 'w','FontSize', 12);
        title(sprintf('Participant %d, session %d, Ignore\n',j, ses), 'Color', 'w','FontSize', 14, 'FontWeight', 'Bold');
        ylim([0 1]);
        xlim([minValue maxValue]);
        ax = gca; % Get handle to current axes.
        ax.XColor = 'w'; 
        ax.YColor = 'w'; 
        hold off;
        print(fullfile(data_dir,'graphs_IP', sprintf('sub%d_I_ses%d',j, ses)),'-dpdf','-r300');
        print(fullfile(data_dir,'graphs_IP', sprintf('sub%d_I_ses%d',j, ses)),'-dtiffn','-r1000');
        close; 
        
        % UPDATE
        figure;
        hold all;
        switch ses
                  
            case 1 % ses 1 
            plot(aU1_1(:,1),aU1_1(:,2),'m', 'LineWidth',2); % plot easyoffer on x axis and logistic regressioni on y axis. 
            plot(aU1_2(:,1),aU1_2(:,2),'b', 'LineWidth',2);
            plot(aU1_3(:,1),aU1_3(:,2),'r', 'LineWidth',2);
            plot(aU1_4(:,1),aU1_4(:,2),'g', 'LineWidth',2);
            plot(lineX,lineY,'w', 'LineWidth',2, 'LineStyle', '--'); %plot IP line

            scatter(ses1_U_1,yses1_U_1,'m', 'filled', 'jitter','on');
            scatter(ses1_U_2,yses1_U_2,'b', 'filled','jitter','on');
            scatter(ses1_U_3,yses1_U_3,'r', 'filled','jitter','on');
            scatter(ses1_U_4,yses1_U_4,'g', 'filled','jitter','on');

            case 2 % ses 2
            plot(aU2_1(:,1),aU2_1(:,2),'m', 'LineWidth',2); % plot easyoffer on x axis and logistic regressioni on y axis. 
            plot(aU2_2(:,1),aU2_2(:,2),'b', 'LineWidth',2);
            plot(aU2_3(:,1),aU2_3(:,2),'r', 'LineWidth',2);
            plot(aU2_4(:,1),aU2_4(:,2),'g', 'LineWidth',2);
            plot(lineX,lineY,'w', 'LineWidth',2, 'LineStyle', '--'); %plot IP line

            scatter(ses2_U_1,yses2_U_1,'m', 'filled', 'jitter','on');
            scatter(ses2_U_2,yses2_U_2,'b', 'filled','jitter','on');
            scatter(ses2_U_3,yses2_U_3,'r', 'filled','jitter','on');
            scatter(ses2_U_4,yses2_U_4,'g', 'filled','jitter','on');
        
            case 3 % ses 3
            plot(aU3_1(:,1),aU3_1(:,2),'m', 'LineWidth',2); % plot easyoffer on x axis and logistic regressioni on y axis. 
            plot(aU3_2(:,1),aU3_2(:,2),'b', 'LineWidth',2);
            plot(aU3_3(:,1),aU3_3(:,2),'r', 'LineWidth',2);
            plot(aU3_4(:,1),aU3_4(:,2),'g', 'LineWidth',2);
            plot(lineX,lineY,'w', 'LineWidth',2, 'LineStyle', '--'); %plot IP line

            scatter(ses3_U_1,yses3_U_1,'m', 'filled', 'jitter','on');
            scatter(ses3_U_2,yses3_U_2,'b', 'filled','jitter','on');
            scatter(ses3_U_3,yses3_U_3,'r', 'filled','jitter','on');
            scatter(ses3_U_4,yses3_U_4,'g', 'filled','jitter','on');
        end 
        
        set(gcf,'Color','k');
        set(gca,'Color','k');
        ylabel('Probability of accepting No Redo', 'Color', 'w','FontSize', 14, 'Position', [-0.1 0.5000 -1]);
        xlabel('Offer for No Redo', 'Color', 'w','FontSize', 14, 'Position', [1.1500 -0.0778 -1]);
        legend({'Update 1','Update 2','Update 3','Update 4'},'location','southeastoutside', 'TextColor', 'w','FontSize', 12);
        title(sprintf('Participant %d, session %d, Update\n',j, ses), 'Color', 'w','FontSize', 14, 'FontWeight', 'Bold');
        ylim([0 1]);
        xlim([minValue maxValue]);
        ax = gca; % Get handle to current axes.
        ax.XColor = 'w'; 
        ax.YColor = 'w'; 
        hold off;
        print(fullfile(data_dir,'graphs_IP', sprintf('sub%d_U_ses%d',j, ses)),'-dpdf','-r300');
        close; 
    end 
end
    
i = i+1; 
end 

%% COMBINE DATA AND SET PEOPLE WITH IP<0.1 AND IP>2.2 TO 0.1 AND 2.2, RESPECTIVELY (MIN AND MAX VALUES)
IPmatrix=[IPTotal' IPses1' IPses2' IPses3' IPI' IPU' IPss1' IPss2' IPss3' IPss4' IPses1_I' IPses2_I' IPses3_I' IPses1_U' IPses2_U' IPses3_U'...
    IPI_ss1' IPI_ss2' IPI_ss3' IPI_ss4' IPU_ss1' IPU_ss2' IPU_ss3' IPU_ss4' IPses1_ss1' IPses1_ss2' IPses1_ss3' IPses1_ss4' IPses2_ss1' IPses2_ss2' IPses2_ss3' IPses2_ss4'...
    IPses3_ss1' IPses3_ss2' IPses3_ss3' IPses3_ss4' IPses1_I_1' IPses1_I_2' IPses1_I_3' IPses1_I_4' IPses2_I_1' IPses2_I_2' IPses2_I_3' IPses2_I_4' IPses3_I_1' IPses3_I_2'...
    IPses3_I_3' IPses3_I_4' IPses1_U_1' IPses1_U_2' IPses1_U_3' IPses1_U_4' IPses2_U_1' IPses2_U_2' IPses2_U_3' IPses2_U_4' IPses3_U_1' IPses3_U_2' IPses3_U_3' IPses3_U_4'];
ratioRedo_wide_format = [];
load('ratioRedo_wide_format.csv');
IPmatrix(IPmatrix<minValue & ratioRedo_wide_format(:,[2:end])<0.5)=minValue;
IPmatrix(IPmatrix>maxValue & ratioRedo_wide_format(:,[2:end])<0.5)=minValue;
IPmatrix(IPmatrix>maxValue & ratioRedo_wide_format(:,[2:end])>0.5)=maxValue;
IPmatrix(IPmatrix<minValue & ratioRedo_wide_format(:,[2:end])>0.5)=maxValue;



%% Save in wide format 
IPmatrix=[subNo' IPmatrix];
names={'sID' 'Total' 'ses1' 'ses2' 'ses3'  'I' 'U' 'ss1' 'ss2' 'ss3' 'ss4' 'ses1_I' 'ses2_I' 'ses3_I' 'ses1_U' 'ses2_U' 'ses3_U'...
    'I_ss1' 'I_ss2' 'I_ss3' 'I_ss4' 'U_ss1' 'U_ss2' 'U_ss3' 'U_ss4' 'ses1_ss1' 'ses1_ss2' 'ses1_ss3' 'ses1_ss4' 'ses2_ss1' 'ses2_ss2' 'ses2_ss3' 'ses2_ss4'...
    'ses3_ss1' 'ses3_ss2' 'ses3_ss3' 'ses3_ss4' 'ses1_I_1' 'ses1_I_2' 'ses1_I_3' 'ses1_I_4' 'ses2_I_1' 'ses2_I_2' 'ses2_I_3' 'ses2_I_4' 'ses3_I_1' 'ses3_I_2'... 
    'ses3_I_3' 'ses3_I_4' 'ses1_U_1' 'ses1_U_2' 'ses1_U_3' 'ses1_U_4' 'ses2_U_1' 'ses2_U_2' 'ses2_U_3' 'ses2_U_4' 'ses3_U_1' 'ses3_U_2' 'ses3_U_3' 'ses3_U_4'};
cells = sprintf('A2:BI%d',i);
xlswrite('IPs_wide_format.xlsx',names,1,'A1:BI1');
xlswrite('IPs_wide_format.xlsx',IPmatrix,1,cells); 
csvwrite('IPs_wide_format.csv',IPmatrix);

%% save in long format
subs                    = repmat(subNo',24,1);
session                 = repmat([1 2 3], 200, 1); session = session(:); session = repmat(session, 2, 1);
setsize                 = repmat([1 2 3 4], 50, 1); setsize = setsize(:); setsize = repmat(setsize, 6, 1);
cond                    = repmat([0 2], 600, 1); cond = cond(:); 
IPs                     = [IPses1_I_1'; IPses1_I_2'; IPses1_I_3'; IPses1_I_4'; IPses2_I_1'; IPses2_I_2'; IPses2_I_3'; IPses2_I_4'; IPses3_I_1'; IPses3_I_2';...
                            IPses3_I_3'; IPses3_I_4'; IPses1_U_1'; IPses1_U_2'; IPses1_U_3'; IPses1_U_4'; IPses2_U_1'; IPses2_U_2'; IPses2_U_3'; IPses2_U_4';... 
                            IPses3_U_1'; IPses3_U_2'; IPses3_U_3'; IPses3_U_4'];
IP_long_format          = [subs session cond setsize IPs];

names={'sID' 'session' 'condition' 'setsize' 'IP'};
xlswrite('IPs_long_format.xlsx',names,1,'A1:E1');
xlswrite('IPs_long_format.xlsx',IP_long_format,1,'A2:E1201');
csvwrite('IPs_long_format.csv',IP_long_format);

%% Save slope coefficients in wide format 
betamatrix = [betas_Total' betas_ses1' betas_ses2' betas_ses3' betas_I' betas_U' betas_ss1' betas_ss2' betas_ss3' betas_ss4' betas_ses1_I' betas_ses2_I' betas_ses3_I' betas_ses1_U' betas_ses2_U' betas_ses3_U'...
    betas_I_ss1' betas_I_ss2' betas_I_ss3' betas_I_ss4' betas_U_ss1' betas_U_ss2' betas_U_ss3' betas_U_ss4' betas_ses1_ss1' betas_ses1_ss2' betas_ses1_ss3' betas_ses1_ss4' betas_ses2_ss1' betas_ses2_ss2' betas_ses2_ss3' betas_ses2_ss4'...
    betas_ses3_ss1' betas_ses3_ss2' betas_ses3_ss3' betas_ses3_ss4' betas_ses1_I_1' betas_ses1_I_2' betas_ses1_I_3' betas_ses1_I_4' betas_ses2_I_1' betas_ses2_I_2' betas_ses2_I_3' betas_ses2_I_4' betas_ses3_I_1' betas_ses3_I_2'...
    betas_ses3_I_3' betas_ses3_I_4' betas_ses1_U_1' betas_ses1_U_2' betas_ses1_U_3' betas_ses1_U_4' betas_ses2_U_1' betas_ses2_U_2' betas_ses2_U_3' betas_ses2_U_4' betas_ses3_U_1' betas_ses3_U_2' betas_ses3_U_3' betas_ses3_U_4'];
betamatrix=[subNo' betamatrix];

names={'sID' 'Total' 'ses1' 'ses2' 'ses3'  'I' 'U' 'ss1' 'ss2' 'ss3' 'ss4' 'ses1_I' 'ses2_I' 'ses3_I' 'ses1_U' 'ses2_U' 'ses3_U'...
    'I_ss1' 'I_ss2' 'I_ss3' 'I_ss4' 'U_ss1' 'U_ss2' 'U_ss3' 'U_ss4' 'ses1_ss1' 'ses1_ss2' 'ses1_ss3' 'ses1_ss4' 'ses2_ss1' 'ses2_ss2' 'ses2_ss3' 'ses2_ss4'...
    'ses3_ss1' 'ses3_ss2' 'ses3_ss3' 'ses3_ss4' 'ses1_I_1' 'ses1_I_2' 'ses1_I_3' 'ses1_I_4' 'ses2_I_1' 'ses2_I_2' 'ses2_I_3' 'ses2_I_4' 'ses3_I_1' 'ses3_I_2'... 
    'ses3_I_3' 'ses3_I_4' 'ses1_U_1' 'ses1_U_2' 'ses1_U_3' 'ses1_U_4' 'ses2_U_1' 'ses2_U_2' 'ses2_U_3' 'ses2_U_4' 'ses3_U_1' 'ses3_U_2' 'ses3_U_3' 'ses3_U_4'};
cells = sprintf('A2:BI%d',i);
xlswrite('betas_wide_format.xlsx',names,1,'A1:BI1');
xlswrite('betas_wide_format.xlsx',betamatrix,1,cells); 
csvwrite('betas_wide_format.csv',betamatrix);

%% save slope coefficients in long format
subs                    = repmat(subNo',24,1);
session                 = repmat([1 2 3], 200, 1); session = session(:); session = repmat(session, 2, 1);
setsize                 = repmat([1 2 3 4], 50, 1); setsize = setsize(:); setsize = repmat(setsize, 6, 1);
cond                    = repmat([0 2], 600, 1); cond = cond(:); 
betas                   = [betas_ses1_I_1'; betas_ses1_I_2'; betas_ses1_I_3'; betas_ses1_I_4'; betas_ses2_I_1'; betas_ses2_I_2'; betas_ses2_I_3'; betas_ses2_I_4'; betas_ses3_I_1'; betas_ses3_I_2';...
                            betas_ses3_I_3'; betas_ses3_I_4'; betas_ses1_U_1'; betas_ses1_U_2'; betas_ses1_U_3'; betas_ses1_U_4'; betas_ses2_U_1'; betas_ses2_U_2'; betas_ses2_U_3'; betas_ses2_U_4';...
                            betas_ses3_U_1'; betas_ses3_U_2'; betas_ses3_U_3'; betas_ses3_U_4'];
betas_long_format       = [subs session cond setsize betas];

names={'sID' 'session' 'condition' 'setsize' 'beta'};
xlswrite('betas_long_format.xlsx',names,1,'A1:E1');
xlswrite('betas_long_format.xlsx',betas_long_format,1,'A2:E1201');
csvwrite('betas_long_format.csv',betas_long_format);
