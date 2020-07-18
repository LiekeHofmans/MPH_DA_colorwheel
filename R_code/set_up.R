# set-UP FOR COLOR WHEEL AND CHOICE TASK R ANALYSES AND SCRIPT

# This script is the set up for other R scripts and reads in the data from the color wheel and choice task and combines them in different data frame.



# Load libraries
# ________________________________________________________________________________________________________________________________________________________________________

# install libraries
# install.packages(tidyverse)
# install.packages(lme4)
# install.packages(MASS)
# install.packages(parallel)
# install.packages(afex)
# install.packages(car)
# install.packages(robustlmm)
# install.packages(reshape2)

# load libraries
library(tidyverse)
library(lme4)
library(MASS)
library(parallel)
library(afex)
library(car)
library(robustlmm)
library(reshape)
library(gdata)
# ________________________________________________________________________________________________________________________________________________________________________
# ________________________________________________________________________________________________________________________________________________________________________


# SET UP
# ________________________________________________________________________________________________________________________________________________________________________

# set contrasts to sum-to-zero (aka deviation coding) for unordered factors and polynomial for ordered factors
options(contrasts=c("contr.sum", "contr.poly"))

# # set path for converting into PDF (otherwise it cannot find a necessary program on my Donders pc)
# Sys.setenv(PATH = paste(Sys.getenv("PATH"), "C:/Users/liehof/AppLocal/Programs/MiKTeX 2.9/miktex/bin/x64", sep=.Platform$path.sep))

# set decimal places
options(digits=4)

# set environment (which computer am I working on?)
if (Sys.info()["sysname"]=="Linux") {
  project_wd <- "/project/3017048.01"
  data_wd <- "/project/3017048.01/bids/derivatives/beh/color_wheel"
  cw_wd <- "/project/3017048.01/bids/derivatives/beh/color_wheel/color_wheel"
  choice_wd <- "/project/3017048.01/bids/derivatives/beh/color_wheel/choice"
  PET_wd <- "/project/3017048.01/bids/derivatives/pet/group"
  code_wd <-"/project/3017048.01/code/analysis/beh/CW/R_code"
} else if (Sys.info()["nodename"]=="DCCN765") { 
  project_wd <- "P:/3017048.01"
  data_wd <- "P:/3017048.01/bids/derivatives/beh/color_wheel"
  cw_wd <- "P:/3017048.01/bids/derivatives/beh/color_wheel/color_wheel"
  choice_wd <- "P:/3017048.01/bids/derivatives/beh/color_wheel/choice"
  PET_wd <- "P:/3017048.01/bids/derivatives/pet/group"
  code_wd <-"P:/3017048.01/code/analysis/beh/CW/R_code"
}
# ________________________________________________________________________________________________________________________________________________________________________
# ________________________________________________________________________________________________________________________________________________________________________



# call summary function to easily summarize data in long format (will need it later)
# ________________________________________________________________________________________________________________________________________________________________________

## Summarizes data.
## Gives count, mean, standard deviation, standard error of the mean, and confidence interval (default 95%).
##   data: a data frame.
##   measurevar: the name of a column that contains the variable to be summariezed
##   groupvars: a vector containing names of columns that contain grouping variables
##   na.rm: a boolean that indicates whether to ignore NA's
##   conf.interval: the percent range of the confidence interval (default is 95%)
summarySE <- function(data=NULL, measurevar, groupvars=NULL, na.rm=TRUE,
                      conf.interval=.95, .drop=TRUE) {
  library(plyr)
  
  # New version of length which can handle NA's: if na.rm==T, don't count them
  length2 <- function (x, na.rm=FALSE) {
    if (na.rm) sum(!is.na(x))
    else       length(x)
  }
  
  # This does the summary. For each group's data frame, return a vector with
  # N, mean, and sd
  datac <- ddply(data, groupvars, .drop=.drop,
                 .fun = function(xx, col) {
                   c(N      = length2(xx[[col]], na.rm=na.rm),
                     mean   = mean   (xx[[col]], na.rm=na.rm),
                     median = median (xx[[col]], na.rm=na.rm),
                     sd     = sd     (xx[[col]], na.rm=na.rm)
                   )
                 },
                 measurevar
  )
  
  # Rename the "mean" column    
  datac <- rename(datac, c("mean" = measurevar))
  
  datac$se <- datac$sd / sqrt(datac$N)  # Calculate standard error of the mean
  
  # Confidence interval multiplier for standard error
  # Calculate t-statistic for confidence interval: 
  # e.g., if conf.interval is .95, use .975 (above/below), and use df=N-1
  ciMult <- qt(conf.interval/2 + .5, datac$N-1)
  datac$ci <- datac$se * ciMult
  
  return(datac)
}
# ________________________________________________________________________________________________________________________________________________________________________
# ________________________________________________________________________________________________________________________________________________________________________


