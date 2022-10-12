function [TAPRecord, ...
         Tilt, Depth ...
         ] = ReadTAPText(LogFileId, ProgramLogId, ...
         ResFileId, TAPName, SensorDistance, DepthMean, TiltMean)

   if exist([TAPName '.tap'],'file')
        dummy = load([TAPName '.tap']);
        TAPRecord = dummy(:,1);
        Tilt = dummy(:,2);
        Depth = dummy(:,3);
        PrintStatus(LogFileId,['TAP file ' [TAPName '.tap'] ' read ...'],2);    
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

        % Update penetration LOG File
        % ----------------------------
    
        PrintStatus(LogFileId, ['TAP file ' TAPName '.tap', 'read ...'], 2)
    
        PrintStatus(ProgramLogId, '-- Reading in TAP file',2)
    elseif exist([TAPName '.TAP'],'file')
        dummy = load([TAPName '.TAP']);
        TAPRecord = dummy(:,1);
        Tilt = dummy(:,2);
        Depth = dummy(:,3);
        PrintStatus(LogFileId,['TAP file ' [TAPName '.TAP'] ' read ...'],2);  
    else
        TAPRecord = [];
        PrintStatus(LogFileId,'TAP file not found ...',1);
        PrintStatus(LogFileId,['TAP data read in PEN file: Tilt = ' num2str(TiltMean,'%1.1f') ...
                ' deg - Depth = ' num2str(DepthMean,'%1.1f') ' m ...'],2);

        Tilt = [];
        Depth = [];
   end
    