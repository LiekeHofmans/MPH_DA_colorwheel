* Encoding: UTF-8.
* open datafile: medical_mood.sav.

* remove participants without pet data (sID 10, 25, 66, 69).
USE ALL.
COMPUTE filter_$=(vID  ~=  10   &   vID ~= 25  & vID ~= 66).
VARIABLE LABELS filter_$ 'vID  ~=  10   &   vID ~= 25  & vID ~= 66 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.


* MANOVA Mood and medical. 3 timepoints.
GLM panasNeg_MPH_1 panasNeg_MPH_2 panasNeg_MPH_3 panasNeg_SUL_1 panasNeg_SUL_2 panasNeg_SUL_3 
    panasNeg_PBO_1 panasNeg_PBO_2 panasNeg_PBO_3 panasPos_MPH_1 panasPos_MPH_2 panasPos_MPH_3 
    panasPos_SUL_1 panasPos_SUL_2 panasPos_SUL_3 panasPos_PBO_1 panasPos_PBO_2 panasPos_PBO_3 
    vasCalm_MPH_1 vasCalm_MPH_2 vasCalm_MPH_3 vasCalm_SUL_1 vasCalm_SUL_2 vasCalm_SUL_3 vasCalm_PBO_1 
    vasCalm_PBO_2 vasCalm_PBO_3 vasAlert_MPH_1 vasAlert_MPH_2 vasAlert_MPH_3 vasAlert_SUL_1 
    vasAlert_SUL_2 vasAlert_SUL_3 vasAlert_PBO_1 vasAlert_PBO_2 vasAlert_PBO_3 vasContend_MPH_1 
    vasContend_MPH_2 vasContend_MPH_3 vasContend_SUL_1 vasContend_SUL_2 vasContend_SUL_3 
    vasContend_PBO_1 vasContend_PBO_2 vasContend_PBO_3 vasMedical_MPH_1 vasMedical_MPH_2 
    vasMedical_MPH_3 vasMedical_SUL_1 vasMedical_SUL_2 vasMedical_SUL_3 vasMedical_PBO_1 
    vasMedical_PBO_2 vasMedical_PBO_3
  /WSFACTOR=drug 3 Simple time 3 Polynomial 
  /MEASURE=negative positive calm alert content medical 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(time*drug)
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=drug time drug*time.


* MANOVA Mood and medical. 2 timepoints.
GLM panasNeg_MPH_1 panasNeg_MPH_2 panasNeg_SUL_1 panasNeg_SUL_2 panasNeg_PBO_1 panasNeg_PBO_2 
    panasPos_MPH_1 panasPos_MPH_2 panasPos_SUL_1 panasPos_SUL_2 panasPos_PBO_1 panasPos_PBO_2 
    vasCalm_MPH_1 vasCalm_MPH_2 vasCalm_SUL_1 vasCalm_SUL_2 vasCalm_PBO_1 vasCalm_PBO_2 
    vasAlert_MPH_1 vasAlert_MPH_2 vasAlert_SUL_1 vasAlert_SUL_2 vasAlert_PBO_1 vasAlert_PBO_2 
    vasContend_MPH_1 vasContend_MPH_2 vasContend_SUL_1 vasContend_SUL_2 vasContend_PBO_1 vasContend_PBO_2 
    vasMedical_MPH_1 vasMedical_MPH_2 vasMedical_SUL_1 vasMedical_SUL_2 vasMedical_PBO_1 vasMedical_PBO_2 
  /WSFACTOR=drug 3 Simple time 2 Polynomial 
  /MEASURE=negative positive calm alert content medical 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(time*drug)
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=drug time drug*time.

* MANOVA Mood and medical. 2 timepoints. Only MPH and PBO.
GLM panasNeg_MPH_1 panasNeg_MPH_2 
    panasNeg_PBO_1 panasNeg_PBO_2 panasPos_MPH_1 panasPos_MPH_2 
    panasPos_PBO_1 panasPos_PBO_2 
    vasCalm_MPH_1 vasCalm_MPH_2 vasCalm_PBO_1 
    vasCalm_PBO_2 vasAlert_MPH_1 vasAlert_MPH_2 vasAlert_PBO_1 vasAlert_PBO_2 vasContend_MPH_1 
    vasContend_MPH_2 
    vasContend_PBO_1 vasContend_PBO_2 vasMedical_MPH_1 vasMedical_MPH_2 
    vasMedical_PBO_1 
    vasMedical_PBO_2 
  /WSFACTOR=drug 2 Simple time 2 Polynomial 
  /MEASURE=negative positive calm alert content medical 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(time*drug)
  /PRINT=DESCRIPTIVE ETASQ
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=drug time drug*time.