# Load data
#________________________________________________________________________________________________________________________________________________________________________


# COLOR WHEEL DATA

# color wheel data in long format
df_colorwheel <- read.csv(file.path(cw_wd,"/CWdata_long_format.csv"), header = FALSE)
colnames(df_colorwheel) <- c("sID", "session", "trial", "block", "abs_deviance", "raw_deviance", "RT", "set_size", "condition", "lure_deviance", "probe_color_number", "wheel_start", "probe_location")

# color wheel data in wide format, with median scores
median_deviance <- read.csv(file.path(cw_wd,"/median_deviance_abs.csv"), header = FALSE)
median_RT <- read.csv(file.path(cw_wd,"/median_RT.csv"), header = FALSE)
colnames(median_deviance) <- c("sID", "Total","ses1","ses2","ses3","I", "U", "ss1", "ss2", "ss3", "ss4", "ses1_I", "ses2_I", "ses3_I", "ses1_U", "ses2_U", "ses3_U", "I_ss1", "I_ss2", "I_ss3", "I_ss4", "U_ss1", "U_ss2", "U_ss3", "U_ss4", "ses1_ss1", "ses1_ss2", "ses1_ss3", "ses1_ss4", "ses2_ss1", "ses2_ss2", "ses2_ss3", "ses2_ss4", "ses3_ss1", "ses3_ss2", "ses3_ss3", "ses3_ss4","ses1_I_1", "ses1_I_2",	"ses1_I_3",	"ses1_I_4", "ses2_I_1",	"ses2_I_2",	"ses2_I_3","ses2_I_4","ses3_I_1","ses3_I_2","ses3_I_3","ses3_I_4","ses1_U_1","ses1_U_2","ses1_U_3","ses1_U_4","ses2_U_1","ses2_U_2","ses2_U_3","ses2_U_4","ses3_U_1","ses3_U_2","ses3_U_3","ses3_U_4")
colnames(median_RT) <- c("sID", "Total","ses1","ses2","ses3","I", "U", "ss1", "ss2", "ss3", "ss4", "ses1_I", "ses2_I", "ses3_I", "ses1_U", "ses2_U", "ses3_U", "I_ss1", "I_ss2", "I_ss3", "I_ss4", "U_ss1", "U_ss2", "U_ss3", "U_ss4", "ses1_ss1", "ses1_ss2", "ses1_ss3", "ses1_ss4", "ses2_ss1", "ses2_ss2", "ses2_ss3", "ses2_ss4", "ses3_ss1", "ses3_ss2", "ses3_ss3", "ses3_ss4","ses1_I_1", "ses1_I_2",	"ses1_I_3",	"ses1_I_4", "ses2_I_1",	"ses2_I_2",	"ses2_I_3","ses2_I_4","ses3_I_1","ses3_I_2","ses3_I_3","ses3_I_4","ses1_U_1","ses1_U_2","ses1_U_3","ses1_U_4","ses2_U_1","ses2_U_2","ses2_U_3","ses2_U_4","ses3_U_1","ses3_U_2","ses3_U_3","ses3_U_4")


# CHOICE DATA

# choice data in long format
df_choice <- read.csv(file.path(choice_wd,"/choicedata_long_format.csv"), header = FALSE)
colnames(df_choice) <- c("sID", "session", "trial", "block", "condition_IU", "set_size", "hard_offer", "easy_offer", "locationEasy_LR", "choice_NR", "RT")

