# SlugHeat22 Pseudocode

## Purpose / Overview
SlugHeat22 is 



## Inputs- what must travel with the code
### Each individual penetration
* .pen file 
* .tap file

### All penetrations
* SlugHeat22.mat
* SlugHeat22.cal
* SlugHeat22.par






## Outputs
### Text files
* .log file
* .res file

### Plots - each tab
* Penetration Data
* Frictional Decay Reduction
* Heat Pulse Decay Reduction
* Bullard Analysis
* Heat Flow Regression Analysis
* Sensitivity Analysis
* Iterative vs. Inversion Methods Comparison





## List of properties (aka global variables)
*Each variable that is recognized by the entire application. Can reach each variable by dot indexing into the app. Table includes function that creates the variable, the variable type, and a brief description*

 | **_Function_**         | **_Variable_**                        | **_Type_** | **_Description_** |
|------------------------|---------------------------------------|------------|-------------------|
| **_createComponents_** |                                       |            |                   |
|                        | **_figure_Main_**                     |            |                   |
|                        | **_grid_Main_**                       |            |                   |
|                        | **_button_OpenControlsPanel_**        |            |                   |
|                        | **_panel_TabGroup_**                  |            |                   |
|                        | **_grid_TabGroup_**                   |            |                   |
|                        | **_panel_TopLabels_**                 |            |                   |
|                        | **_grid_TopLabels_**                  |            |                   |
|                        | **_label_currentpathfull_**           |            |                   |
|                        | **_label_CurrentPath_**               |            |                   |
|                        | **_label_SlugHeat_**                  |            |                   |
|                        | **_panel_ProcessingInfoLabels_**      |            |                   |
|                        | **_grid_ProcessingInfoLabels_**       |            |                   |
|                        | **_label_ProcessingTime_**            |            |                   |
|                        | **_label_Longitude_**                 |            |                   |
|                        | **_label_Latitude_**                  |            |                   |
|                        | **_label_Penetration_**               |            |                   |
|                        | **_label_Station_**                   |            |                   |
|                        | **_label_Cruise_**                    |            |                   |
|                        | **_edit_CruiseTitle_**                |            |                   |
|                        | **_edit_ProcessingTimeTitle_**        |            |                   |
|                        | **_edit_LongitudeTitle_**             |            |                   |
|                        | **_edit_LatitudeTitle_**              |            |                   |
|                        | **_edit_PenetrationTitle_**           |            |                   |
|                        | **_edit_StationTitle_**               |            |                   |
|                        | **_tabgroup_Main_**                   |            |                   |
|                        | **_tab_PenetrationData_**             |            |                   |
|                        | **_grid_PenetrationData_**            |            |                   |
|                        | **_panel_PD_Thermistors_**            |            |                   |
|                        | **_panel_PenDataAxes_**               |            |                   |
|                        | **_grid_PenDataAxes_**                |            |                   |
|                        | **_label_RecordNumber_**              |            |                   |
|                        | **_axes_BottomWaterTemp_**            |            |                   |
|                        | **_axes_Depth_**                      |            |                   |
|                        | **_axes_Tilt_**                       |            |                   |
|                        | **_axes_TempAboveBWT_**               |            |                   |
|                        | **_tab_FricitonalDecayReduction_**    |            |                   |
|                        | **_grid_FrictionalDecayReduction_**   |            |                   |
|                        | **_panel_FD_Thermistors_**            |            |                   |
|                        | **_panel_FricDecayAxes_**             |            |                   |
|                        | **_grid_FricDecayAxes_**              |            |                   |
|                        | **_axes_TimeShift_**                  |            |                   |
|                        | **_axes_TempvTau_**                   |            |                   |
|                        | **_axes_TempvBullFunc_**              |            |                   |
|                        | **_axes_TempvTime_**                  |            |                   |
|                        | **_tab_HeatPulseDecayReduction_**     |            |                   |
|                        | **_grid_HeatPulseDecayReduction_**    |            |                   |
|                        | **_panel_HPD_Thermistors_**           |            |                   |
|                        | **_panel_HPDecayAxes_**               |            |                   |
|                        | **_grid_HPDecayAxes_**                |            |                   |
|                        | **_axes_TempvTimeShift_**             |            |                   |
|                        | **_axes_MisfitvTimeShift_**           |            |                   |
|                        | **_axes_CTempv1_CTime_**              |            |                   |
|                        | **_axes_CTempvCtime_**                |            |                   |
|                        | **_tab_BullardAnalysis_**             |            |                   |
|                        | **_grid_BullardAnalysis_**            |            |                   |
|                        | **_panel_BA_Thermistors_**            |            |                   |
|                        | **_panel_BullAnalysisAxes_**          |            |                   |
|                        | **_grid_BullAnalysisAxes_**           |            |                   |
|                        | **_axes_TempvDepth_**                 |            |                   |
|                        | **_axes_TCvDepth_**                   |            |                   |
|                        | **_axes_TempvCTR_**                   |            |                   |
|                        | **_tab_HeatFlowRegressionAnalysis_**  |            |                   |
|                        | **_grid_HeatFlowRegressionAnalysis_** |            |                   |
|                        | **_panel_HF_Thermistors_**            |            |                   |
|                        | **_panel_HeatFlowRegAxes_**           |            |                   |
|                        | **_grid_HeatFlowRegAxes_**            |            |                   |
|                        | **_axes_HeatFlow_**                   |            |                   |
|                        | **_axes_Sigma_**                      |            |                   |
|                        | **_tab_SensitivityAnalysis_**         |            |                   |
|                        | **_grid_SensitivityAnalysis_**        |            |                   |
|                        | **_panel_SA_Thermistors_**            |            |                   |
|                        | **_panel_SensAnalysisAxes_**          |            |                   |
|                        | **_grid_SensAnalysisAxes_**           |            |                   |
|                        | **_UIAxes10_2_**                      |            |                   |
|                        | **_UIAxes11_2_**                      |            |                   |
|                        | **_UIAxes9_2_**                       |            |                   |
|                        | **_tab_IterativevsInversionMethods_** |            |                   |
|                        | **_panel_ItervInvMethods_**           |            |                   |
|                        | **_panel_ControlWindow_**             |            |                   |
|                        | **_grid_ControlWindow_**              |            |                   |
|                        | **_panel_PenetrationInfo_**           |            |                   |
|                        | **_grid_PenetrationInfo_**            |            |                   |
|                        | **_button_LoadPen_**                  |            |                   |
|                        | **_label_tapfilename_**               |            |                   |
|                        | **_label_TapFile_**                   |            |                   |
|                        | **_label_penfilename_**               |            |                   |
|                        | **_label_PenFile_**                   |            |                   |
|                        | **_panel_Parameters_**                |            |                   |
|                        | **_grid_Parameters_**                 |            |                   |
|                        | **_label_calfilename_**               |            |                   |
|                        | **_label_CalFile_**                   |            |                   |
|                        | **_label_parfilename_**               |            |                   |
|                        | **_button_SetlParams_**               |            |                   |
|                        | **_label_ParFile_**                   |            |                   |
|                        | **_panel_OutputFiles_**               |            |                   |
|                        | **_grid_OutputFiles_**                |            |                   |
|                        | **_label_resfilename_**               |            |                   |
|                        | **_label_ResFile_**                   |            |                   |
|                        | **_label_logfilename_**               |            |                   |
|                        | **_label_LogFile_**                   |            |                   |
|                        | **_label_resultsfilename_**           |            |                   |
|                        | **_button_Restart_**                  |            |                   |
|                        | **_panel_PlotControls_**              |            |                   |
|                        | **_grid_PlotControls_**               |            |                   |
|                        | **_checkbox_DepthPlot_**              |            |                   |
|                        | **_checkbox_BottomWaterPlot_**        |            |                   |
|                        | **_checkbox_TiltPlot_**               |            |                   |
|                        | **_image_SlugHeat_**                  |            |                   |
|                        | **_panel_Logos_**                     |            |                   |
|                        | **_grid_Logos_**                      |            |                   |
|                        | **_image_OSULogo_**                   |            |                   |
|                        | **_image_WHLogo_**                    |            |                   |
|                        | **_image_UCSCLogo_**                  |            |                   |
|                        | **_panel_DataControls_**              |            |                   |
|                        | **_grid_DataControls_**               |            |                   |
|                        | **_edit_PenEnd_**                     |            |                   |
|                        | **_PenetrationEndLabel_**             |            |                   |
|                        | **_edit_HP_**                         |            |                   |
|                        | **_HeatPulseLabel_**                  |            |                   |
|                        | **_edit_PenStart_**                   |            |                   |
|                        | **_PenetrtionStartLabel_**            |            |                   |
|                        | **_panel_ControlWindowExit_**         |            |                   |
|                        | **_button_ControlWindowExit_**        |            |                   |
|                        | **_panel_Commands_**                  |            |                   |
|                        | **_grid_Commands_**                   |            |                   |
|                        | **_button_Process_**                  |            |                   |
|                        | **_label_TCMethod_**                  |            |                   |
|                        | **_button_Iterative_**                |            |                   |
|                        | **_button_Inversion_**                |            |                   |
|                        | **_button_SensAn_**                   |            |                   |
| **_Initialize_**       |                                       |            |                   |
|                        | **_Version_**                         |            |                   |
|                        | **_Update_**                          |            |                   |
|                        | **_NumberOfColumns_**                 |            |                   |
|                        | **_CurrentPath_**                     |            |                   |
|                        | **_CurrentDateTime_**                 |            |                   |
|                        | **_ParFile_**                         |            |                   |
|                        | **_ParFilePath_**                     |            |                   |
|                        | **_ParFileName_**                     |            |                   |
|                        | **_DefaultParFile_**                  |            |                   |
|                        | **_CalFile_**                         |            |                   |
|                        | **_CalFilePath_**                     |            |                   |
|                        | **_CalFileName_**                     |            |                   |
| **_GetFiles_**         |                                       |            |                   |
|                        | **_PenFileName_**                     |            |                   |
|                        | **_PenFilePath_**                     |            |                   |
|                        | **_PenFile_**                         |            |                   |
|                        | **_TAPName_**                         |            |                   |
|                        | **_TAPFileName_**                     |            |                   |
|                        | **_TAPFile_**                         |            |                   |
|                        | **_MATFileName_**                     |            |                   |
|                        | **_MATFile_**                         |            |                   |
|                        | **_LogFileName_**                     |            |                   |
|                        | **_LogFile_**                         |            |                   |
|                        | **_ResFileName_**                     |            |                   |
|                        | **_ResFile_**                         |            |                   |
|                        | **_ResFileId_**                       |            |                   |
|                        | **_LogFileId_**                       |            |                   |
| **_ReadParFile_**      |                                       |            |                   |
|                        | **_NumberOfSensors_**                 |            |                   |
|                        | **_WaterThermistor_**                 |            |                   |
|                        | **_TimeScalingFactor_**               |            |                   |
|                        | **_DeltaTime_**                       |            |                   |
|                        | **_SensorRadius_**                    |            |                   |
|                        | **_SensorDistance_**                  |            |                   |
|                        | **_TempError_**                       |            |                   |
|                        | **_CalibrationCoeffs_**               |            |                   |
|                        | **_HyndmanCoeffs_**                   |            |                   |
|                        | **_FrictionalDelays_**                |            |                   |
|                        | **_FricMaxStep_**                     |            |                   |
|                        | **_TimeInc_**                         |            |                   |
|                        | **_FricTauMin_**                      |            |                   |
|                        | **_FricTauMax_**                      |            |                   |
|                        | **_PulseDelays_**                     |            |                   |
|                        | **_kInit_**                           |            |                   |
|                        | **_PulsePower_**                      |            |                   |
|                        | **_TimeShiftInit_**                   |            |                   |
|                        | **_TimeShiftInc_**                    |            |                   |
|                        | **_PulseMaxStep_**                    |            |                   |
|                        | **_kTolerance_**                      |            |                   |
|                        | **_PulseTauMin_**                     |            |                   |
|                        | **_PulseTauMax_**                     |            |                   |
|                        | **_HeatPulseLength_**                 |            |                   |
|                        | **_MinTotalkChange_**                 |            |                   |
|                        | **_MaxNumberOfIterations_**           |            |                   |
|                        | **_MaxSAIterations_**                 |            |                   |
|                        | **_Sigmak_**                          |            |                   |
|                        | **_kMin_**                            |            |                   |
|                        | **_kMax_**                            |            |                   |
|                        | **_MinThickness_**                    |            |                   |
|                        | **_UseFrictional_**                   |            |                   |
|                        | **_kAnisotrop_**                      |            |                   |
|                        | **_TopSensorDepth_**                  |            |                   |
| **_ReadPenFile_**      |                                       |            |                   |
|                        | **_S_MATFile_**                       |            |                   |
|                        | **_FullExpeditionName_**              |            |                   |
|                        | **_StationName_**                     |            |                   |
|                        | **_Penetration_**                     |            |                   |
|                        | **_CruiseName_**                      |            |                   |
|                        | **_Datum_**                           |            |                   |
|                        | **_Latitude_**                        |            |                   |
|                        | **_Longitude_**                       |            |                   |
|                        | **_DepthMean_**                       |            |                   |
|                        | **_TiltMean_**                        |            |                   |
|                        | **_LoggerId_**                        |            |                   |
|                        | **_ProbeId_**                         |            |                   |
|                        | **_PenetrationRecord_**               |            |                   |
|                        | **_HeatPulseRecord_**                 |            |                   |
|                        | **_EndRecord_**                       |            |                   |
|                        | **_BottomWaterRawData_**              |            |                   |
|                        | **_AllRecords_**                      |            |                   |
|                        | **_AllSensorsRawData_**               |            |                   |
|                        | **_WaterSensorRawData_**              |            |                   |
|                        | **_EqmStartRecord_**                  |            |                   |
|                        | **_EqmEndRecord_**                    |            |                   |
| **_ReadTAPFile_**      |                                       |            |                   |
|                        | **_TAPRecord_**                       |            |                   |
|                        | **_Tilt_**                            |            |                   |
|                        | **_Depth_**                           |            |                   |
| **_ReadCalFile_**      |                                       |            |                   |
|                        | **_WaterCorrectionType_**             |            |                   |
|                        | **_Offset_**                          |            |                   |
| **_TempCorrection_**   |                                       |            |                   |
|                        | **_BottomWaterTemp_**                 |            |                   |
|                        | **_WaterSensorTemp_**                 |            |                   |
|                        | **_AllSensorsTemp_**                  |            |                   |
| **_SplitDecays_**      |                                       |            |                   |
|                        | **_FricTime_**                        |            |                   |
|                        | **_FricTemp_**                        |            |                   |
|                        | **_PulseData_**                       |            |                   |
|                        | **_PulseTime_**                       |            |                   |
|                        | **_PulseTemp_**                       |            |                   |
| **_PlotRawData_**      |                                       |            |                   |
|                        | **_Badk_**                            |            |                   |
|                        | **_BadT_**                            |            |                   |
|                        | **_S_Lines_**                         |            |                   |
| **_startupFcn_**       |                                       |            |                   |
|                        | **_DepthPlot_**                       |            |                   |
|                        | **_BWPlot_**                          |            |                   |
|                        | **_TiltPlot_**                        |            |                   |
|                        | **_C_**                               |            |                   |
| **_SetParams_**        |                                       |            |                   |
|                        | **_SetParamsDialogApp_**              |            |                   |







