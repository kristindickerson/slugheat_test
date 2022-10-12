%%% ==============================================================================
%   Purpose: 
%     This function READS in the information from the penetration that was chosen 
%     in 'GetFiles' function and defined now as variable `PenFile`. This file should have been created by SlugPen. 
%     Instead of using the .pen text file, this function uses the MAT file `MATFile` 
%     that houses structures containing these variables.
%%% ==============================================================================

function [S_MATFile, FullExpeditionName, ...
            StationName, ...
            Penetration, ...
            CruiseName, ...
            Datum, ...
            Latitude, ...
            Longitude, ...
            DepthMean, ...
            TiltMean, ...
            LoggerId, ...
            ProbeId, ...
            NumberOfSensors, ...
            PenetrationRecord, ...
            HeatPulseRecord, ...
            EndRecord, ...
            BottomWaterRawData, ...
            AllRecords, ...
            AllSensorsRawData, ...
            WaterSensorRawData, ...
            EqmStartRecord, ...
            EqmEndRecord, ...
            WaterThermistor ...
    ] = ReadPenFile(MATFile, LogFileId, PenFile, ProgramLogId, ...
    figure_Main, WaterThermistor)

    % Load the MAT file
    % ----------------------------
    
    S_MATFile = load(MATFile);
    
    
    % Read in preliminary penetrtation information and data from 
    % saved MAT file from SlugPen
    % ----------------------------------------------------------------------
    
    StationName         = S_MATFile.S_PenHandles.StationName;
    Penetration         = S_MATFile.S_PenHandles.Penetration;
    CruiseName          = S_MATFile.S_PenHandles.CruiseName;
    Datum               = S_MATFile.S_PenHandles.Datum;
    Latitude            = S_MATFile.S_PenHandles.Latitude;
    Longitude           = S_MATFile.S_PenHandles.Longitude;
    DepthMean           = str2double(S_MATFile.S_PenHandles.Depth);
    TiltMean            = str2double(S_MATFile.S_PenHandles.Tilt);
    LoggerId            = S_MATFile.S_PenHandles.LoggerId;
    ProbeId             = S_MATFile.S_PenHandles.ProbeId;
    NumberOfSensors     = str2double(S_MATFile.S_PenHandles.NumberofSensors);
    %NumberOfSensors     = 6; % added by KD for CHINOoK HF6 where only 6
    %sensors worked
    PenetrationRecord   = S_MATFile.S_PENVAR.PenetrationRecord;
    HeatPulseRecord     = S_MATFile.S_PENVAR.HeatPulseRecord;
    EndRecord           = S_MATFile.S_PENVAR.EndRecord;
    BottomWaterRawData  = S_MATFile.S_PENVAR.BototmWaterRawData;
    AllRecords          = S_MATFile.S_PENVAR.AllRecords';
    AllSensorsRawData   = S_MATFile.S_PENVAR.AllSensorsRawData;
    WaterSensorRawData  = S_MATFile.S_PENVAR.WaterSensorRawData;
    EqmStartRecord      = S_MATFile.S_PENVAR.EqmStartRecord;
    EqmEndRecord        = S_MATFile.S_PENVAR.EqmEndRecord;
    
    FullExpeditionName  = strcat(CruiseName, StationName, Penetration);

% Update LOG file
% -------------------------------------

PrintStatus(LogFileId, ['Penetration file ' PenFile ' read ...'],1)

PrintStatus(ProgramLogId, '-- Reading in penetatration file',2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% KD ADDED IN CASE THERE ARE ANY SENSORS THAT NEED TO BE REMOVED (all NaNs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

BottomWaterRawData = BottomWaterRawData(:, ~isnan(BottomWaterRawData));
AllSensorsRawData = AllSensorsRawData(:, ~all(isnan(AllSensorsRawData)));

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% KD ADDED IN CASE THERE ARE ANY SENSORS THAT NEED TO BE REMOVED (all NaNs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