# choice in wide format
IP <- read.csv(file.path(choice_wd,"/IPs_wide_format.csv"), header = FALSE)
colnames(IP) <- c("sID", "Total","ses1","ses2","ses3","I", "U", "ss1", "ss2", "ss3", "ss4", "ses1_I", "ses2_I", "ses3_I", "ses1_U", "ses2_U", "ses3_U", "I_ss1", "I_ss2", "I_ss3", "I_ss4", "U_ss1", "U_ss2", "U_ss3", "U_ss4", "ses1_ss1", "ses1_ss2", "ses1_ss3", "ses1_ss4", "ses2_ss1", "ses2_ss2", "ses2_ss3", "ses2_ss4", "ses3_ss1", "ses3_ss2", "ses3_ss3", "ses3_ss4","ses1_I_1", "ses1_I_2",	"ses1_I_3",	"ses1_I_4", "ses2_I_1",	"ses2_I_2",	"ses2_I_3","ses2_I_4","ses3_I_1","ses3_I_2","ses3_I_3","ses3_I_4","ses1_U_1","ses1_U_2","ses1_U_3","ses1_U_4","ses2_U_1","ses2_U_2","ses2_U_3","ses2_U_4","ses3_U_1","ses3_U_2","ses3_U_3","ses3_U_4")
ratioRedo <- read.csv(file.path(choice_wd,"/ratioRedo_wide_format.csv"), header = FALSE)
colnames(ratioRedo) <- c("sID", "Total","ses1","ses2","ses3","I", "U", "ss1", "ss2", "ss3", "ss4", "ses1_I", "ses2_I", "ses3_I", "ses1_U", "ses2_U", "ses3_U", "I_ss1", "I_ss2", "I_ss3", "I_ss4", "U_ss1", "U_ss2", "U_ss3", "U_ss4", "ses1_ss1", "ses1_ss2", "ses1_ss3", "ses1_ss4", "ses2_ss1", "ses2_ss2", "ses2_ss3", "ses2_ss4", "ses3_ss1", "ses3_ss2", "ses3_ss3", "ses3_ss4","ses1_I_1", "ses1_I_2",	"ses1_I_3",	"ses1_I_4", "ses2_I_1",	"ses2_I_2",	"ses2_I_3","ses2_I_4","ses3_I_1","ses3_I_2","ses3_I_3","ses3_I_4","ses1_U_1","ses1_U_2","ses1_U_3","ses1_U_4","ses2_U_1","ses2_U_2","ses2_U_3","ses2_U_4","ses3_U_1","ses3_U_2","ses3_U_3","ses3_U_4")
RTchoice <- read.csv(file.path(choice_wd,"/RTchoice_wide_format.csv"), header = FALSE)
colnames(RTchoice) <- c("sID", "Total","ses1","ses2","ses3","I", "U", "ss1", "ss2", "ss3", "ss4", "ses1_I", "ses2_I", "ses3_I", "ses1_U", "ses2_U", "ses3_U", "I_ss1", "I_ss2", "I_ss3", "I_ss4", "U_ss1", "U_ss2", "U_ss3", "U_ss4", "ses1_ss1", "ses1_ss2", "ses1_ss3", "ses1_ss4", "ses2_ss1", "ses2_ss2", "ses2_ss3", "ses2_ss4", "ses3_ss1", "ses3_ss2", "ses3_ss3", "ses3_ss4","ses1_I_1", "ses1_I_2",	"ses1_I_3",	"ses1_I_4", "ses2_I_1",	"ses2_I_2",	"ses2_I_3","ses2_I_4","ses3_I_1","ses3_I_2","ses3_I_3","ses3_I_4","ses1_U_1","ses1_U_2","ses1_U_3","ses1_U_4","ses2_U_1","ses2_U_2","ses2_U_3","ses2_U_4","ses3_U_1","ses3_U_2","ses3_U_3","ses3_U_4")
slope <- read.csv(file.path(choice_wd,"/betas_wide_format.csv"), header = FALSE)
# only use slope info when IP lies between 0.1 and 2.2.
slope[IP==0.1 | IP==2.2] <- NaN
colnames(slope) <- c("sID", "Total","ses1","ses2","ses3","I", "U", "ss1", "ss2", "ss3", "ss4", "ses1_I", "ses2_I", "ses3_I", "ses1_U", "ses2_U", "ses3_U", "I_ss1", "I_ss2", "I_ss3", "I_ss4", "U_ss1", "U_ss2", "U_ss3", "U_ss4", "ses1_ss1", "ses1_ss2", "ses1_ss3", "ses1_ss4", "ses2_ss1", "ses2_ss2", "ses2_ss3", "ses2_ss4", "ses3_ss1", "ses3_ss2", "ses3_ss3", "ses3_ss4","ses1_I_1", "ses1_I_2",	"ses1_I_3",	"ses1_I_4", "ses2_I_1",	"ses2_I_2",	"ses2_I_3","ses2_I_4","ses3_I_1","ses3_I_2","ses3_I_3","ses3_I_4","ses1_U_1","ses1_U_2","ses1_U_3","ses1_U_4","ses2_U_1","ses2_U_2","ses2_U_3","ses2_U_4","ses3_U_1","ses3_U_2","ses3_U_3","ses3_U_4")


# PET DATA

# This ROI file contains Ki values for whole wholeStriatum, ROIs and whole wholeStriatum/ROIs left and right
Kis <- read.csv(file.path(PET_wd,"/roi_results_native.csv"), header = TRUE)
# here I subset all the different ROIS
Ki_wholeStriatum <- Kis[Kis[,"ROI"]=='wholeStriatum',]
Ki_wholePutamen <- Kis[Kis[,"ROI"]=='wholePutamen',]
Ki_wholeCaudate <- Kis[Kis[,"ROI"]=='wholeCaudate',]
Ki_VS <- Kis[Kis[,"ROI"]=='VS',]


Ki_all <- data.frame(cbind(Ki_wholeStriatum[,"subject"], Ki_wholeStriatum[,"meanRoiContrastEstimate"], Ki_wholePutamen[,"meanRoiContrastEstimate"], Ki_wholeCaudate[,"meanRoiContrastEstimate"], Ki_VS[,"meanRoiContrastEstimate"]))
colnames(Ki_all) <- c("sID", "wholeStriatum", "wholePutamen", "wholeCaudate", "VS")