## List of functions 
*Most functions are their own separate .m file. Table also includes the callback that calls the function (pushbuttons, checkboxes, etc.) and a brief description.*

| ***Callback***                             | ***Function***       | ***Description***                                                                                                                                                                 |
|--------------------------------------|----------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ***startupFcn***                           |                | code that executes when the figure is created                                                                                                                               |
|                                      | **Initialize**     | initialize the program                                                                                                                                                     |
|                                      | **ReadParFile**    | reads in the parameters (.par) file and temp and pressure (.tap) file                                                                                                      |
|                                      | **ReadCalFile**    | reads in the bottom water temperature calibration (.cal) file                                                                                                              |
|                                      | **updateLabels**  | updates the main app layout                                                                                                                                                 |
|                                      | **PrintStatus**  | prints program status to SlugHeat22 LOG file layout                                                                                                                                                 |
| ***button_OpenControlsPanelPushed***       |                | code that executes when button to open controls panel is pushed                                                                                                             |
| ***button_ControlWindowExitButtonPushed*** |                | code that executes when button to close controls panel is pushed                                                                                                            |
| ***button_LoadPenPushed***                 |                | code that executes when button to load penetration data is pushed                                                                                                           |
|                                      | **Reset**          | resets the axes and all information prior to reading in a penetration file                                                                                                 |
|                                      | **GetFiles**       | gets .pen and .tap input files, creates .log and .res output files                                                                                                         |
|                                      | **ReadPenFile**    | reads in the penetration (.pen) data using a .mat file created during SlugPen                                                                                              |
|                                      | **ReadTAPFile**    | reads in the temp and pressure (.tap) data using a .mat file created during SlugPen                                                                                        |
|                                      | **TempCorrection** | corrects the raw temperature data                                                                                                                                          |
|                                      | **SplitDecays**    | splits penetration and heat pulse                                                                                                                                          |
|                                      | **PlotRawData**    | plot raw penetration data on penetration data tab                                                                                                                          |
|                                      | **updateLabels***  | updates the main app layout                                                                                                                                                |
|                                      | **xAlign**         | aligns x axes of each plot                                                                                                                                                  |
| ***checkbox_BottomWaterPlotValueChanged*** |                | code that executes when checkbox for bottom water plot control is changed                                                                                                   |
|                                      | **plotLayout**     | updates plot layout depending on which are turned off and on                                                                                                                |
|                                      | **xAlign**         | aligns x axes of each plot                                                                                                                                                  |
| ***checkbox_DepthPlotValueChanged***       |                | code that executes when checkbox for depth plot control is changed                                                                                                          |
|                                      | **plotLayout**     | updates plot layout depending on which are turned off and on                                                                                                                |
|                                      | **xAlign**         | aligns x axes of each plot                                                                                                                                                  |
| ***checkbox_TiltPlotValueChanged***        |                |                                                                                                                                                                             |
|                                      | **plotLayout**     | updates plot layout depending on which are turned off and on                                                                                                                |
|                                      | **xAlign**         | aligns x axes of each plot                                                                                                                                                  |
| ***button_SetlParamsPushed***              |                | code that executes when button for manually selecting parameters is pressed                                                                                                 |
|                                      | **SetParams**      | AUXILLARY DIALOG APPLICATION - creates a new app where parameters are shown. user can change the parameters on this app and the new values are passed back to the main app. |
| ***button_RestartPushed***                 |                | code that executes when button for fully resetting program to start is pressed                                                                                              |
|                                      | **Reset**          | resets the axes and all information prior to reading in a penetration file                                                                                                  |
| ***edit_PenStartValueChanged***            |                | code that executes when numeric edit field value for penetration start record is changed                                                                                    |
| ***edit_HPValueChange***                   |                | code that executes when numeric edit field value for heat pulse record is changed                                                                                           |
| ***edit_PenEndValueChanged***              |                | code that executes when numeric edit field value for penetration end record is changed                                                                                      |
| ***createComponents***                     |                | code that executes when SlugHeat22 is run in command window - creates all components for application                                                                        |
| ***delete***                               |                | code that executes when SlugHeat22 is closed - deletes entire main figure and all its components                                                                            |







