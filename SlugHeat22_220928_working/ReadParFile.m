%%% ====================================================================================
%   Purpose: 
%     This function READS in the parameters from .par file and .cal file: 	
%       1. Parameter (.par) file -- defines the default parameters to run program. This 
%		   should be updated by the user before running SlugHeat. 
%       3. Calibration (.cal) file -- this defines what type of water calibration type is
%		   to be used to calibrate bottom water temperatures.
% 
%     ** Note on parameters text file: KD added serveral parameters that were hard 
%     coded in SlugHeat15, but now are found in ParFile. Next, parameters are logged
%     in Log file and Results file. Reading in and printing parameters were separate  
%     subroutines in SlugHeat15, but I have combined them to one function here.
%%% ====================================================================================


function  [NumberOfSensors, ...	
        WaterThermistor, ...
        TimeScalingFactor, ...
        DeltaTime, ...
        SensorRadius, ...
        SensorDistance, ...
        TempError, ...
        CalibrationCoeffs, ...
        HyndmanCoeffs, ...
        FrictionalDelays, ...
        FricMaxStep, ...
        TimeInc, ...
        FricTauMin, ...
        FricTauMax, ...
        PulseDelays, ...
        kInit, ...
        PulsePower, ...
        TimeShiftInit, ...
        TimeShiftInc, ...
        PulseMaxStep, ...
        kTolerance, ...
        PulseTauMin, ...
        PulseTauMax, ...
        HeatPulseLength, ...
        MinTotalkChange, ...
        MaxNumberOfIterations, ...
        MaxSAIterations, ...
        Sigmak0, ...
        kMin, ...
        kMax, ...
        MinThickness, ...
        UseFrictional, ...
        kAnisotropy, ...
        TopSensorDepth ...
        ] = ReadParFile(ParFile, ProgramLogId)

% Opens the parameter file
% --------------------------

fid = fopen(ParFile);

% Finds all Carriage Line Returns (ascii code = 10) 
% 		- KD: What is this?
% 			fread first reads in the entire binary file. --> fread(FID, SIZE, PRECISION)
%			fread(FID, inf) --> reads in all elements until the end of the file, default
%			precision is uint8=>uint8: reads in unsigned 8-bit integers and save them in an unsigned 8-bit integer array
% -------------------------------------------------

Lookup = fread(fid,inf);
CR = find(Lookup==10);

% ==============================================
%             Reading parameters
% ==============================================

% Line 1: Number of sensors
fseek(fid,0,'bof');
NumberOfSensors = fscanf(fid,'%d',1);

% Line 2: Is there a water thermistor ?
fseek(fid,CR(1)+1,'bof');
WaterThermistor = fscanf(fid,'%d',1);

% Line 3: Time scaling factor (sec/unit)
fseek(fid,CR(2)+1,'bof');
TimeScalingFactor = fscanf(fid,'%g',1);

% Line 4: Time between thermistor readings (sec)
fseek(fid,CR(3)+1,'bof');
DeltaTime = fscanf(fid,'%g',1);

% Line 5: Sensor radius (m)
fseek(fid,CR(4)+1,'bof');
SensorRadius = fscanf(fid,'%g',1);

% Line 6: Distance between sensors (m)
fseek(fid,CR(5)+1,'bof');
SensorDistance = fscanf(fid,'%g',1);

% Line 7: Assumed temperature error (K)
fseek(fid,CR(6)+1,'bof');
TempError = fscanf(fid,'%g',1);

% Line 8: Length of heat pulse (sec)
fseek(fid,CR(7)+1,'bof');
HeatPulseLength = fscanf(fid,'%g',1);

% Line 9, 10 & 11: Calibration coefficients
% Readings to milliKelvins

Format = repmat('%g,',1,NumberOfSensors);
Format = [Format '%g'];
fseek(fid,CR(9)+1,'bof');
qc = fscanf(fid,Format,NumberOfSensors+WaterThermistor)'; % quadratic coefficients
fseek(fid,CR(10)+1,'bof');
bb =  fscanf(fid,Format,NumberOfSensors+WaterThermistor)'; % readings to milliKelvins 
fseek(fid,CR(11)+1,'bof');
cc =  fscanf(fid,Format,NumberOfSensors+WaterThermistor)';

CalibrationCoeffs = [qc;bb;cc];