# Drug manipulation

pharm_manip <- read.csv(file.path(project_wd,"admin/9.Deblinding/drugcodes.csv"), header = TRUE)
# reorder drug
pharm_manip$session1 <- factor(pharm_manip$session1, levels = c("SUL", "MPH", "PBO"))
pharm_manip$session2 <- factor(pharm_manip$session2, levels = c("SUL", "MPH", "PBO"))
pharm_manip$session3 <- factor(pharm_manip$session3, levels = c("SUL", "MPH", "PBO"))


# days between drug sessions and PET
drug_PET_difference <- read.csv("P:/3017048.01/bids/derivatives/qnr/participantInfo/days_between_drugs_and_PET.csv", header = TRUE)


# medical and mood data
medical_mood_phys <- read.csv(file.path(data_wd,"medical_mood_physiological.csv"), header = TRUE)

#________________________________________________________________________________________________________________________________________________________________________
#________________________________________________________________________________________________________________________________________________________________________




# WIDE DATASETS



# remove data from participants who haven't completed all 3 behavioral sessions
# ________________________________________________________________________________________________________________________________


for (jj in unique(median_deviance$sID)){
  if (is.nan(median_deviance[median_deviance$sID==jj,"ses3"])) {
    median_deviance <- median_deviance[median_deviance$sID!=jj, ]  
    median_RT <- median_RT[median_RT$sID!=jj, ]  
    IP <- IP[IP$sID!=jj, ]
    ratioRedo <- ratioRedo[ratioRedo$sID!=jj, ]
    RTchoice <- RTchoice[RTchoice$sID!=jj, ]
    slope <- slope[slope$sID!=jj, ]
  }
} 
#________________________________________________________________________________________________________________________________________________________________________
#________________________________________________________________________________________________________________________________________________________________________


# combine scores with drugs (wide format)
#________________________________________________________________________________________________________________________________________________________________________

deviance_drug <- median_deviance
# find all columns that need to be changed to the drug name instead of session number, and clear the column content
deviance_drug[,which(grepl("ses", colnames(deviance_drug)))] <- NA # clear content
colnames(deviance_drug) <- gsub("ses1", "SUL", colnames(deviance_drug)) # subsitute session by drug
colnames(deviance_drug) <- gsub("ses2", "MPH", colnames(deviance_drug))
colnames(deviance_drug) <- gsub("ses3", "PBO", colnames(deviance_drug))
# assign values to drug columns according to values in session columns DP: extra care here: seems good, double checked values for some ppts
# and the drugs seem correctly assigned to sessions
for (jj in deviance_drug$sID){
  for (session in colnames(pharm_manip)[-1]){
    for (drug in c("SUL", "MPH", "PBO")){
      if (grepl(drug, pharm_manip[pharm_manip$subject==jj,session])) { # when session corresponds to drug
        i = 1 # I need the column of median_deviance that correpsonds to deviance_drug
        for (columns_to_be_filled in which(grepl(drug, colnames(deviance_drug)))){
          column_from_which_to_take_value <- which(grepl(paste("ses",parse_number(session), sep = ""), colnames(median_deviance)))[i]
          deviance_drug[deviance_drug$sID==jj, columns_to_be_filled] <- median_deviance[median_deviance$sID==jj,column_from_which_to_take_value]
          i = i + 1
        }
      }
    }
  }
}
# write.csv(deviance_drug, file.path(cw_wd,"deviance_drug.csv"), row.names=F)

RT_drug <- median_RT
# find all columns that need to be changed to the drug name instead of session number, and clear the column content
RT_drug[,which(grepl("ses", colnames(RT_drug)))] <- NA # clear content
colnames(RT_drug) <- gsub("ses1", "SUL", colnames(RT_drug)) # subsitute session by drug
colnames(RT_drug) <- gsub("ses2", "MPH", colnames(RT_drug))
colnames(RT_drug) <- gsub("ses3", "PBO", colnames(RT_drug))
# assign values to drug columns according to values in session columns
for (jj in RT_drug$sID){
  for (session in colnames(pharm_manip)[-1]){
    for (drug in c("SUL", "MPH", "PBO")){
      if (grepl(drug, pharm_manip[pharm_manip$subject==jj,session])) { # when session corresponds to drug
        i = 1 # I need the column of median_RT that correpsonds to RT_drug
        for (columns_to_be_filled in which(grepl(drug, colnames(RT_drug)))){
          column_from_which_to_take_value <- which(grepl(paste("ses",parse_number(session), sep = ""), colnames(median_RT)))[i]
          RT_drug[RT_drug$sID==jj, columns_to_be_filled] <- median_RT[median_RT$sID==jj,column_from_which_to_take_value]
          i = i + 1
        }
      }
    }
  }
}
# write.csv(RT_drug, file.path(cw_wd,"RT_drug.csv"), row.names=F)