## Description of each function - more detailed, list inputs, outputs, purpose, etc. 

# Function: `PrintStatus`

## Inputs:
(`FileID`, `Message`, `LineFeed`)

## Outputs:
***none***

## Purpose: 
**This function is used to print out the current status of of the program onto an output file, generally either the Log file or Res file**
* FileID = file to be written on
* Message = message to be written
* LineFeed = how many lines to move cursor to after message (i.e if LineFeed = 1,
* the next message will be written on the line directly under the current message.
* If LineFeed = 2, there cursor will skip a line and there will be a space between
* the current message and next message)

## Pseudocode

```
If there are fewer than 3 input arguments
    Print 'Message' to the file indicated by FileID
Else
    Print 'Message' to the file indicated by FileID with the as many lines as indicated by LineFeed
```


# Function: `ReadParFile`

## Inputs: 
***none***

## Outputs:
[`ParFile`,
`ParFilePath`,
`ParFileName`,
`DefaultParFile`,
`CalFile`,
`CalFilePath `,
`CalFileName`,
`NumberOfSensors`,
`WaterThermistor`,
`TimeScalingFactor`,
`DeltaTime`,
`SensorRadius`,
`SensorDistance`,
`TempError`,
`CalibrationCoeffs`,
`HyndmanCoeffs`,
`FrictionalDelays`,
`FricMaxStep`,
`TimeInc`,
`FricTauMin`,
`FricTauMax`,
`PulseDelays`,
`kInit`,
`PulsePower`,
`TimeShiftInit`,
`TimeShiftInc`,
`PulseMaxStep`,
`kTolerance`,
`PulseTauMin`,
`PulseTauMax`,
`HeatPulseLength`,
`MinTotalkChange`,
`MaxNumberOfIterations`,
`MaxSAIterations`,
`Sigmak0`,
`kMin`,
`kMax`,
`MinThickness`,
`UseFrictional`,
`kAnisotropy`,
`TopSensorDepth`]

