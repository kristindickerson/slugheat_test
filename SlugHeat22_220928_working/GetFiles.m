%%% ==============================================================================
% 	Purpose: 
%	This function creates these OUPUT files:
%       1. Log (.log) file -- logs the individual penetration's information
%       and progress (this is different from SlugHeat22.log which was
%       created at the start up of the application and records the entire
%       progam's progress)
%       2. Results (.res) file -- records all results of processing 
%   This function also gets these INPUT files:
%		1. Penetration (.pen) file -- datafile created by SlugPen prior to running SlugHeat.
% 		   This is the parsed data from each penetration needed to be processed by SlugHeat.
%       2. Temperature and pressure (.tap) file -- datafile created by 
%          SlugPen prior to running SlugHeat.
%%% ==============================================================================

function 	[PenFileName, PenFilePath, PenFile, ...
			TAPName, TAPFileName, TAPFile, ...
            MATFileName, MATFile, ...
			LogFileName, LogFile, ...
			ResFileName, ResFile, ...
            ResFileId, LogFileId ...
            ] = GetFiles(Version, Update, ...
			NumberOfColumns, ...
			CurrentPath, CurrentDateTime, ParFile, NumberOfSensors, ...
            TimeScalingFactor, ...
            SensorRadius, ...
            SensorDistance, ...
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
            TopSensorDepth, ProgramLogId)

	
 	
% ====================================================================
% Get penetration (PEN) file. Create variables for names and paths of
% temp & pressure (TAP), mat (MAT), results (RES), and log (LOG) files
% -- all have same name as PEN file.
% ====================================================================

    PenFilePath = [CurrentPath, '/PenetrationFiles/'];

	% Penetration (PEN) file name and path
	% ---------------------------------------------
    PrintStatus(ProgramLogId, ' -- Finding penetration file from SlugPen...',1);
    
	[PenFileName, PenFilePath] = uigetfile( ...
		[PenFilePath '*.pen'], ...
		'Select penetration file');

	PenFile = [PenFilePath PenFileName];

	PrintStatus(ProgramLogId, ['Penetration file: ' PenFile],2);

   
	% Results (RES), Log (LOG), Temperature & Pressure (TAP), and Variables from SlugPen workspace MAT files name and path
	% -------------------------------------------------------------------------------------------------------------------
	extInd = find(PenFileName == '.');
	FileName = PenFileName(1:extInd-1);
	clear extInd;

	TAPName = FileName;
    TAPFileName = [FileName '.tap'];
    MATFileName = [FileName '.mat'];
	ResFileName = [FileName '.res'];
	LogFileName = [FileName '.log'];
	
    TAPFile = [PenFilePath TAPFileName];
    MATFile = [PenFilePath MATFileName];
    ResFile = [CurrentPath ResFileName];
	LogFile = [CurrentPath LogFileName];

    % Temperature and pressure (TAP) file name and path
    % ---------------------------------------------
    PrintStatus(ProgramLogId, ' -- Finding tap file from SlugPen...',1);

	PrintStatus(ProgramLogId, ['TAP file: ' TAPFile],2);

   % Workspace variables MAT file name and path
    % ---------------------------------------------
    PrintStatus(ProgramLogId, ' -- Finding mat file from SlugPen...',1);

	PrintStatus(ProgramLogId, ['MAT file: ' MATFile],2);

% ================================================
% Print Header to penetration LOG and RES files
% ================================================
	
	LogFileId = fopen(LogFile,'w');
	ResFileId = fopen(ResFile,'w');
	NC = NumberOfColumns;
	
	% RES file
	% --------
	
	Id = ResFileId;
	
	fprintf(Id,'%s\n',repmat('=',1,NC));
	fprintf(Id,'%s\n',repmat('=',1,NC));
	fprintf(Id,'%s\n',['===' repmat(' ',1,NC-6) '===']);
	fprintf(Id,'%s\n',['===       SlugHeat  -  Version: ' Version ...
	        '  -  Update: ' Update '                         ===']);
	fprintf(Id,'%s\n',['===' repmat(' ',1,NC-6) '===']);
	fprintf(Id,'%s\n',repmat('=',1,NC));
	fprintf(Id,'%s\n\n\n',repmat('=',1,NC));
	
	l1 = length(['RESULTS FILE: ' ResFile]);
	l2 = length(['Processed: ' CurrentDateTime]);
	
	x1 = fix((NC-l1)/2);
	x2 = fix((NC-l2)/2);
	x0 = min(x1,x2)-4;
	l = max(l1,l2)+8;
	tl1 = fix((l-l1-4)/2);
	tr1 = l-tl1-l1-4;
	tl2 = fix((l-l2-4)/2);
	tr2 = l-tl2-l2-4;
	
	fprintf(Id,'%s\n',[repmat(' ',1,x0) repmat('-',1,l)]);
	fprintf(Id,'%s\n',[repmat(' ',1,x0) '--' repmat(' ',1,l-4)  '--']);
	fprintf(Id,'%s\n',[repmat(' ',1,x0) '--' repmat(' ',1,tl1) ...
	        'RESULTS FILE: ' ResFile repmat(' ',1,tr1) '--']);
	fprintf(Id,'%s\n',[repmat(' ',1,x0) '--' repmat(' ',1,l-4)  '--']);
	fprintf(Id,'%s\n',[repmat(' ',1,x0) '--' repmat(' ',1,tl2) ...
	        'Processed: ' CurrentDateTime repmat(' ',1,tr2) '--']);
	fprintf(Id,'%s\n',[repmat(' ',1,x0) '--' repmat(' ',1,l-4)  '--']);
	fprintf(Id,'%s\n\n\n\n',[repmat(' ',1,x0) repmat('-',1,l)]);
	
	String = ['Penetration file:  ' PenFile];
	fprintf(Id,'%s\n\n',[repmat(' ',1,fix((NC-length(String))/2)) String]);
	String = ['Parameter file (*):  ' ParFile];
	fprintf(Id,'%s\n\n',[repmat(' ',1,fix((NC-length(String))/2)) String]);
	String = ['Log file: ' LogFile];
	fprintf(Id,'%s\n\n\n',[repmat(' ',1,fix((NC-length(String))/2)) String]);
	
	
	fprintf(Id,'%s\n\n\n','(*) File SlugHeat22.par found in the working directory !');

	% LOG file
	% --------
	
	Id = LogFileId;
	
	fprintf(Id,'%s\n',repmat('=',1,NC));
	fprintf(Id,'%s\n',repmat('=',1,NC));
	fprintf(Id,'%s\n',['===' repmat(' ',1,NC-6) '===']);
	fprintf(Id,'%s\n',['===       SlugHeat  -  Version: ' Version ...
	        '  -  Update: ' Update '                         ===']);
	fprintf(Id,'%s\n',['===' repmat(' ',1,NC-6) '===']);
	fprintf(Id,'%s\n',repmat('=',1,NC));
	fprintf(Id,'%s\n\n\n',repmat('=',1,NC));
	
	l1 = length(['LOG FILE: ' LogFile]);
	l2 = length(['Processed: ' CurrentDateTime]);
	
	x1 = fix((NC-l1)/2);
	x2 = fix((NC-l2)/2);
	x0 = min(x1,x2)-4;
	l = max(l1,l2)+8;
	tl1 = fix((l-l1-4)/2);
	tr1 = l-tl1-l1-4;
	tl2 = fix((l-l2-4)/2);
	tr2 = l-tl2-l2-4;
	
	fprintf(Id,'%s\n',[repmat(' ',1,x0) repmat('-',1,l)]);
	fprintf(Id,'%s\n',[repmat(' ',1,x0) '--' repmat(' ',1,l-4)  '--']);
	fprintf(Id,'%s\n',[repmat(' ',1,x0) '--' repmat(' ',1,tl1) ...
	        'LOG FILE: ' LogFile repmat(' ',1,tr1) '--']);
	fprintf(Id,'%s\n',[repmat(' ',1,x0) '--' repmat(' ',1,l-4)  '--']);
	fprintf(Id,'%s\n',[repmat(' ',1,x0) '--' repmat(' ',1,tl2) ...
	        'Processed: ' CurrentDateTime repmat(' ',1,tr2) '--']);
	fprintf(Id,'%s\n',[repmat(' ',1,x0) '--' repmat(' ',1,l-4)  '--']);
	fprintf(Id,'%s\n\n\n\n',[repmat(' ',1,x0) repmat('-',1,l)]);
	
	String = ['Penetration file:  ' PenFile];
	fprintf(Id,'%s\n\n',[repmat(' ',1,fix((NC-length(String))/2)) String]);
	String = ['Parameter file (*):  ' ParFile];
	fprintf(Id,'%s\n\n',[repmat(' ',1,fix((NC-length(String))/2)) String]);
	String = ['Res file: ' ResFile];
	fprintf(Id,'%s\n\n\n',[repmat(' ',1,fix((NC-length(String))/2)) String]);
	
	
	fprintf(Id,'%s\n\n\n','(*) File SlugHeat22.par found in the working directory !');
	
	
	fprintf(Id,'%s\n',repmat('=',1,NC-30));
	fprintf(Id,'%s\n','BEGIN LOG FILE');
	fprintf(Id,'%s\n\n',repmat('=',1,NC-30));

	
	ProgramLogId = fopen('SlugHeat22.log');
	InitialLog = fread(ProgramLogId);
	fprintf(Id,'%s',InitialLog);
	

% ==========================================================================
%             Printing parameters to LOG file and RESULTS files
% ==========================================================================


  % Results (RES) file
  % ---------------------------------

  Id = ResFileId;

  String = 'PARAMETERS READ IN PAR FILE';
  fprintf(Id,'%s\n',[repmat(' ',1,fix((NC-length(String))/2)) ...
           repmat('-',1,length(String))]);
  fprintf(Id,'%s\n',[repmat(' ',1,fix((NC-length(String))/2)) String]);
  fprintf(Id,'%s\n\n\n',[repmat(' ',1,fix((NC-length(String))/2)) ...
           repmat('-',1,length(String))]);

  fprintf(Id,'%s\t\t%02d\n','Number Of Sensors:',NumberOfSensors);
  fprintf(Id,'%s\t%1.1f\n','Time Scaling Factor (s):',TimeScalingFactor);
  fprintf(Id,'%s\t\t%1.2e\n','Sensor Radius (m):',SensorRadius);
  fprintf(Id,'%s\t%1.2f\n','Inter-sensor spacing (m):',SensorDistance);
  fprintf(Id,'\n%s\n\n','Calibration Coefficients ( T = 1000*[a.x^2 + b.x + c] degC ):');
  Dim = size(CalibrationCoeffs);
  fprintf(Id,['  a: ' repmat('%1.1f  ',1,Dim(2)) '\n'],CalibrationCoeffs(1,:));
  fprintf(Id,['  b: ' repmat('%1.1f  ',1,Dim(2)) '\n'],CalibrationCoeffs(2,:));
  fprintf(Id,['  c: ' repmat('%1.1f  ',1,Dim(2)) '\n'],CalibrationCoeffs(3,:));
  fprintf(Id,'\n%s\n\n','Hyndman Coefficients ( Kappa = k/[a - b.k + c.k^2] 10^-6 m^2/s ):');
  fprintf(Id,'  a: %1.3f\n',HyndmanCoeffs(1));
  fprintf(Id,'  b: %1.3f\n',HyndmanCoeffs(2));
  fprintf(Id,'  c: %1.3f\n',HyndmanCoeffs(3));
  fprintf(Id,'\n%s\n\n','Initial Frictional Delays (s):');
  fprintf(Id,['  ' repmat('%1.1f  ',1,length(FrictionalDelays)) '\n'],FrictionalDelays);
  fprintf(Id,'\n%s\t%d\n','Time Shift Increment (s):  ',TimeInc);
  fprintf(Id,'%s\t%d\n','Maximum Frictional Step:  ',FricMaxStep);
  fprintf(Id,'%s\t%1.1f\n','Minimum Frictional Tau:  ',FricTauMin);
  fprintf(Id,'%s\t%1.1f\n','Maximum Fricional Tau:  ',FricTauMax);
  fprintf(Id,'\n%s\n\n','Assumed Initial Conductivities (W/m/degC):  ');
  if kInit(1) == 99
      fprintf(Id,'  k(z) =');
      if kInit(2)~=0; fprintf(Id,' %+1.3f',kInit(2)); end
      if kInit(3)~=0; fprintf(Id,' %+1.3fz',kInit(3)); end 
      if kInit(4)~=0; fprintf(Id,' %+1.3fz^2',kInit(4)); end
      if kInit(5)~=0; fprintf(Id,' %+1.3fexp(%+1.3fz)',kInit(5:6)); end
      if kInit(7)~=0; fprintf(Id,' %+1.3flog10(z)',kInit(7)); end
      fprintf(Id,'\n');
  else
      fprintf(Id,['  ' repmat('%1.2f  ',1,length(kInit)) '\n'],kInit);
  end
  fprintf(Id,'\n%s\n\n','Initial Heat Pulse Delays (s):');
  fprintf(Id,['  ' repmat('%1.1f  ',1,length(PulseDelays)) '\n'],PulseDelays);
  fprintf(Id,'\n%s\t%1.1f\n','Time Shift Increment (s): ',TimeShiftInc);
  fprintf(Id,'%s\t%d\n','Maximum Heat Pulse Step:  ',PulseMaxStep);
  fprintf(Id,'%s\t%1.1f\n','Minimum Heat Pulse Tau:  ',PulseTauMin);
  fprintf(Id,'%s\t%1.1f\n','Maximum Heat Pulse Tau:  ',PulseTauMax);
  fprintf(Id,'%s\t%1.1f\n','Heat Pulse Power (J/m):  ',PulsePower);
  fprintf(Id,'%s\t%1.1f\n','Heat Pulse Length (s):  ',HeatPulseLength);
  fprintf(Id,'%s\t%1.1f\n','Tolerance on k (degC):  ',kTolerance);

  %%% New parameters added by KD %%%
  fprintf(Id,'%s\t%1.1f\n','Minimum change of Sigma(k):  ',MinTotalkChange);
  fprintf(Id,'%s\t%1.1f\n','Maximum number of iterations for k computations:  ',MaxNumberOfIterations);
  fprintf(Id,'%s\t%1.1f\n','Number of Iterations for Sensitivity analysis:  ',MaxSAIterations );
  fprintf(Id,'%s\t%1.1f\n','Standard deviation in thermal conductivity for Sensitivity analysis:  ',Sigmak0 );
  fprintf(Id,'%s\t%1.1f\n','Minimum thermal conductivity cutoff for Sensitivity analysis:  ',kMin);
  fprintf(Id,'%s\t%1.1f\n','Maximum thermal conductivity cutoff for Sensitivity analysis:  ',kMax);
  fprintf(Id,'%s\t%1.1f\n','Mininum layer thickness for Sensitivity analysis:  ',MinThickness);
  fprintf(Id,'%s\t%1.1f\n','Use Frictional decay for No Heat pulse Sensitivity analysis ?:  ',UseFrictional);
  fprintf(Id,'%s\t%1.1f\n','Horizontal thermal conductivity Anisotropy:  ',kAnisotropy);
  fprintf(Id,'%s\t%1.3f\n\n\n','Depth of first thermistor below weight stand:  ',TopSensorDepth); 


  % LOG file
  % ------------------------

  Id = LogFileId;
  
  String = 'PARAMETERS READ IN PAR FILE';
  fprintf(Id,'\n%s\n',[repmat(' ',1,fix((NC-length(String))/2)) ...
          repmat('-',1,length(String))]);
  fprintf(Id,'%s\n',[repmat(' ',1,fix((NC-length(String))/2)) String]);
  fprintf(Id,'%s\n\n\n',[repmat(' ',1,fix((NC-length(String))/2)) ...
          repmat('-',1,length(String))]);
  
  fprintf(Id,'%s\t\t%02d\n','Number Of Sensors:',NumberOfSensors);
  fprintf(Id,'%s\t%1.1f\n','Time Scaling Factor (s):',TimeScalingFactor);
  fprintf(Id,'%s\t\t%1.2e\n','Sensor Radius (m):',SensorRadius);
  fprintf(Id,'%s\t%1.2f\n','Inter-sensor spacing (m):',SensorDistance);
  fprintf(Id,'\n%s\n\n','Calibration Coefficients ( T = 1000*[a.x^2 + b.x + c] degC ):');
  Dim = size(CalibrationCoeffs);
  fprintf(Id,['  a: ' repmat('%1.1f  ',1,Dim(2)) '\n'],CalibrationCoeffs(1,:));
  fprintf(Id,['  b: ' repmat('%1.1f  ',1,Dim(2)) '\n'],CalibrationCoeffs(2,:));
  fprintf(Id,['  c: ' repmat('%1.1f  ',1,Dim(2)) '\n'],CalibrationCoeffs(3,:));
  fprintf(Id,'\n%s\n\n','Hyndman Coefficients ( Kappa = k/[a - b.k + c.k^2] 10^-6 m2 s-1 ):');
  fprintf(Id,'  a: %1.3f\n',HyndmanCoeffs(1));
  fprintf(Id,'  b: %1.3f\n',HyndmanCoeffs(2));
  fprintf(Id,'  c: %1.3f\n',HyndmanCoeffs(3));
  fprintf(Id,'\n%s\n\n','Initial Frictional Delays (s):');
  fprintf(Id,['  ' repmat('%1.1f  ',1,length(FrictionalDelays)) '\n'],FrictionalDelays);
  fprintf(Id,'\n%s\t%d\n','Time Shift Increment (s):  ',TimeInc);
  fprintf(Id,'%s\t%d\n','Maximum Frictional Step:  ',FricMaxStep);
  fprintf(Id,'%s\t%1.1f\n','Minimum Frictional Tau:  ',FricTauMin);
  fprintf(Id,'%s\t%1.1f\n','Maximum Fricional Tau:  ',FricTauMax);
  fprintf(Id,'\n%s\n\n','Assumed Initial Conductivities (W/m/degC):  ');
  if kInit(1) == 99
      fprintf(Id,'  k(z) =');
      if kInit(2)~=0; fprintf(Id,' %+1.3f',kInit(2)); end
      if kInit(3)~=0; fprintf(Id,' %+1.3fz',kInit(3)); end 
      if kInit(4)~=0; fprintf(Id,' %+1.3fz^2',kInit(4)); end
      if kInit(5)~=0; fprintf(Id,' %+1.3fexp(%+1.3fz)',kInit(5:6)); end
      if kInit(7)~=0; fprintf(Id,' %+1.3flog10(z)',kInit(7)); end
      fprintf(Id,'\n');
  else
      fprintf(Id,['  ' repmat('%1.2f  ',1,length(kInit)) '\n'],kInit);
  end
  fprintf(Id,'\n%s\n\n','Initial Heat Pulse Delays (s):');
  fprintf(Id,['  ' repmat('%1.1f  ',1,length(PulseDelays)) '\n'],PulseDelays);
  fprintf(Id,'\n%s\t%1.1f\n','Time Shift Increment (s): ',TimeShiftInc);
  fprintf(Id,'%s\t%d\n','Maximum Heat Pulse Step:  ',PulseMaxStep);
  fprintf(Id,'%s\t%1.1f\n','Minimum Heat Pulse Tau:  ',PulseTauMin);
  fprintf(Id,'%s\t%1.1f\n','Maximum Heat Pulse Tau:  ',PulseTauMax);
  fprintf(Id,'%s\t%1.1f\n','Heat Pulse Power (J/m):  ',PulsePower);
  fprintf(Id,'%s\t%1.1f\n','Heat Pulse Length (s):  ',HeatPulseLength);
  fprintf(Id,'%s\t%1.1f\n','Tolerance on k (degC):  ',kTolerance);
  
    %%% New parameters added by KD %%%
    fprintf(Id,'%s\t%1.1f\n','Minimum change of Sigma(k):  ',MinTotalkChange);
    fprintf(Id,'%s\t%1.1f\n','Maximum number of iterations for k computations:  ',MaxNumberOfIterations);
    fprintf(Id,'%s\t%1.1f\n','Number of Iterations for Sensitivity analysis:  ',MaxSAIterations );
    fprintf(Id,'%s\t%1.1f\n','Standard deviation in thermal conductivity for Sensitivity analysis:  ',Sigmak0 );
    fprintf(Id,'%s\t%1.1f\n','Minimum thermal conductivity cutoff for Sensitivity analysis:  ',kMin);
    fprintf(Id,'%s\t%1.1f\n','Maximum thermal conductivity cutoff for Sensitivity analysis:  ',kMax);
    fprintf(Id,'%s\t%1.1f\n','Mininum layer thickness for Sensitivity analysis:  ',MinThickness);
    fprintf(Id,'%s\t%1.1f\n','Use Frictional decay for No Heat pulse Sensitivity analysis ?:  ',UseFrictional);
    fprintf(Id,'%s\t%1.1f\n','Horizontal thermal conductivity Anisotropy:  ',kAnisotropy);
    fprintf(Id,'%s\t%1.3f\n\n\n','Depth of first thermistor below weight stand:  ',TopSensorDepth); 
  


% ==========================================================================
%             Update SlugHeat22 Log file
% ==========================================================================

PrintStatus(ProgramLogId, ' -- Reading in parameters from parameter file...',1);
