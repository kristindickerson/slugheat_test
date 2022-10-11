%%% ======================================================================
%   Purpose: 
%   This function reformats old heat flow .pen files that are missing
%   bottom water equilibrium start and end times.
%       Bottom water equilibrium start time: first record number
%       Bottom water equilibrium end time: penetration record number
%       - It seems like the bottom water temperature was chosen for
%       each of these .pen files before they were made. None of the measurements at
%       any record number correspond to the chosen bottom water temp.
%%% ======================================================================


function ReFormatOldPens

S = dir('**/*.pen');

for i = 1:numel(S)
   
    PenFileName = S(i).name;
    PenFile = fullfile(S(i).folder, S(i).name);

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

    EqmStartRecord = AllRecords(1);
    EqmEndRecord = PenetrationRecord;
    
    fclose(fid);


    % Write new pen file %
    % --------------------
    fido = fopen([PenFileName(1:end-4) '.edpen'],'wt');
        
    % Header
    fprintf(fido,'%4.0f %4.0f ''%s'' \n',StationName, Penetration, CruiseName);
    fprintf(fido,'%6.6f %6.6f %6.0f %6.2f \n', Latitude, Longitude, DepthMean, TiltMean);
    fprintf(fido,'%6.0f %6.0f %6.0f \n',LoggerId,ProbeId,NumberOfSensors);
    fprintf(fido,'%6.0f \n',PenetrationRecord);
    fprintf(fido,'%6.0f %6.0f %6.0f \n',HeatPulseRecord,EqmStartRecord,EqmEndRecord);
    
    % Ouptut Format for Bottom Water Data
    Fmt = '%6.1f ' ;
    FmtBW = repmat(Fmt,1,NumberOfSensors);
    FmtBW = ['%13.1f ', FmtBW, '\n'];
    
    % Bottom Water
    %fprintf(fido,FmtBW,BottomWaterRawData); % if you want to define the bottom water temp as the final temp recorded PRIOR to penetration
    fprintf(fido,FmtBW,BottomWaterRawData); % this is used IF you want to define bottom water temp as the END OF EQUILIBRIUM chosen graphically (alternate is BottomWaterRaw
    
  
    % Output Format for Thermistor Data
    Fmt = '%6.1f ';
    Fmt = repmat(Fmt,1,NumberOfSensors+1);
    Fmt = ['%6.0f ',Fmt, '\n'];
    
    % Thermistor Data 
    nrows = length(AllSensorsRawData);
    i=1;
    while i<=nrows
        fprintf(fido,Fmt,AllRecords(i),AllSensorsRawData(i,:));
        i=i+1;
    end
    fclose(fido);

    S_PenHandles = struct('CruiseName', CruiseName, 'StationName', StationName, ...
        'Penetration', Penetration, 'ProbeId', ProbeId, 'Datum', Datum, ...
        'LoggerId', LoggerId, 'NumberOfSensors', NumberOfSensors, ...
        'Latitude', Latitude, 'Longitude', Longitude, 'Tilt', TiltMean, ...
        'Depth', DepthMean);

    S_PENVAR = struct('BottomWaterRawData', BottomWaterRawData, 'AllRecords', AllRecords, ...
        'AllSensorsRawData', AllSensorsRawData, 'WaterSensorRawData', WaterSensorRawData, ...
        'PenetrationRecord', PenetrationRecord, 'HeatPulseRecord', HeatPulseRecord, ...
        'EndRecord', EndRecord, 'EqmStartRecord', EqmStartRecord, 'EqmEndRecord', EqmEndRecord);

    save(PenFileName(1:end-4))
end