* MANOVA Mood and medical. 2 timepoints. Only SUL and PBO.
GLM panasNeg_SUL_1 panasNeg_SUL_2 
    panasNeg_PBO_1 panasNeg_PBO_2 panasPos_SUL_1 panasPos_SUL_2 
    panasPos_PBO_1 panasPos_PBO_2 
    vasCalm_SUL_1 vasCalm_SUL_2 vasCalm_PBO_1 
    vasCalm_PBO_2 vasAlert_SUL_1 vasAlert_SUL_2 vasAlert_PBO_1 vasAlert_PBO_2 vasContend_SUL_1 
    vasContend_SUL_2 
    vasContend_PBO_1 vasContend_PBO_2 vasMedical_SUL_1 vasMedical_SUL_2 
    vasMedical_PBO_1 
    vasMedical_PBO_2 
  /WSFACTOR=drug 2 Simple time 2 Polynomial 
  /MEASURE=negative positive calm alert content medical 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(time*drug)
  /PRINT=DESCRIPTIVE ETASQ
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=drug time drug*time.

* MANOVA Mood and medical. 2 timepoints. Only SUL and MPH.
GLM panasNeg_SUL_1 panasNeg_SUL_2 
    panasNeg_MPH_1 panasNeg_MPH_2 panasPos_SUL_1 panasPos_SUL_2 
    panasPos_MPH_1 panasPos_MPH_2 
    vasCalm_SUL_1 vasCalm_SUL_2 vasCalm_MPH_1 
    vasCalm_MPH_2 vasAlert_SUL_1 vasAlert_SUL_2 vasAlert_MPH_1 vasAlert_MPH_2 vasContend_SUL_1 
    vasContend_SUL_2 
    vasContend_MPH_1 vasContend_MPH_2 vasMedical_SUL_1 vasMedical_SUL_2 
    vasMedical_MPH_1 
    vasMedical_MPH_2 
  /WSFACTOR=drug 2 Simple time 2 Polynomial 
  /MEASURE=negative positive calm alert content medical 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(time*drug)
  /PRINT=DESCRIPTIVE ETASQ
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=drug time drug*time.
* if anything, the difference is between MPH and SUL. 

* MANOVA Mood and medical. Drug effect at timepoint 2.
GLM panasNeg_MPH_2 panasNeg_SUL_2 panasNeg_PBO_2 
    panasPos_MPH_2 panasPos_SUL_2 panasPos_PBO_2 
    vasCalm_MPH_2 vasCalm_SUL_2 vasCalm_PBO_2 
    vasAlert_MPH_2 vasAlert_SUL_2 vasAlert_PBO_2 
    vasContend_MPH_2 vasContend_SUL_2 vasContend_PBO_2 
    vasMedical_MPH_2 vasMedical_SUL_2 vasMedical_PBO_2 
  /WSFACTOR=drug 3 Simple 
  /MEASURE=negative positive calm alert content medical 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(drug)
  /PRINT=DESCRIPTIVE ETASQ
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=drug.

* MANOVA mood and medical. Drug effect (MPH vs PBO) at timepoint2.
GLM panasNeg_MPH_2 panasNeg_PBO_2 
    panasPos_MPH_2 panasPos_PBO_2 
    vasCalm_MPH_2 vasCalm_PBO_2 
    vasAlert_MPH_2 vasAlert_PBO_2 
    vasContend_MPH_2 vasContend_PBO_2 
    vasMedical_MPH_2 vasMedical_PBO_2 
  /WSFACTOR=drug 2 Simple 
  /MEASURE=negative positive calm alert content medical 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(drug)
  /PRINT=DESCRIPTIVE ETASQ
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=drug.



*===========================================================.

* is there an effect of the drugs, especially sul?.

* MANOVA physiological measures. 3 timepoints. 
GLM MPHhr_t1 MPHhr_t2 MPHhr_t3 SULhr_t1 SULhr_t2 SULhr_t3 PBOhr_t1 PBOhr_t2 PBOhr_t3 MPHsBP_t1 
    MPHsBP_t2 MPHsBP_t3 SULsBP_t1 SULsBP_t2 SULsBP_t3 PBOsBP_t1 PBOsBP_t2 PBOsBP_t3 MPHdBP_t1 MPHdBP_t2 
    MPHdBP_t3  SULdBP_t1 SULdBP_t2 
    SULdBP_t3 PBOdBP_t1 PBOdBP_t2 PBOdBP_t3 MPHtemp_t1 MPHtemp_t2 
    MPHtemp_t3 SULtemp_t1 SULtemp_t2 
    SULtemp_t3 PBOtemp_t1 PBOtemp_t2 PBOtemp_t3
  /WSFACTOR=drug 3 Simple time 3 Polynomial 
  /MEASURE=HR BPs BPd temp 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(time*drug)
  /PRINT=DESCRIPTIVE ETASQ
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=drug time drug*time.