# combine IP and ratio redo scores with drugs (wide format)

IP_drug <- IP
# find all columns that need to be changed to the drug name instead of session number, and clear the column content
IP_drug[,which(grepl("ses", colnames(IP_drug)))] <- NA # clear content
colnames(IP_drug) <- gsub("ses1", "SUL", colnames(IP_drug)) # subsitute column name session by drug
colnames(IP_drug) <- gsub("ses2", "MPH", colnames(IP_drug))
colnames(IP_drug) <- gsub("ses3", "PBO", colnames(IP_drug))
# assign values to drug columns according to values in session columns
for (jj in IP_drug$sID){
  for (session in colnames(pharm_manip)[-1]){
    for (drug in c("SUL", "MPH", "PBO")){
      if (grepl(drug, pharm_manip[pharm_manip$subject==jj,session])) { # when session corresponds to drug
        i = 1 # I need the column of IP that correpsonds to IP_drug
        for (columns_to_be_filled in which(grepl(drug, colnames(IP_drug)))){
          column_from_which_to_take_value <- which(grepl(paste("ses",parse_number(session), sep = ""), colnames(IP)))[i]
          IP_drug[IP_drug$sID==jj, columns_to_be_filled] <- IP[IP$sID==jj,column_from_which_to_take_value]
          i = i + 1
        }
      }
    }
  }
}
# write.csv(IP_drug, file.path(choice_wd,"IP_drug.csv"), row.names=F)

ratioRedo_drug <- ratioRedo
# find all columns that need to be changed to the drug name instead of session number, and clear the column content
ratioRedo_drug[,which(grepl("ses", colnames(ratioRedo_drug)))] <- NA # clear content
colnames(ratioRedo_drug) <- gsub("ses1", "SUL", colnames(ratioRedo_drug)) # subsitute session by drug
colnames(ratioRedo_drug) <- gsub("ses2", "MPH", colnames(ratioRedo_drug))
colnames(ratioRedo_drug) <- gsub("ses3", "PBO", colnames(ratioRedo_drug))
# assign values to drug columns according to values in session columns
for (jj in ratioRedo_drug$sID){
  for (session in colnames(pharm_manip)[-1]){
    for (drug in c("SUL", "MPH", "PBO")){
      if (grepl(drug, pharm_manip[pharm_manip$subject==jj,session])) { # when session corresponds to drug
        i = 1 # I need the column of ratioRedo that correpsonds to ratioRedo_drug
        for (columns_to_be_filled in which(grepl(drug, colnames(ratioRedo_drug)))){
          column_from_which_to_take_value <- which(grepl(paste("ses",parse_number(session), sep = ""), colnames(ratioRedo)))[i]
          ratioRedo_drug[ratioRedo_drug$sID==jj, columns_to_be_filled] <- ratioRedo[ratioRedo$sID==jj,column_from_which_to_take_value]
          i = i + 1
        }
      }
    }
  }
}
# write.csv(ratioRedo_drug, file.path(choice_wd,"ratioRedo_drug.csv"), row.names=F)

RTchoice_drug <- RTchoice
# find all columns that need to be changed to the drug name instead of session number, and clear the column content
RTchoice_drug[,which(grepl("ses", colnames(RTchoice_drug)))] <- NA # clear content
colnames(RTchoice_drug) <- gsub("ses1", "SUL", colnames(RTchoice_drug)) # subsitute session by drug
colnames(RTchoice_drug) <- gsub("ses2", "MPH", colnames(RTchoice_drug))
colnames(RTchoice_drug) <- gsub("ses3", "PBO", colnames(RTchoice_drug))
# assign values to drug columns according to values in session columns
for (jj in RTchoice_drug$sID){
  for (session in colnames(pharm_manip)[-1]){
    for (drug in c("SUL", "MPH", "PBO")){
      if (grepl(drug, pharm_manip[pharm_manip$subject==jj,session])) { # when session corresponds to drug
        i = 1 # I need the column of RTchoice that correpsonds to RTchoice_drug
        for (columns_to_be_filled in which(grepl(drug, colnames(RTchoice_drug)))){
          column_from_which_to_take_value <- which(grepl(paste("ses",parse_number(session), sep = ""), colnames(RTchoice)))[i]
          RTchoice_drug[RTchoice_drug$sID==jj, columns_to_be_filled] <- RTchoice[RTchoice$sID==jj,column_from_which_to_take_value]
          i = i + 1
        }
      }
    }
  }
}
# write.csv(RTchoice_drug, file.path(choice_wd,"RTchoice_drug.csv"), row.names=F)