## Purpose: 
**This function reads in the parameters from .par file and .cal file:**      
1. Parameter (.par) file -- defines the default parameters to run program. This should be updated by the user before running SlugHeat. 
2. Calibration (.cal) file -- this defines what type of water calibration type is to be used to calibrate bottom water temperatures.

## Pseudocode:

```
Define default PAR file `SlugHeat22.par` (always the same text file for any general penetration)

Create SlugHEat22 LOG (.log) output file to record progess of program

Get PAR file
    If there is no default 'SlugHeat22.par' file in the current directory,
       User to choose new .par file
    If there is 'SlugHeat22.par' in the current directory,
       This file is used as the default parameter file
Get CAL file
    If there is no default 'SlugHeat22.cal' file in the current directory,
       User to choose new .par file
    If there is 'SlugHeat22.cal' in the current directory,
       This file is used as the default parameter file

Update SlugHEat22 LOG file 

Open PAR file
* Find all Carriage Line Returns (ascii code = 10)***

Read in parameters
```


### PAR file line by line and corresponding variable once read in 
------------------------------------------------------------------
| **Line** |                                **Parameter**                                |       **Variable Name**      |
|:--------:|:---------------------------------------------------------------------------:|:----------------------------:|
|     1    |                              Number of Sensors                              |        NumberOfSensors       |
|     2    |                         Is there a water thermistor?                        |        WaterThermistor       |
|     3    |                        Time scaling factor (sec/unit)                       |       TimeScalingFactor      |
|     4    |                    Time between thermistor readings (sec)                   |           DeltaTime          |
|     5    |                              Sensor radius (m)                              |         SensorRadius         |
|     6    |                         Distance between sensors (m)                        |        SensorDistance        |
|     7    |                        Assumed tempearture error (K)                        |           TempError          |
|     8    |                          Length of heat pulse (sec)                         |        HeatPulseLength       |
|     9    |                           Calibration coefficients                          |       CalibrationCoeffs      |
|    10    |                           Calibration coefficients                          |       CalibrationCoeffs      |
|    11    |                           Calibration coefficients                          |       CalibrationCoeffs      |
|    12    |                          Hyndman Coefficients for k                         |         HyndmanCoeffs        |
|    13    |                         Frictional time delays (sec)                        |       FrictionalDelays       |
|    14    | Maximum number of steps and Time increment in frictional delay calculations |     FricMaxStep & TimeInc    |
|    15    |         Minimum and maximum Tau values used for the frictional delay        |    FricTauMin & FricTauMax   |
|    16    |                           Pulse time delays (sec)                           |          PulseDelays         |
|    17    |                        Initial Conductivities (W m/K)                       |             kInit            |
|    18    |                           Heat pulse power (J/m/s)                          |          PulsePower          |
|    19    |                     Initial time shit & Increment (sec)                     | TimeShiftInit & TimeShiftInc |
|    20    |     Maximum iteration number & error tolerance on conductivity iteration    |   PulseMaxStep & kTolerance  |
|    21    |           Minimum and max Tau values used for the heat pulse delay          |   PulseTauMin & PulseTauMax  |


