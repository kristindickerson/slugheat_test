%%% =====================================================================
%   Purpose: 
%     This function corrects the raw temperature data by using the
%     chosen bottom water temperature as a reference for all thermistors. Next,
%     the temperatures are corrected with respect to the temperature read
%     in the bottom water sensor during the time of measurements.
%%% =====================================================================


function [...
        BottomWaterTemp, ...
        WaterSensorTemp, ...
        AllSensorsTemp ...
        ] = TempCorrection(...
         BottomWaterRawData, ...
         AllSensorsRawData, ...
         WaterThermistor, ...
         WaterSensorRawData, ...
         WaterCorrectionType, Offset, ...
         PenetrationRecord, ...
         AllRecords, ...
         EqmStartRecord, ...
         EqmEndRecord, LogFileId, ProgramLogId,...
         UseWaterSensor, ...
         NumberOfSensors, SensorsToUse, SensorsRemoved, ...
         figure_Main)


% Find record numbers for bottom water equilibrium period and penetration
% -----------------------------------------------------------------
EqmRecords      = find(AllRecords >= EqmStartRecord & ...
                    AllRecords<=EqmEndRecord);
PenRecords      = find(AllRecords >= PenetrationRecord);

% Convert temps to degrees if they are still milli degree
% -----------------------------------------------------------------
if AllSensorsRawData(1,1)>1000
    AllSensorsRawData = AllSensorsRawData/1000;
    BottomWaterRawData = BottomWaterRawData/1000;
    WaterSensorRawData = WaterSensorRawData/1000;
end

% If bottom water sensor readings are bad, user can turn on checkbox for
% 'Ignore Bottom Water Sensor'. This uses equilibrium temps from another
% thermistor. Instead, the correction will use next highest sensor available.
% This is because when bottom water sensor is faulty, there may be other 
% faulty sensors as well. This feature is not meant to be used often, only
% when a water sensor exists but is chosen to be ignored. If there is a
% water sensor, but the values should be ignored. Only works if there are
% no sensors have been removed. 
% -------------------------------------------------------------------------

% Determine if the raw data has a bottom water sensor based on number of
% columns and number of sensors noted in .pen file. 
% ------------------------------------------------------------------------
[~,NC]=size(AllSensorsRawData);
if NC == NumberOfSensors+1 
    WaterThermistor = 1;
elseif NC == NumberOfSensors 
    WaterThermistor = 0; 
end
   
% If no water sensor found or user has selected not to use the existing
% water sensor, change calibration sensor to most shallow working sensor
% and notify user
% ----------------------------------------------------------------------
if UseWaterSensor == 0 && WaterThermistor == 1 
    WaterSensorRawData = AllSensorsRawData(:, SensorsToUse(end));
        uialert(figure_Main, ['Bottom water sensor found but is not being used.' newline ...
        'Most shallow working sensor (T' num2str(SensorsToUse(end)) ') used for calibration instead.'], ...
        'WATER SENSOR NOT USED', 'Icon','info')
elseif WaterThermistor == 0 || all(isnan(WaterSensorRawData))
    uialert(figure_Main, ['No bottom water sensor found.' newline ...
        'Most shallow working sensor (T' num2str(SensorsToUse(end)) ') used for calibration instead.'], ...
        'WATER SENSOR NOT FOUND', 'Icon','info')
    WaterSensorRawData = AllSensorsRawData(:, SensorsToUse(end));
end

% Find raw temperatures for bottom water equilibrium period (used for 
% calibration) and penetration period
% ------------------------------------------------------------------------
EqmTemps                = AllSensorsRawData(EqmRecords,:); % all sensors that are being used
EqmWaterSensorTemps     = WaterSensorRawData(EqmRecords); % bottom water sensor only

PenWaterSensorTemps     = WaterSensorRawData(PenRecords(1):PenRecords(end)); % bottom water sensor only


% Find first, last, and average tempeartures of water sensor thermistor during 
% equilibrium period and average during penetration period
% -----------------------------------------------------------------
FIRSTEqmWaterSensorTemp = EqmWaterSensorTemps(1);
LASTWaterSensorTemp   = EqmWaterSensorTemps(end);
MEANEqmWaterSensorTemp  = mean(EqmWaterSensorTemps);
MEANPenWaterSensorTemp  = mean(PenWaterSensorTemps);


% Find tempeartures of tip of probe - T1 (deepest) - thermistor during 
% equilibrium period
%       ** This is only if you want to calibrate with the deepest
%       thermistor instead of the water sensor thermistor
%       ** To use this, must update .cal file so that 
%       WaterCorrectionType > 5
% ------------------------------------------------------------------------

EqmDeepest = EqmTemps(:,SensorsToUse(1));

FIRSTEqmDeepest = EqmDeepest(1);
LASTEqmDeepest = EqmDeepest(end);
MEANEqmDeepest = mean(EqmDeepest);


% Determine Reference Temperature 0:
%   If referencing to abmient bottom water temperature, use final bottom
%   water equilibrium temperature for calibration. If WaterCorrectionType>5,
%   use final T1 (deepest thermistor) temperature for calibration
% ------------------------------------------------------------------------
if WaterCorrectionType<5
    RefTemp0 = LASTWaterSensorTemp;