* MANOVA physiological measures. 3 timepoints. Only SUL and PBO.
GLM SULhr_t1 SULhr_t2 SULhr_t3 PBOhr_t1 PBOhr_t2 PBOhr_t3 SULsBP_t1 
    SULsBP_t2 SULsBP_t3 PBOsBP_t1 PBOsBP_t2 PBOsBP_t3 SULdBP_t1 SULdBP_t2 
    SULdBP_t3 PBOdBP_t1 PBOdBP_t2 PBOdBP_t3 SULtemp_t1 SULtemp_t2 
    SULtemp_t3 PBOtemp_t1 PBOtemp_t2 PBOtemp_t3
  /WSFACTOR=drug 2 Simple time 3 Polynomial 
  /MEASURE=HR BPs BPd temp 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(time*drug)
  /PRINT=DESCRIPTIVE ETASQ
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=drug time drug*time.

* MANOVA physiological measures. 3 timepoints. Only MPH and PBO.
GLM MPHhr_t1 MPHhr_t2 MPHhr_t3 PBOhr_t1 PBOhr_t2 PBOhr_t3 MPHsBP_t1 
    MPHsBP_t2 MPHsBP_t3 PBOsBP_t1 PBOsBP_t2 PBOsBP_t3 MPHdBP_t1 MPHdBP_t2 
    MPHdBP_t3 PBOdBP_t1 PBOdBP_t2 PBOdBP_t3 MPHtemp_t1 MPHtemp_t2 
    MPHtemp_t3 PBOtemp_t1 PBOtemp_t2 PBOtemp_t3
  /WSFACTOR=drug 2 Simple time 3 Polynomial 
  /MEASURE=HR BPs BPd temp 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(time*drug)
  /PRINT=DESCRIPTIVE ETASQ
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=drug time drug*time.

* MANOVA physiological measures. 2 timepoints.
GLM MPHhr_t1 MPHhr_t2 SULhr_t1 SULhr_t2 PBOhr_t1 PBOhr_t2 MPHsBP_t1 
    MPHsBP_t2 SULsBP_t1 SULsBP_t2 PBOsBP_t1 PBOsBP_t2 MPHdBP_t1 MPHdBP_t2 
    SULdBP_t1 SULdBP_t2 
    PBOdBP_t1 PBOdBP_t2 MPHtemp_t1 MPHtemp_t2 
    SULtemp_t1 SULtemp_t2 
    PBOtemp_t1 PBOtemp_t2 
  /WSFACTOR=drug 3 Simple time 2 Polynomial 
  /MEASURE=HR BPs BPd temp 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(time*drug)
  /PRINT=DESCRIPTIVE ETASQ
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=drug time drug*time.

* MANOVA physiological measures. Drug effect at timepoint 2.
GLM MPHhr_t2 SULhr_t2 PBOhr_t2 MPHsBP_t2 SULsBP_t2 PBOsBP_t2 MPHdBP_t2 SULdBP_t2 PBOdBP_t2 MPHtemp_t2 SULtemp_t2 PBOtemp_t2 
  /WSFACTOR=drug 3 Simple 
  /MEASURE=HR BPs BPd temp 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(drug)
  /PRINT=DESCRIPTIVE ETASQ
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=drug.

* MANOVA physiological measures. Drug effect at timepoint 2. MPH vs PBO. 
GLM MPHhr_t2 PBOhr_t2 MPHsBP_t2 PBOsBP_t2 MPHdBP_t2 PBOdBP_t2 MPHtemp_t2 PBOtemp_t2 
  /WSFACTOR=drug 2 Simple 
  /MEASURE=HR BPs BPd temp 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(drug)
  /PRINT=DESCRIPTIVE ETASQ
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=drug.

* MANOVA physiological measures. Drug effect at timepoint 2. SUL vs PBO. 
GLM SULhr_t2 PBOhr_t2 SULsBP_t2 PBOsBP_t2 SULdBP_t2 PBOdBP_t2 SULtemp_t2 PBOtemp_t2 
  /WSFACTOR=drug 2 Simple 
  /MEASURE=HR BPs BPd temp 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(drug)
  /PRINT=DESCRIPTIVE ETASQ
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=drug.

* MANOVA physiological measures. Drug effect at timepoint 2. MPH vs SUL.
GLM MPHhr_t2 SULhr_t2 MPHsBP_t2 SULsBP_t2 MPHdBP_t2 SULdBP_t2 MPHtemp_t2 SULtemp_t2 
  /WSFACTOR=drug 2 Simple 
  /MEASURE=HR BPs BPd temp 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(drug)
  /PRINT=DESCRIPTIVE ETASQ
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=drug.