slope_drug <- slope
# find all columns that need to be changed to the drug name instead of session number, and clear the column content
slope_drug[,which(grepl("ses", colnames(slope_drug)))] <- NA # clear content
colnames(slope_drug) <- gsub("ses1", "SUL", colnames(slope_drug)) # subsitute session by drug
colnames(slope_drug) <- gsub("ses2", "MPH", colnames(slope_drug))
colnames(slope_drug) <- gsub("ses3", "PBO", colnames(slope_drug))
# assign values to drug columns according to values in session columns
for (jj in slope_drug$sID){
  for (session in colnames(pharm_manip)[-1]){
    for (drug in c("SUL", "MPH", "PBO")){
      if (grepl(drug, pharm_manip[pharm_manip$subject==jj,session])) { # when session corresponds to drug
        i = 1 # I need the column of slope that correpsonds to slope_drug
        for (columns_to_be_filled in which(grepl(drug, colnames(slope_drug)))){
          column_from_which_to_take_value <- which(grepl(paste("ses",parse_number(session), sep = ""), colnames(slope)))[i]
          slope_drug[slope_drug$sID==jj, columns_to_be_filled] <- slope[slope$sID==jj,column_from_which_to_take_value]
          i = i + 1
        }
      }
    }
  }
}
# write.csv(slope_drug, file.path(choice_wd,"slope_drug.csv"), row.names=F)
#________________________________________________________________________________________________________________________________________________________________________
#________________________________________________________________________________________________________________________________________________________________________



# calculate the difference in session number between drugs.
# ________________________________________________________________________________________________________________________________________________________________________

session_diff <- data.frame(deviance_drug[,c("sID")])
colnames(session_diff) <- "sID"
for (jj in unique(session_diff$sID)){
  # which drug on session 1,2,3?
  session_diff[session_diff$sID==jj, "ses1"] <- pharm_manip$session1[pharm_manip$subject==jj]
  session_diff[session_diff$sID==jj, "ses2"] <- pharm_manip$session2[pharm_manip$subject==jj]
  session_diff[session_diff$sID==jj, "ses3"] <- pharm_manip$session3[pharm_manip$subject==jj]
  # which session for PBO, MPH, SUL?
  session_diff[session_diff$sID==jj, "MPH"] <- as.numeric(gsub("session", "", colnames(pharm_manip[,-1])[grep("MPH", as.character(unlist(pharm_manip[pharm_manip$subject==jj, -1], use.names=F)))]))
  session_diff[session_diff$sID==jj, "PBO"] <- as.numeric(gsub("session", "", colnames(pharm_manip[,-1])[grep("PBO", as.character(unlist(pharm_manip[pharm_manip$subject==jj, -1], use.names=F)))]))
  session_diff[session_diff$sID==jj, "SUL"] <- as.numeric(gsub("session", "", colnames(pharm_manip[,-1])[grep("SUL", as.character(unlist(pharm_manip[pharm_manip$subject==jj, -1], use.names=F)))]))
  # Difference in session number between drugs
  session_diff[session_diff$sID==jj, "MPH_PBO"] <- session_diff[session_diff$sID==jj, "MPH"] - session_diff[session_diff$sID==jj, "PBO"]
  session_diff[session_diff$sID==jj, "SUL_PBO"] <- session_diff[session_diff$sID==jj, "SUL"] - session_diff[session_diff$sID==jj, "PBO"]
  session_diff[session_diff$sID==jj, "MPH_SUL"] <- session_diff[session_diff$sID==jj, "MPH"] - session_diff[session_diff$sID==jj, "SUL"]
  # which drug comes first, independent of exact session number?
  session_diff$PBO_before_MPH <- ifelse(session_diff$MPH_PBO > 0, 1, 0) # 0 when MPH first, 1 when PBO first
  session_diff$PBO_before_SUL <- ifelse(session_diff$SUL_PBO > 0, 1, 0)
  session_diff$SUL_before_MPH <- ifelse(session_diff$MPH_SUL > 0, 1, 0)
} 
write.csv(session_diff, file.path(data_wd,"session_diff.csv"), row.names=F)

# ________________________________________________________________________________________________________________________________________________________________________
# ________________________________________________________________________________________________________________________________________________________________________




# add prefix (variable name) to datacolumns
temp_deviance <- deviance_drug
colnames(temp_deviance) <- c(colnames(temp_deviance[1]),paste("deviance", colnames(temp_deviance[-1]), sep = "_"))
temp_RT <- RT_drug
colnames(temp_RT) <- c(colnames(temp_RT[1]),paste("RT", colnames(temp_RT[-1]), sep = "_"))
temp_IP <- IP_drug
colnames(temp_IP) <- c(colnames(temp_IP[1]),paste("IP", colnames(temp_IP[-1]), sep = "_"))
temp_ratioRedo <- ratioRedo_drug
colnames(temp_ratioRedo) <- c(colnames(temp_ratioRedo[1]),paste("ratioRedo", colnames(temp_ratioRedo[-1]), sep = "_"))
temp_RTchoice <- RTchoice_drug
colnames(temp_RTchoice) <- c(colnames(temp_RTchoice[1]),paste("RTchoice", colnames(temp_RTchoice[-1]), sep = "_"))
temp_slope <- slope_drug
colnames(temp_slope) <- c(colnames(temp_slope[1]),paste("slope", colnames(temp_slope[-1]), sep = "_"))