# Function: `ReadCalFile`

## Inputs: 
(`CalFile`)

## Outputs:
[`WaterCorrectionType`,
 `Offset`]

## Purpose: 
**This function gets the water calibration type and manual offset from the CAL file to be used in the temperature correction calculation (`TempCorrection.m`)**

## Pseudocode

```
Open CAL file

Finds all Carriage Line Returns (ascii code = 10)

Read in calibration data

Close CAL file
```


###### CAL file line by line and corresponding variable once read in 
------------------------------------------------------------------
| **Line** |                                **Parameter**                                |       **Variable Name**      |
|:--------:|:---------------------------------------------------------------------------:|:----------------------------:|
|     1    |                              Water Correction Type                          |      WaterCorrectionTypes    |
|     2    |                                 Manual Offset                               |             Offset           |


# Function: `updateLabels`

## Inputs: 
(`label_currentpathfull`, `CurrentPath`, `label_calfilename`, ...
    `CalFileName`, `label_parfilename`, `ParFileName`, `label_penfilename`, ...
    `PenFileName`, `label_tapfilename`, `TAPFileName`, `label_resfilename`, ...
    `ResFileName`, `label_logfilename`, `LogFileName`, `label_Cruise`, `CruiseName`, ...
    `label_Station`, `StationName`, `label_Penetration`, `Penetration`, ...
    `label_Latitude`, `Latitude`, `label_Longitude`, `Longitude`, `edit_PenStart`, ...
    `PenetrationRecord`, `edit_PenEnd`, `EndRecord`, `edit_HP`, `HeatPulseRecord`)

## Outputs:
***none***

## Purpose: 
**This function updates the labels on the main figure - all labels, text boxes, checkboxes,legends, etc. are updated to current conditions.**

## Pseudocode

```
Labels for current path, CAL file, and PAR file are updated according to updated correspinding variables upon start up of app

If there is a penfile loaded in, 
    labels definining penetration information is updated
```

# Function: `Reset`

## Inputs: 
(`axes_TempAboveBWT`, 
`axes_BottomWaterTemp`, 
`axes_Depth`, 
`axes_Tilt`, 
`checkbox_BottomWaterPlot`, 
`checkbox_DepthPlot`, 
`checkbox_TiltPlot`, 
`S_MATFile`, 
`NumberOfSensors`)

