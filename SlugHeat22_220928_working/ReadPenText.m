
function    [StationName, ...
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
            ] = ReadPenText(PenFile, figure_Main, WaterThermistor)
% Opens the 'PEN' file

    fid = fopen(PenFile);
    
    % Reads header and preliminary data
    
    fseek(fid,1,'cof');
    % MH SlugHeat15 EDIT Rewind
    frewind(fid);
    StationName = fscanf(fid,'%d',1);
    Penetration = fscanf(fid,'%d',1);
    
    fseek(fid,0,'bof');
    Lookup = setstr(fread(fid,255));
    Quotes = find(Lookup=='''');
    fseek(fid,Quotes(1),'bof');
    CruiseName = fscanf(fid,'%c',Quotes(2)-Quotes(1)-1);
    
    fseek(fid,1,'cof');
    Latitude = fscanf(fid,'%f',1);
    Longitude = fscanf(fid,'%f',1);
    DepthMean = fscanf(fid,'%d',1);
    TiltMean = fscanf(fid,'%f',1);
    LoggerId = fscanf(fid,'%d',1);
    ProbeId = fscanf(fid,'%d',1);
    NumberOfSensors = fscanf(fid,'%d',1);
    PenetrationRecord = fscanf(fid,'%d',1);
    HeatPulseRecord = fscanf(fid,'%d',1);
    % MH ADDED EQM START AND END RECORDS
    EqmStartRecord  = fscanf(fid,'%d',1);
    EqmEndRecord    = fscanf(fid,'%d',1);
    %MH SlugHeat15 changed from %g to %f format to accommodate NANs
    Format = repmat('%f ',1,NumberOfSensors);
    Format = [Format '%f'];
    BottomWaterRawData = fscanf(fid,Format, ...
        NumberOfSensors+1)';
    RawRead = fscanf(fid,['%f ' Format],inf);
    l = length(RawRead);
    
    % MH 9.3.17 : reshape returns error if RawRead does not have
    % (NumberOfSensors2+2) * l/(NumberOfSensors2+2) Elements
    
    RawRead = reshape(RawRead, ...
        (NumberOfSensors+2), ...
        l/(NumberOfSensors+2))';
    
    AllRecords = RawRead(:,1);
    EndRecord = AllRecords(end);
    AllSensorsRawData = RawRead(:,2:end);
    
    WaterSensorRawData = RawRead(:,end);

    Datum = CruiseName;
    
    fclose(fid);
    
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