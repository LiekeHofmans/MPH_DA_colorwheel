

# In this script I calculate behavioral measures with data from the color wheel and choice task.
# For example, to calculate the effect of MPH, I take the IP/ratioRedo/any dependent variable under MPH - score under placebo.
# These scores will be used tso correlate with Ki values of each voxel (using matlab), to see if the effects are baseline dopamine dependent. 



# set up
#________________________________________________________________________________________________________________________________________________________________________

setwd("P:/3017048.01/code/analysis/beh/CW/R_code/")

# run script that loads data and combines datasets
source("set_up.R")


# Calculate difference scores for each bahavioral measure and concatenate to one large dataset to use for the voxelwise analysis.
# I will explore many PET-behavior correlations. 
#________________________________________________________________________________________________________________________________________________________________________


# first, initiate dataset with first column = subjects
behavioral_measures_for_voxelwise_PET <- data.frame(ratioRedo_drug$sID)
colnames(behavioral_measures_for_voxelwise_PET) <- "sID"

# add ratio redo scores
behavioral_measures_for_voxelwise_PET$ratioRedo <- ratioRedo_drug$Total
behavioral_measures_for_voxelwise_PET$ratioRedo_PBO <- ratioRedo_drug$PBO # measure of interest
behavioral_measures_for_voxelwise_PET$ratioRedo_MPH <- ratioRedo_drug$MPH
behavioral_measures_for_voxelwise_PET$ratioRedo_SUL <- ratioRedo_drug$SUL
behavioral_measures_for_voxelwise_PET$MPH_effect_on_ratioRedo <- ratioRedo_drug$MPH - ratioRedo_drug$PBO # measure of interest
behavioral_measures_for_voxelwise_PET$SUL_effect_on_ratioRedo <- ratioRedo_drug$SUL - ratioRedo_drug$PBO # measure of interest
behavioral_measures_for_voxelwise_PET$MPH_vs_SUL_effect_on_ratioRedo <- ratioRedo_drug$MPH - ratioRedo_drug$SUL


# add IP scores
behavioral_measures_for_voxelwise_PET$IP <- IP_drug$Total
behavioral_measures_for_voxelwise_PET$IP_PBO <- IP_drug$PBO # measure of interest
behavioral_measures_for_voxelwise_PET$IP_MPH <- IP_drug$MPH
behavioral_measures_for_voxelwise_PET$IP_SUL <- IP_drug$SUL
behavioral_measures_for_voxelwise_PET$MPH_effect_on_IP <- IP_drug$MPH - IP_drug$PBO # measure of interest
behavioral_measures_for_voxelwise_PET$SUL_effect_on_IP <- IP_drug$SUL - IP_drug$PBO # measure of interest
behavioral_measures_for_voxelwise_PET$MPH_vs_SUL_effect_on_IP <- IP_drug$MPH - IP_drug$SUL


# add deviance scores
behavioral_measures_for_voxelwise_PET$deviance <- deviance_drug$Total
behavioral_measures_for_voxelwise_PET$deviance_PBO <- deviance_drug$PBO
behavioral_measures_for_voxelwise_PET$deviance_MPH <- deviance_drug$MPH
behavioral_measures_for_voxelwise_PET$deviance_SUL <- deviance_drug$SUL
behavioral_measures_for_voxelwise_PET$MPH_effect_on_deviance <- deviance_drug$MPH - deviance_drug$PBO


# add RT scores
behavioral_measures_for_voxelwise_PET$RT <- RT_drug$Total
behavioral_measures_for_voxelwise_PET$RT_PBO <- RT_drug$PBO
behavioral_measures_for_voxelwise_PET$RT_MPH <- RT_drug$MPH
behavioral_measures_for_voxelwise_PET$RT_SUL <- RT_drug$SUL
behavioral_measures_for_voxelwise_PET$MPH_effect_on_RT <- RT_drug$MPH - RT_drug$PBO


# add RTchoice scores
behavioral_measures_for_voxelwise_PET$RTchoice <- RTchoice_drug$Total
behavioral_measures_for_voxelwise_PET$RTchoice_PBO <- RTchoice_drug$PBO # measure of interest (exploratory)
behavioral_measures_for_voxelwise_PET$RTchoice_MPH <- RTchoice_drug$MPH
behavioral_measures_for_voxelwise_PET$RTchoice_SUL <- RTchoice_drug$SUL
behavioral_measures_for_voxelwise_PET$MPH_effect_on_RTchoice <- RTchoice_drug$MPH - RTchoice_drug$PBO # measure of interest (exploratory)
behavioral_measures_for_voxelwise_PET$SUL_effect_on_RTchoice <- RTchoice_drug$SUL - RTchoice_drug$PBO # measure of interest (exploratory)
behavioral_measures_for_voxelwise_PET$MPH_vs_SUL_effect_on_RTchoice <- RTchoice_drug$MPH - RTchoice_drug$SUL

# add days between drug and PET sessions
behavioral_measures_for_voxelwise_PET$MPH_PET <- as.numeric(allDepVars_wide_drug$MPH_PET) # measure of interest (exploratory)
behavioral_measures_for_voxelwise_PET$SUL_PET <- as.numeric(allDepVars_wide_drug$SUL_PET)


# save dataset as csv
write.csv(behavioral_measures_for_voxelwise_PET, file.path(data_wd,"behavioral_measures_for_voxelwise_PET.csv"), row.names=F)




