else
    RefTemp0 = LASTEqmDeepest;
     uialert(figure_Main, ['Deepest working sensor used for calibration.' newline ...
    'To use bottom water sensor or most shallow working sensor for calibration instead, ' ...
    'change WaterCorrectionType in parameters to < 5' newline ...
     'Water Calibration Type:' newline ...
           '1 = Channels offset to the FIRST point in the BOTTOM WATER' ...
            '   temperature EQUILIRBIUM period' newline ...
           '2 = Channels offset to the LAST point in the BOTTOM WATER' ... 
           '    temperature EQUILIRBIUM period' newline ...
           '3 = Channels offset to the MEAN of all points in the BOTTOM WATER' ... 
           '    temperature EQUILIRBIUM period' newline ...
           '4 = Channels offset to the MEAN of all points in the BOTTOM WATER'   
           '    temperature PENETRATION period' newline ... 
           '5 = Channels offset to the FIRST of all points in the DEEPEST' ... 
           '    probe tip temperature EQUILIRBIUM period' newline ...
           '6 = Channels offset to the LAST of all points in the DEEPEST' ...
           '    probe tip temperature EQUILIRBIUM period' newline ...
           '7 = Channels offset to the MEAN of all points in the DEEPEST' ... 
           '    probe tip temperature EQUILIRBIUM period'], ...
    'SENSOR CALIBRATION INFO', 'Icon','info')
end

% Determine Reference Temperature 1: depends on water correction type 
% defined in calibration (.cal) file
%
%       Water Calibration Type:
%           1 = Channels offset to the FIRST point in the BOTTOM WATER 
%               temperature EQUILIRBIUM period
%           2 = Channels offset to the LAST point in the BOTTOM WATER 
%               temperature EQUILIRBIUM period
%           3 = Channels offset to the MEAN of all points in the BOTTOM WATER 
%               temperature EQUILIRBIUM period
%           4 = Channels offset to the MEAN of all points in the BOTTOM WATER
%               temperature PENETRATION period
%           5 = Channels offset to the FIRST of all points in the DEEPEST 
%               probe tip temperature EQUILIRBIUM period
%           6 = Channels offset to the LAST of all points in the DEEPEST 
%               probe tip temperature EQUILIRBIUM period
%           7 = Channels offset to the MEAN of all points in the DEEPEST 
%               probe tip temperature EQUILIRBIUM period
% ------------------------------------------------------------------------
if WaterCorrectionType == 1
    RefTemp1 = FIRSTEqmWaterSensorTemp;
elseif WaterCorrectionType == 2
    RefTemp1 = LASTWaterSensorTemp;
elseif WaterCorrectionType == 3
    RefTemp1 = MEANEqmWaterSensorTemp;
elseif WaterCorrectionType == 4
    RefTemp1 = MEANPenWaterSensorTemp;
elseif WaterCorrectionType == 5
    RefTemp1 = FIRSTEqmDeepest;
elseif WaterCorrectionType == 6
    RefTemp1 = LASTEqmDeepest;
elseif WaterCorrectionType == 7
    RefTemp1 = MEANEqmDeepest;
end

% Apply correction
% ------------------
TempCorrection = RefTemp1-RefTemp0;

l = length(WaterSensorRawData);

% Only use temps from working sensors
% --------------------------------------
BottomWaterTemp = BottomWaterRawData;
WaterSensorTemp = WaterSensorRawData;
AllSensorsTemp = AllSensorsRawData;

%BottomWaterTemp = repmat(BottomWaterTemp(1:end),l,1);
%AllSensorsTemp = AllSensorsTemp(:, 1:end) - BottomWaterTemp;

if WaterThermistor == 1
    BottomWaterTemp = repmat(BottomWaterTemp(1:end-1),l,1); % extended array of bottom water sensor data for each thermistor except the actual bototm water sensor
    AllSensorsTemp = AllSensorsTemp(:, 1:end-1) - BottomWaterTemp; % all temps of all thermistors except the actual bototm water sensor
else
    BottomWaterTemp = repmat(BottomWaterTemp(1:end),l,1); % extended array of bottom water sensor data for each thermistor 
    AllSensorsTemp = AllSensorsTemp(:, 1:end) - BottomWaterTemp; % all temps of all thermistors because no water sensor
end

AllSensorsTemp = AllSensorsTemp - TempCorrection; % temps for all sensors except the actual bototm water sensor corrected

WaterSensorTemp = WaterSensorTemp - TempCorrection; % actual bototm water sensor corrected

% Manual Offset
% -------------------
if exist('Offset', "var")
   disp([' APPLYING OFFSET OF ',num2str(Offset),' IN TempCorrection.m']);
   AllSensorsTemp  = AllSensorsTemp  + Offset;
   WaterSensorTemp = WaterSensorTemp + Offset;
   BottomWaterTemp = BottomWaterTemp + Offset;
end

% Update penetration LOG file
% -----------------------------
PrintStatus(LogFileId,'Converted raw readings to corrected temperature:',1);
if WaterCorrectionType == 1
    PrintStatus(LogFileId,'Temperature is referenced to first point of bottom water calibration record ...',2);
elseif WaterCorrectionType == 2
    PrintStatus(LogFileId,'Temperature is referenced to last point of the bottom water calibration record ...',2);
elseif WaterCorrectionType == 3
    PrintStatus(LogFileId,'Temperature is referenced to the mean of the bottom water calibration record ...',2);
end

PrintStatus(ProgramLogId, '-- Correcting temperature with respect to bottom water',2)