## Outputs:
***none***

## Purpose: 
**This function RESETS the axes and all information prior to reading in a penetration file. Default parameters remain those read in from the default .par file and default .cal file.**

## Pseudocode

```
Clear axes

Reset plot controls - all plots set to visible 

Clear penetration information
```

# Function: `GetFiles`

## Inputs: 
(`Version`,
`Update`,
`NumberOfColumns`,
`CurrentPath, CurrentDateTime, ParFile, NumberOfSensors`,
`TimeScalingFactor`,
`SensorRadius`,
`SensorDistance`,
`CalibrationCoeffs`,
`HyndmanCoeffs`,
`FrictionalDelays`,
`FricMaxStep`,
`TimeInc`,
`FricTauMin`,
`FricTauMax`,
`PulseDelays`,
`kInit`,
`PulsePower`,
`TimeShiftInc`,
`PulseMaxStep`,
`kTolerance`,
`PulseTauMin`,
`PulseTauMax`,
`HeatPulseLength`,
`MinTotalkChange`,
`MaxNumberOfIterations`,
`MaxSAIterations`,
`Sigmak0`,
`kMin`,
`kMax`,
`MinThickness`,
`UseFrictional`,
`kAnisotropy`,
`TopSensorDepth`)

## Outputs:
[`PenFileName`, 
`PenFilePath`, 
`PenFile`, 
`TAPName`, `TAPFileName`, `TAPFile`, 
`MATFileName`, `MATFile`, 
`LogFileName`, `LogFile`, 
`ResFileName`, `ResFile`, 
`ResFileId`, `LogFileId`]

## Purpose: 
**This function creates these OUPUT files:**
1. Log (.log) file -- logs the individual penetration's information and progress
2. Results (.res) file -- records all results of processing 
**This function also gets these INPUT files:**
1. Penetration (.pen) file -- datafile created by SlugPen prior to running SlugHeat. This is the parsed data from each penetration needed to be processed by SlugHeat. 
2. Tilt and pressure (.tap) file -- datafile created by SlugPen prior to running SlugHeat.

## Pseudocode

```
Get penetration (PEN) file in the subfolder 'PenetrationFiles'
    User chooses from any files with extension .pen

Get tilt and pressure (TAP) file and mat (MAT) file created by SlugPen using same name as PEN file

Create penetration results (RES) and log (LOG) files with same name as PEN file

Print header to penetration LOG and RES files

Print parameters from PAR file to LOG and RES files
    * Parameters could have been manually changed by user. The most updated values for each parameter either from original PAR file or user's manual inputs will be recorded

Update SlugHeat22 LOG File
```

# Function: `ReadPenFile`

## Inputs: 
(`MATFile`, `LogFileId`, `PenFile`)

## Outputs:
[`S_MATFile`, 
`FullExpeditionName`,
`StationName`,
`Penetration`,
`CruiseName`,
`Datum`,
`Latitude`,
`Longitude`,
`DepthMean`,
`TiltMean`,
`LoggerId`,
`ProbeId`,
`NumberOfSensors`,
`PenetrationRecord`,
`HeatPulseRecord`,
`EndRecord`,
`BottomWaterRawData`,
`AllRecords`,
`AllSensorsRawData`,
`WaterSensorRawData`,
`EqmStartRecord`,
`EqmEndRecord`]

## Purpose: 
**This function READS in the information from the penetration that was chosen in 'GetFiles' function and defined now as variable `PenFile`. This file should have been created by SlugPen. Instead of using the .pen text file, this function uses the MAT file `MATFile` that houses structures containing these variables.**

## Pseudocode

```
Load in MAT file with variables created in SlugPen

Save preliminary penetratation information and data from saved MAT file
from SlugPen as new variables

Update penetration LOG file
```

# Function: `ReadTAPFile`

## Inputs: 
(`S_MATFile`, `TAPFileName`, `LogFileId`)

## Outputs:
[`TAPRecord`,
 `Tilt`,
 `Depth`]

## Purpose: 
**This function READS in the tilt and pressure (.tap) information from the penetration that was chosen in 'GetFiles' function and defined now as variable `TAPFile`. This file should have been created by SlugPen. Instead of using the .tap text file, this function uses the MAT file `MATFile` that houses structures containing these variables.**

## Pseudocode

```
Save preliminary penetratation tilt & pressure information and data from saved MAT file from SlugPen as new variables

Update penetration LOG file
```

***Question: SlugHeat15 does a TILT CORRECTION. Do we want to include this?***


# Function: `TempCorrection`

## Inputs:
(`BottomWaterRawData`, 
`AllSensorsRawData`, 
`WaterThermistor`,
`WaterSensorRawData`,
`WaterCorrectionType`, `Offset`,
`PenetrationRecord`, 
`AllRecords`, 
`EqmStartRecord`, 
`EqmEndRecord`, `LogFileId`)

## Outputs:
[`BottomWaterTemp`, 
`WaterSensorTemp`, 
`AllSensorsTemp`]

## Purpose: 
**This function corrects the raw temperature data in two ways:**

1. Covert temperature to temperature relative to bottom water. Bottom water temps for each thermistor determined by temp recorded at final measurement of equilibrium (calibration) period selected in SlugPen. This brings the thermistors to the same reference (bottom water).

