# MPH_DA_colorwheel
Analysis code: Methylphenidate boosts choices of mental labor over leisure depending on striatal dopamine synthesis capacity


# Color wheel and choice analysis code for the complete VICI data set

Directory of analysis code: P:\3017048.01\code\analysis\beh\CW

If you run everything in the following order, it *should* work.

# Preprocessing

The color wheel and choice tasks were programmed in matlab, which gives you output files with a .mat extension. First you will have to convert all .mat files to workable .csv or .xlsx files. 

Directory: .\preprocessing

## Color wheel

Directory: .\preprocessing\ColorwheelAnalysis

*create_long_format.m*
This script combines all color wheel data into 1 big data set, combining all subjects and all sessions. Data will be in long format, which can later be processed in R.
Uses *retrieveDeviance.m*: deviance was calculated as absolute deviance in the task script. Here, I retrieve the raw deviance (ranging -180:180).
Output: *CWdata_long_format.csv* and *CWdata_long_format.xlsx*, saved to P:\3017048.01\bids\derivatives\beh\color_wheel\color_wheel\


*median_performance.m*
This script calculates median deviances and reaction times (RTs) per subject on the color wheel task. Data will be in wide format, which can be used for SPSS analysis. Data comes from *CWdata_long_format.csv* (see above). 
Output: 
*median_deviance_abs.csv* and *median_deviance_abs.xlsx* = median absolute deviance
*median_RT.csv* and *median_RT.xlsx* = median RT
Saved to P:\3017048.01\bids\derivatives\beh\color_wheel\color_wheel\


## Choice

Directory: .\preprocessing\ChoiceAnalysis

*choice_long_format.m*
This script combines all choice data into 1 big data set, combining all subjects and all sessions. Data will be in long format, which can be processed by R. 
Output: *choicedata_long_format.csv* and *choicedata_long_format.xlsx*, saved to P:\3017048.01\bids\derivatives\beh\color_wheel\choice\

*ratioRedo.m*
This script calculates the ratio of redo choices relative to no redo choices per participant, in total, and per condition (update/ignore) per set size (1-4) per session (1-3). The lower the ratio, the less they valued cognitive demand (they rather wanted to stay in the cubicle and do nothing then to redo the task for money). 
Loads *choicedata_long_format.csv* (see above)
Output: 
*ratioRedo_wide_format.csv* and *ratioRedo_wide_format.xlsx*
*ratioRedo_long_format.csv* and *ratioRedo_long_format.xlsx*
Saves to P:\3017048.01\bids\derivatives\beh\color_wheel\choice\

*IP.m*
Running this script calculates IPs and indifferences slopes. 
This script also plots indifference point (IP) curves per participant per session per task-type (ignore, update), showing amounts offered for the easy option (not redoing the task) on the x axis and choice between easy (value = 1) and hard (value = 0) on the y axis. 
Loads *choicedata_long_format.csv*  (see above).
Loads *ratioRedo_wide_format.csv* (see above).
Uses *LogisticRegressionFunction.m* to calculate IPs and betas/slopes.
Output: plots.
It saves the plots to the folder P:\3017048.01\bids\derivatives\beh\color_wheel\choice\graphs_IP
Output: 
*IPs_wide_format.csv* and *IPs_wide_format.xlsx*
*IPs_long_format.csv* and *IPs_long_format.xlsx*
*betas_wide_format.csv* and *betas_wide_format.xlsx*
*betas_long_format.csv* and *betas_long_format.xlsx*
Saves to P:\3017048.01\bids\derivatives\beh\color_wheel\choice

*RTchoice.m*
This script takes the median RT on the choices per participant, in total, and per condition (update/ignore) per set size (1-4) per session (1-3). 
Loads *choicedata_long_format.csv* (see above)
Output: 
*RTchoice_wide_format.csv* and *RTchoice_wide_format.xlsx*
*RTchoice_long_format.csv* and *RTchoice_long_format.xlsx*
Saves to P:\3017048.01\bids\derivatives\beh\color_wheel\choice\


# R_code


Analyses: main text and supplementary information