# combine variables into one large dataset (including session numbers and order information)
allDepVars_wide_drug <- merge(temp_deviance, temp_RT) %>%
  merge(., temp_IP) %>%
  merge(., temp_ratioRedo) %>%
  merge(., temp_RTchoice) %>%
  merge(., temp_slope) %>%
  merge(., session_diff)

# add Ki values (raw and mean centered) 
for (jj in Ki_all$sID){
  allDepVars_wide_drug[allDepVars_wide_drug[,"sID"]==jj,"wholeStriatum"] <- Ki_all[Ki_all[,"sID"]==jj,"wholeStriatum"]
  allDepVars_wide_drug[allDepVars_wide_drug[,"sID"]==jj,"wholePutamen"] <- Ki_all[Ki_all[,"sID"]==jj,"wholePutamen"]
  allDepVars_wide_drug[allDepVars_wide_drug[,"sID"]==jj,"wholeCaudate"] <- Ki_all[Ki_all[,"sID"]==jj,"wholeCaudate"]
  allDepVars_wide_drug[allDepVars_wide_drug[,"sID"]==jj,"VS"] <- Ki_all[Ki_all[,"sID"]==jj,"VS"]
}
allDepVars_wide_drug[,"wholeStriatum_mc"] <- scale(allDepVars_wide_drug$wholeStriatum, scale=F)
allDepVars_wide_drug[,"wholePutamen_mc"] <- scale(allDepVars_wide_drug$wholePutamen, scale=F)
allDepVars_wide_drug[,"wholeCaudate_mc"] <- scale(allDepVars_wide_drug$wholeCaudate, scale=F)
allDepVars_wide_drug[,"VS_mc"] <- scale(allDepVars_wide_drug$VS, scale=F)


# add days between drugs and PET sessions
for (jj in allDepVars_wide_drug$sID){
  allDepVars_wide_drug[allDepVars_wide_drug[,"sID"]==jj,"MPH_PET"] <- drug_PET_difference[drug_PET_difference[,"sID"]==jj,"MPH_PET"]
  allDepVars_wide_drug[allDepVars_wide_drug[,"sID"]==jj,"SUL_PET"] <- drug_PET_difference[drug_PET_difference[,"sID"]==jj,"SUL_PET"]
}  


# remove all NA and NaN values (make empty)
allDepVars_wide_drug[is.na(allDepVars_wide_drug[,])] <- ""
allDepVars_wide_drug[allDepVars_wide_drug[,]== "NaN"] <- ""


# save file 
write.csv(allDepVars_wide_drug, file.path(data_wd,"allDepVars_wide_drug.csv"), row.names=F)


# ________________________________________________________________________________________________________________________________________________________________________
# ________________________________________________________________________________________________________________________________________________________________________









# TRIAL WISE DATASETS



# CLEAN TRIAL-WISE DATASETS
df_colorwheel <- df_colorwheel[is.finite(df_colorwheel$abs_deviance), ]
df_choice <- df_choice[(df_choice$choice_NR!=9), ]


# remove data from participants who haven't completed all 3 behavioral sessions
for (jj in unique(df_colorwheel$sID)){
  if (max(df_colorwheel[df_colorwheel$sID==jj,"session"]) < 3){
    df_colorwheel <- df_colorwheel[df_colorwheel$sID!=jj, ]  
  }
}
for (jj in unique(df_choice$sID)){
  if (max(df_choice[df_choice$sID==jj,"session"]) < 3){
    df_choice <- df_choice[df_choice$sID!=jj, ]  
  }
}    


# COMBINE DATASETS WITH KI VALUES

for (jj in Ki_all$sID){
  df_colorwheel[df_colorwheel[,"sID"]==jj,"wholeStriatum"] <- Ki_all[Ki_all[,"sID"]==jj,"wholeStriatum"]
  df_colorwheel[df_colorwheel[,"sID"]==jj,"wholePutamen"] <- Ki_all[Ki_all[,"sID"]==jj,"wholePutamen"]
  df_colorwheel[df_colorwheel[,"sID"]==jj,"wholeCaudate"] <- Ki_all[Ki_all[,"sID"]==jj,"wholeCaudate"]
  df_colorwheel[df_colorwheel[,"sID"]==jj,"VS"] <- Ki_all[Ki_all[,"sID"]==jj,"VS"]
}
df_colorwheel[,"wholeStriatum_mc"] <- scale(df_colorwheel$wholeStriatum, scale=F)
df_colorwheel[,"wholePutamen_mc"] <- scale(df_colorwheel$wholePutamen, scale=F)
df_colorwheel[,"wholeCaudate_mc"] <- scale(df_colorwheel$wholeCaudate, scale=F)
df_colorwheel[,"VS_mc"] <- scale(df_colorwheel$VS, scale=F)