2. Using the chosen calibration type (first, last, or average temperatures of either the bottom water sensor or the deepest sensor) during the bottom water equilibrium period to correct with respect to the temperature read in the bottom water during the time of measurements. This corrects for variability between each sensor. A single offset is then added to each thermistor(default is +0.15 °C). 

## Pseudocode

```
Find record numbers for bottom water equilibrium period and penetration

Find raw temperatures for bottom water equilibrium period (used for calibration) and penetration 

Find first, last, and average tempeartures of water sensor (shallowest) thermistor during equilibrium period and average during penetration period

Find tempeartures of tip of probe - T1 (deepest) thermistor during equilibrium period

Determine Reference Temperature 0:
If water correction type is LESS than 5       
        Referencing final equilibrium temp of BOTTOM WATER SENSOR
If water correction type is MORE than 5
        Referencing final equilirbium temp of DEEPEST SENSOR

Determine Reference Temperature 1:
If water correction type is 1
        Channels offset to the FIRST point in the bottom water 
        temperature EQUILIRBIUM period
If water correction type is 2 
        Channels offset to the LAST point in the bottom water 
        temperature EQUILIRBIUM period
If water correction type is 3
        Channels offset to the MEAN of all points in the bottom water 
        temperature EQUILIRBIUM period
If water correction type is 4
        Channels offset to the MEAN of all points in the bottom 
        water temperature PENETRATION period
If water correction type is 5
        Channels offset to the FIRST of all points in the DEEPEST 
        probe tip temperature EQUILIRBIUM period
If water correction type is 6
        Channels offset to the LAST of all points in the DEEPEST 
        probe tip temperature EQUILIRBIUM period
If water correction type is 7
        Channels offset to the MEAN of all points in the DEEPEST 
        probe tip temperature EQUILIRBIUM period

Temp Correction = Reference Temperature 1 - Reference Temperature 0

If there is a bottom water sensor
        Ambient bottom water temperatures (temp at each thermistor at final measurement of equilibrium period) array is extended to be the size of array containing all sensor temperatures NOT including the bottom water sensor
Else
        Ambient bottom water temperatures (temp at each thermistor at final measurement of equilibrium period) array is extended to be the size of array containing ALL sensor temperatures 

Ambient bottom water temperature is subtracted from all temperatures to bring each thermistor to the same reference (Temps are now temps relative to bottom water)

Temp Correction subtracted from each temperature measurement at each thermistor except water sensor

Temp Correction subtracted from each tempearture measurement at water sensor

Manual offset applied to each temperature, inclduding:
        All temps at all penetrating sensors 
        All temps at bottom water sensor
        All ambient bottom water temps

Update penetration LOG file
```


# Function: `SplitDecays`

## Inputs:
(`PenetrationRecord`,
`HeatPulseRecord`,
`EndRecord`,  
`AllRecords`,
`TimeScalingFactor`,
`AllSensorsTemp`, `LogFileId`)

## Outputs:
[`FricTime`,
`FricTemp`,
`PulseData`,
`PulseTime`,
`PulseTemp`]

## Purpose: 
**This function splits the decay in two sets: one for FRICTIONAL DECAY and one for HEAT PULSE DECAY** 
Two markers given in header of .pen files: 
1. 1st indicates beginning of the frictional decay
2. 2nd indicates beginning of the heat pulse decay

## Pseudocode

```
Define whether or not there is a heat pulse during this penetration
If there is NO heat pulse record
    Set PulseData = 0
    Make the end of frictional decay record number the end of penetration record number
else
    Set PulseData = 1
    Make the end of frictional decay record number the heat pulse record - 1

Define frictional decay record numbers = record numbers between start of penetration and start of heat pulse (or end of penetration if there is no heat pulse)
Define frictional decay time = time scaling factor * (frictional decay record number - frictional decay START record number)
        ***Time scaling factor is a pre-set parameter from the PAR file or manually set by the user***
Define frictional decay temps = temps during frictional decay at every sensor

 If there is a heat pulse
    Define heat pulse decay record numbers = record numbers between start of heat pulse and  end of penetration 
    Define frictional decay time = time scaling factor * (heat pulse decay record number - frictional decay START record number)
        ***Time scaling factor is a pre-set parameter from the PAR file or manually set by the user***
    Define heat pulse decay temps = temps during heat pulse decay at every sensor
Else
    Define heat pulse decay time = empty vector
    Define heat pules decay temp = empty vector

Update penetration LOG file
```


# Function: `PlotRawData`

## Inputs:
(`axes_TempAboveBWT`, `axes_BottomWaterTemp`,
`axes_Depth`, `axes_Tilt`, 
`panel_PD_Thermistors`, `checkbox_BottomWaterPlot`, 
`checkbox_DepthPlot`, `checkbox_TiltPlot`, 
`AllSensorsTemp`, 
`NumberOfSensors`, 
`WaterThermistor`, 
`WaterSensorTemp`, 
`Tilt`,
`Depth`, 
`TAPRecord`, `LogFileId`, 
`AllRecords`, `PenetrationRecord`, `HeatPulseRecord`, `EndRecord`, 
`PulseData`)

## Outputs:
[`BadT`, `Badk`, `S_Lines`]

## Purpose: 
**This function plots the inital raw data from the penetration and tap file before any other processing has been done, except correcting temperature of each thermistor with reference to bottom water. These plots are found under the Penetration Data tab on SlugHeat GUI.**

## Pseudocode