% Line 12: Hyndman Coefficients for k
fseek(fid,CR(12)+1,'bof');
HyndmanCoeffs = fscanf(fid,'%g %g %g',3)';

% Line 13: Frictional time delays (sec)
Format = repmat('%g ',1,NumberOfSensors);
Format = [Format '%g'];
fseek(fid,CR(13)+1,'bof');
FrictionalDelays = fscanf(fid,Format,NumberOfSensors)';

% Line 14: Maximum number of steps and Time
% increment in frictional delay calculation (sec)
fseek(fid,CR(14)+1,'bof');
FricMaxStep = fscanf(fid,'%g',1);
TimeInc = fscanf(fid,'%g',1);

% Line 15: Minimum and max Tau values used for the 
% frictional delay
fseek(fid,CR(15)+1,'bof');
FricTauMin = fscanf(fid,'%g',1);
FricTauMax = fscanf(fid,'%g',1);

% Line 16: Pulse time delays (sec)
fseek(fid,CR(16)+1,'bof');
PulseDelays = fscanf(fid,Format,NumberOfSensors)';

% Line 17: Initial Conductivities (W m/K)
fseek(fid,CR(17)+1,'bof');
ktype=fscanf(fid,Format,1);
fseek(fid,CR(17)+1,'bof');
if ktype == 99
  kInit = fscanf(fid,Format,7)';
else 
  kInit = fscanf(fid,Format,NumberOfSensors)';
end

% Line 18: Heat pulse power (J/m/s)
fseek(fid,CR(18)+1,'bof');
PulsePower = fscanf(fid,'%g',1);

% Line 19: Initial time shit & Increment (sec)
fseek(fid,CR(19)+1,'bof');
TimeShiftInit = fscanf(fid,'%g',1);
TimeShiftInc  = fscanf(fid,'%g',1);

% Line 20: Maximum iteration number & error
% tolerance on conductivity iteration
fseek(fid,CR(20)+1,'bof');
PulseMaxStep = fscanf(fid,'%g',1);
kTolerance = fscanf(fid,'%g',1);

% Line 21: Minimum and max Tau values used for the
% heat pulse delay
fseek(fid,CR(21)+1,'bof');
PulseTauMin = fscanf(fid,'%g',1);
PulseTauMax = fscanf(fid,'%g',1);



% KD: added these that were hard coded, now in the PAR file
% ---------------------------------------------------------
% Line 22: Minimum change of Sigma(k)
fseek(fid,CR(22)+1,'bof');
MinTotalkChange = fscanf(fid,'%g',1);

% Line 23: Maximum number of iterations for k computations
fseek(fid,CR(23)+1,'bof');
MaxNumberOfIterations = fscanf(fid,'%g',1);

% Line 24: Number of Iterations for Sensitivity analysis
fseek(fid,CR(24)+1,'bof');
MaxSAIterations = fscanf(fid,'%g',1);

% Line 25: Standard deviation in k for Sensitivity analysis
fseek(fid,CR(25)+1,'bof');
Sigmak0 = fscanf(fid,'%g',1);

% Line 26: Minimum thermal conductivity cutoff for Sensitivity analysis
fseek(fid,CR(26)+1,'bof');
kMin = fscanf(fid,'%g',1);

% Line 27: Maximum thermal conductivity cutoff for Sensitivity analysis
fseek(fid,CR(27)+1,'bof');
kMax = fscanf(fid,'%g',1);

% Line 28: Mininum layer thickness for Sensitivity analysis
fseek(fid,CR(28)+1,'bof');
MinThickness = fscanf(fid,'%g',1);

% Line 29: Use Frictional decay for No Heat pulse Sensitivity analysis ?
fseek(fid,CR(29)+1,'bof');
UseFrictional = fscanf(fid,'%g',1);

% Line 30: Horizontal thermal conductivity Anisotropy
fseek(fid,CR(30)+1,'bof');
kAnisotropy = fscanf(fid,'%g',1);

% Line 31: Depth of first thermistor below weight stand
%       1.86 = MH SlugHeat 15 6 m probe - 13 sensors with 11 active
%       0.25 = Traditional 3.5m probe - 11 sensors 
fseek(fid,CR(31)+1,'bof');
TopSensorDepth = fscanf(fid,'%g',1);

PrintStatus(ProgramLogId, '-- Reading in parameters from parameters file',2)