Directory: .\R_code

### set_up.R
This script is the set up for other R scripts and reads in the preprocessed data from the color wheel and choice task and combines them into various data frames.

Loads:
*CWdata_long_format.csv*
*median_deviance_abs.csv*
*median_RT.csv*
*choicedata_long_format.csv*
*IPs_wide_format.csv* 
*ratioRedo_wide_format.csv*
*RTchoice_wide_format.csv*
*betas_wide_format.csv*
*roi_results_native.csv* (prepared by Ruben van den Bosch; contains mean Ki values for whole mask, ROIs and whole mask/ROIs left and right)
*drugcodes.csv* (prepared by Jessica Määttä; contains which drug people got on which session)
*days_between_drugs_and_PET.csv* (contains the time in days between the PET session and the different drug sessions)
*medical_mood_physiological.csv* (contains data from questionnaires (medical and mood questionnaires) and measures (heart rate, ear temp, blood pressure) collected 3x per drug session)

Output (in wide format, per drug now instead of session number; commented out since they are also combined in *allDepVars_wide_drug.csv*, but if needed, they can be saved separately):
*deviance_drug.csv* 
*RT_drug.csv*
Saved to P:\3017048.01\bids\derivatives\beh\color_wheel\color_wheel
*IP_drug.csv*
*ratioRedo_drug.csv* 
*RTchoice_drug.csv*
*slope_drug.csv*
Saved to P:\3017048.01\bids\derivatives\beh\color_wheel\choice
*session_diff.csv*: difference in session number between the 3 drug manipulations.
*allDepVars_wide_drug.csv*: all dependent variables together in wide format, including drug manipulations and PET data.
Saved to P:\3017048.01\bids\derivatives\beh\color_wheel

### raincloud_plots.R
This function creates raincloud plots, supporting function.

### analyses_manuscript.Rmd
Runs all analyses from the main text.
Loads: *set_up.R*

### analyses_supplement.Rmd
Runs all analyses from the supplemenatry information.
Loads: *set_up.R*

### VICI_figures.Rmd
Generates figures, including drug effects on dependent variabes. 
Loads: *set_up.R* and *raincloud_plots.R*

### calculate_behavioral_measures_for_voxelwise_pet_analysis.R
Calculates the drug effects on behavioral measures, such that we can correlate it with the Ki in each voxel. 
Loads: *set_up.R*
Saved to P:\3017048.01\bids\derivatives\beh\color_wheel



# pet

All code to run voxelwise pet analysis, including generation of dual-coded images.


Directory: .\pet

### pet_beh_voxelwise_CW.m
Matlab script that runs the voxel wise analyses for selected behavioral covariates.
Loads: *behavioral_measures_for_voxelwise_PET.csv*
Calls: *estimat.m* and *design_oneSttest_covariate.m* 
Loads individual PET data (P:\3017048.01\bids\derivatives\pet
It saves output in P:\3017048.01\bids\derivatives\beh\color_wheel\pet

After running this script, I manually check whether there are any voxels that positively or negatively correlate with dopamine synthesis capacity in SPM. I use an inclusive map of a group-based ROI including all voxels > 3SD above the global mean.
I report voxels with p < 0.001 unc, but also apply small volume correction (small volume is that same mask). Significant are the voxels with p < 0.05 FWEc. 
I put this manually derived analysis in *significant_voxels_FWEc_SVC_z3.xlsx* in P:\3017048.01\bids\derivatives\beh\color_wheel\pet


### results_dual_coding.m
Takes output from *pet_beh_voxelwise_CW.m*
For covariates I want to plot as dual-coded brain images, I need to have saved the significant voxels after SVC correction manually as *sigClust_p05_fwe_corrected_binary.nii*
Saves dual coded brain images to P:\3017048.01\bids\derivatives\beh\color_wheel\pet\1_figures_dual_coding_fwe_corrected



# SPSS

Drug effects on physiological measures

Directory: .\SPSS
Open: *mood_medical_phys.sav* and *mood_medical_phys.sps*
This runs the MANOVAs (drug by time effect on mood, medical and physiological data?). 