```
If there is a bottom water sensor
    Subtract 1 from Number of Sensors (because bottom water sensor will be plotted on a separate axes)

Define variables BadT and Badk = empty vectors

Define plot colormap using 'jet' and interpolating to the number of sensors 

For all sensors except bottom water sensor
    Plot record number on X axis and temperature relative to bottom water on Y axis using previously defined colormap
    Turn on minor ticks for X axis and Y axis

For all sensors except bottom water sensor
    Create a grid layout on the thermister panel with row height evenly weighted and as many rows as there are sensors except bottom water sensor
    Create a panel on each row of grid for each sensor
        Each panel title is the sensor number
    Create a grid layout on each panel for each sensor with evenly weighted row and height
    Create a checkbox on each sensors's grid layout 
        Set checkbox value to 'on'

If there is a bototm water sensor
    Plot temperatures of bottom water sensor vs. record number on second axes
Else
    Display message box telling user that there is no water sensor data and if they would like to include water sensor data, to update this parameter manually

If there is a tilt and pressure record 
    Plot depth vs. record number on third axes
    Rotate Y tick labels by 15°
    Set Y axis tick direction to reverse so that higher depths are at the bottom of the Y axis
Else
    Display message box telling user there is no TAP record and provide average depth

If there is a tilt and pressure record
    Plot tilt vs. record number on fourth axes
Else
    Display message box telling user there is no TAP record and provide average tilt

Plot vertical line indicating start of penetration on all four axes

If there was a heat pulse 
    Plot vertical line indicating heat pulse on all four axes

Plot vertical line indicating end of penetration on all four axes

Create structures to house these vertical lines for each plot

Link X axes of all four plots -- zooming or panning on one does the same to rest of plots

Sensor colorbar to turn sensors 'on' and 'off' -- STILL NEEDS TO BE INCLUDED IN CODE, DOES NOT WORK YET

Save all variables created so far in a MAT file named 'SlugHeat22_PenFileName'

Update penetration LOG file
```


# Function: `xAlign`

## Inputs:
(`Plot1`, `Axes1`, `Plot2`, `Axes2`, `Plot3`, `Axes3`, `Plot4`, `Axes4`)

#### The inputs from SlugHeat22 when aligning x axes for Penetration Data tab correspond to:
##### `Plot1` --> `DepthPlot`
##### `Axes1` --> `axes_Depth`
##### `Plot2` --> `BWPlot`
##### `Axes2` --> `axes_BottomWaterTemp`
##### `Plot3` --> `TiltPlot`
##### `Axes3` --> `axes_Tilt`
##### `Plot4` --> `TempPlot`
##### `Axes4` --> `axes_TempAboveBWT`

## Outputs:
***none***

## Purpose: 
**This function aligns the X axes of each plot on the penetration data tab. The left edges of the inner position and the plots' widths are aligned. The order of the plots entered is the order of importance. All plots will be aligned according the the first named plot's position.** 

## Pseudocode

```
Pause for one second

If the depth plot visibility is ON
    If the bottom water plot is on
        Set the left bottom corner position of the bottom water temp plot equal to the left bottom corner position of the depth plot
        Set the width of the bottom water temp plot equal to the width of the depth plot
    If the tilt plot is on
        Set the left bottom corner position of the tilt plot equal to the left bottom corner position of the depth plot
        Set the width of the tilt plot equal to the width of the depth plot
    If the temp abover bottom water plot is on
        Set the left bottom corner position of the temp abover bottom water plot equal to the left bottom corner position of the depth plot
        Set the width of the temp abover bottom water plot equal to the width of the depth plot 
    Pause for one second
Else if the depth plot visibility is OFF
    Set the left bottom corner position of the bottom water temp plot equal to the left bottom corner position of the temp abover bottom water plot
    Set the width of the bottom water temp plot equal to the width of the temp abover bottom water plot
    Set the left bottom corner position of the tilt plot equal to the left bottom corner position of the temp abover bottom water plot
    Set the width of the tilt plot equal to the width of the temp abover bottom water plot
    Pause for one second
```
# Function: `plotLayout`

## Inputs:
(`grid`, `Plot1`, `Axes1`, `Plot2`, `Axes2`,
`Plot3`, `Axes3`)

#### The inputs from SlugHeat22 when aligning x axes for Penetration Data tab correspond to:
##### `grid`  --> `grid_PenDataAxes`
##### `Plot1` --> `DepthPlot`
##### `Axes1` --> `axes_Depth`
##### `Plot2` --> `BWPlot`
##### `Axes2` --> `axes_BottomWaterTemp`
##### `Plot3` --> `TiltPlot`
##### `Axes3` --> `axes_Tilt`

## Outputs:
***none***

## Purpose: 
**This function turns visibility of children of plots on and off depending on if their axes are turned off or on with the use of checkboxes, etc. There are two smaller functions nested within:**
1. axesChildrenOFF - turns OFF an visibility of axes' children
2. axesChildrenON - turns ON the visibility of axes' children

## Pseudocode

```
Convert values of all checkboxes to strings

Concatenate strings of values with the letter x so that this string can be used in the grid layout function

Update grid layout. Keep temperature plot at a constant weight (5x all other plots)
    Other plots will have 0x weight if its corresponding checkbox is off (value=0) and 1x weight if its corresponding checkbox is on (value=1)

If axis visibility is ON
    Axis' children visibility is ON

If axis visibility is OFF
    Axis' children visibility is OFF