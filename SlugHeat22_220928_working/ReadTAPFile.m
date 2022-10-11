%%% ==============================================================================
%   Purpose: 
%     This function READS in the tilt and pressure (.tap) information from the penetration that was chosen 
%     in 'GetFiles' function and defined now as variable `TAPFile`. This file should have been created by SlugPen. 
%     Instead of using the .tap text file, this function uses the MAT file `MATFile` 
%     that houses structures containing these variables.
%%% ======================================================================================

function [TAPRecord, ...
         Tilt, Depth ...
         ] = ReadTAPFile(S_MATFile, TAPFileName, LogFileId, ProgramLogId, ResFileId, SensorDistance)


% Read in preliminary penetrtation tilt and pressure information 
% and data from saved MAT file from SlugPen
% * pressure = depth
% ----------------------------------------------------------------------
    TAPRecord = S_MATFile.S_TAPVAR.TAPRecord;
    Tilt      = S_MATFile.S_TAPVAR.Tilt;
    Depth     = S_MATFile.S_TAPVAR.Depth;
    
    % Update penetration LOG File
    % ----------------------------
    
    PrintStatus(LogFileId, ['TAP file ' TAPFileName, 'read ...'], 2)
    
    PrintStatus(ProgramLogId, '-- Reading in TAP file',2)
    
    % Apply tilt correction --- CURRENT SLUGHEAT15 DOES THIS - NOT SURE IF
    % NEEDED
    % Apply tilt correction
    % ---------------------
    
    if mean(Tilt) > 50
        PrintStatus(LogFileId,'Mean Tilt too high: No Tilt correction applied !',2);
        PrintStatus(ResFileId,'Mean Tilt too high: No Tilt correction applied !',2);
    else
        SensorDistance = SensorDistance * cos(mean(Tilt,'omitnan')*pi/180);
        PrintStatus(LogFileId,'Applying tilt correction ...',1);
        PrintStatus(LogFileId,['Mean tilt is now :      ' num2str(mean(Tilt),'%1.1f') ' degrees.'],1); 
        PrintStatus(LogFileId,['Inter-Sensor distance : ' num2str(SensorDistance,'%1.3f') ' m.'],2);

        PrintStatus(ResFileId,'Applying tilt correction ...',1);
        PrintStatus(ResFileId,['Mean tilt is now :      ' num2str(mean(Tilt),'%1.1f') ' degrees.'],1); 
        PrintStatus(ResFileId,['Inter-Sensor distance : ' num2str(SensorDistance,'%1.3f') ' m.'],2);
    end   