%%% ==============================================================================
%   Purpose: 
%     This function PRINTS results of frictional decay processing to LOG and RES files
%%% ==============================================================================

function PrintHeatPulseResults(NumberOfSensors, ...
    IgnoredSensors, PulseTime, NumberOfUsedPoints, MeankPointAtMinkDiff, ...
    kError, TempAtInf, MinimumPulseDelays, kSlopeAtMinkDiff, ...
    MeankPointAtZeroInfTemp, MeankPointAtMinRMS, kSlopeAtMinRMS, ...
    kSlopeAtZeroInfTemp, Iteration, kChange, LogFileId, SensorsToUse)


% Organize frictional results
% ----------------------------
NumberOfSensorsUsed = length(SensorsToUse);

    a = SensorsToUse';
    b = repmat(length(PulseTime),NumberOfSensorsUsed,1);
    c = repmat(NumberOfUsedPoints,NumberOfSensorsUsed,1);
    d = MeankPointAtMinkDiff(SensorsToUse);
    e = kError(SensorsToUse);
    f = TempAtInf(SensorsToUse);
    g = MinimumPulseDelays(SensorsToUse);
    h = kSlopeAtMinkDiff(SensorsToUse);
    i = MeankPointAtZeroInfTemp(SensorsToUse);
    j = MeankPointAtMinRMS(SensorsToUse);
    k = kSlopeAtMinRMS(SensorsToUse);
    l = kSlopeAtZeroInfTemp(SensorsToUse);

    HeatPulseResults = [a b c d e f g h i j k l]';

fprintf(LogFileId,'%s\n',' ');
fprintf(LogFileId,'%s',['Heat Pulse Decay - Iteration ' num2str(Iteration,'%02d')]);
if Iteration > 1
    
    fprintf(LogFileId,'%s',[' - Total change in conductivity: ' num2str(kChange,'%+4.1e')]);
    fprintf(LogFileId,'\n%s\n\n', ...
        '========================================================================');
else
    fprintf(LogFileId,'\n%s\n\n', ...
        '===============================');   
end
fprintf(LogFileId,'%s\n', ...
    'Sensor  Data Points   kPtHF97    Error    T@Inf   Delay   kSlpHF97   kPt@0Tinf  kPt@minRMS  kSlp@minRMS  kSlp@0Tinf');
fprintf(LogFileId,'%s\n', ...
    '        Tot. / Used  (W/deg/m)   (95%)    (deg)   (sec)   (W/deg/m)  (W/deg/m)  (W/deg/m)    (W/deg/m)   (W/deg/m)');
fprintf(LogFileId,'%s\n\n', ...
    '------  -----------  ---------  -------  -------  -----  ----------  ---------  ----------  -----------  ----------');
fprintf(LogFileId, ...
    '%4i %7d / %2d %11.6f %9.1e %8.5f %5d %11.6f %11.6f %11.6f %11.6f %11.6f\n',HeatPulseResults);
fprintf(LogFileId,'\n%s\n\n\n', ...
    '-------------------------------------------------------------------------------------------------------------------');