for (jj in Ki_all$sID){
  df_choice[df_choice[,"sID"]==jj,"wholeStriatum"] <- Ki_all[Ki_all[,"sID"]==jj,"wholeStriatum"]
  df_choice[df_choice[,"sID"]==jj,"wholePutamen"] <- Ki_all[Ki_all[,"sID"]==jj,"wholePutamen"]
  df_choice[df_choice[,"sID"]==jj,"wholeCaudate"] <- Ki_all[Ki_all[,"sID"]==jj,"wholeCaudate"]
  df_choice[df_choice[,"sID"]==jj,"VS"] <- Ki_all[Ki_all[,"sID"]==jj,"VS"]
} 
df_choice[,"wholeStriatum_mc"] <- scale(df_choice$wholeStriatum, scale=F)
df_choice[,"wholePutamen_mc"] <- scale(df_choice$wholePutamen, scale=F)
df_choice[,"wholeCaudate_mc"] <- scale(df_choice$wholeCaudate, scale=F)
df_choice[,"VS_mc"] <- scale(df_choice$VS, scale=F)


# COMBINE WITH DRUG MANIPULATON
for (jj in pharm_manip$subject){
  df_colorwheel[df_colorwheel[,"sID"]==jj & df_colorwheel[,"session"]==1,"drug"] <- pharm_manip[pharm_manip[,"subject"]==jj,"session1"]
  df_colorwheel[df_colorwheel[,"sID"]==jj & df_colorwheel[,"session"]==2,"drug"] <- pharm_manip[pharm_manip[,"subject"]==jj,"session2"]
  df_colorwheel[df_colorwheel[,"sID"]==jj & df_colorwheel[,"session"]==3,"drug"] <- pharm_manip[pharm_manip[,"subject"]==jj,"session3"]
} 

for (jj in pharm_manip$subject){
  df_choice[df_choice[,"sID"]==jj & df_choice[,"session"]==1,"drug"] <- pharm_manip[pharm_manip[,"subject"]==jj,"session1"]
  df_choice[df_choice[,"sID"]==jj & df_choice[,"session"]==2,"drug"] <- pharm_manip[pharm_manip[,"subject"]==jj,"session2"]
  df_choice[df_choice[,"sID"]==jj & df_choice[,"session"]==3,"drug"] <- pharm_manip[pharm_manip[,"subject"]==jj,"session3"]
} 


# RECODE CHOICE
df_choice$choice_NR[df_choice$choice_NR==1] <- 0
df_choice$choice_NR[df_choice$choice_NR==2] <- 1


# add sessions to datasets
for (jj in unique(session_diff$sID)){
  # which session for PBO, MPH, SUL?
  df_colorwheel[df_colorwheel$sID==jj, "MPH"] <- session_diff$MPH[session_diff$sID==jj]
  df_colorwheel[df_colorwheel$sID==jj, "PBO"] <- session_diff$PBO[session_diff$sID==jj]
  df_colorwheel[df_colorwheel$sID==jj, "SUL"] <- session_diff$SUL[session_diff$sID==jj]
  df_choice[df_choice$sID==jj, "MPH"] <- session_diff$MPH[session_diff$sID==jj]
  df_choice[df_choice$sID==jj, "PBO"] <- session_diff$PBO[session_diff$sID==jj]
  df_choice[df_choice$sID==jj, "SUL"] <- session_diff$SUL[session_diff$sID==jj]
  
  # which drug comes first, independent of exact session number?
  df_colorwheel[df_colorwheel$sID==jj, "PBO_before_MPH"] <- session_diff$PBO_before_MPH[session_diff$sID==jj]
  df_colorwheel[df_colorwheel$sID==jj, "PBO_before_SUL"] <- session_diff$PBO_before_SUL[session_diff$sID==jj]
  df_colorwheel[df_colorwheel$sID==jj, "SUL_before_MPH"] <- session_diff$SUL_before_MPH[session_diff$sID==jj]
  df_choice[df_choice$sID==jj, "PBO_before_MPH"] <- session_diff$PBO_before_MPH[session_diff$sID==jj]
  df_choice[df_choice$sID==jj, "PBO_before_SUL"] <- session_diff$PBO_before_SUL[session_diff$sID==jj]
  df_choice[df_choice$sID==jj, "SUL_before_MPH"] <- session_diff$SUL_before_MPH[session_diff$sID==jj]
}


# ________________________________________________________________________________________________________________________________________________________________________
# ________________________________________________________________________________________________________________________________________________________________________

