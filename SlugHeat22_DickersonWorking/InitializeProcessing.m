%%% ==============================================================================
% 	Purpose: 
%	This function INITIALIZES the processing of the raw penetration data.
%%% ==============================================================================

function [A, B, C, D, E, F, kFunction, Currentk, CurrentT, TChange, kChange, Iteration, ...
    FirstIteration, TotalIterations, AnotherTrial, Trial, RelativeDepths ...
    ] = InitializeProcessing(NumberOfSensors, SensorDistance, TopSensorDepth, kInit, Trial)

%       Compute relative depths of sensors - Top sensor is defined in 
%       parameter file (Line 31)
%              - The depths of sensors are relative to 10 cm below surface 
%              in case of log in kInit function is specified. -
%       -----------------------------------------------------------------
          RelativeDepths = (repmat(NumberOfSensors,1,NumberOfSensors)- ...
              (1:NumberOfSensors))* SensorDistance + TopSensorDepth;
      
%       If an initial kInit(z) function exists, the first argument of kInit 
%       in the PAR file is then 99 and the next 6 are the coefficients of 
%       kInit(z)
          if kInit(1) == 99
              A = kInit(2);
              B = kInit(3);
              C = kInit(4);
              D = kInit(5);
              E = kInit(6);
              F = kInit(7);
              kInit = A ...
                  + B*RelativeDepths ...
                  + C*RelativeDepths.^2 ...
                  + D*exp(E*RelativeDepths) ...
                  + F*log10(RelativeDepths);      
              kFunction = 1;
          else    
              kFunction = 0;
          end

%        Initialize iterative process (independent upon whether or not a Heat Pulse exists)
%        ----------------------------------------------------------------------------------
            Currentk = kInit;
            CurrentT = NaN*ones(size(kInit));
            
            TChange = Inf;
            kChange = Inf;
    
%        Initialize Counters
%        -------------------
    
            Iteration = 1;
            Trial = Trial + 1;
            FirstIteration = 1;
            TotalIterations = 1;
            AnotherTrial = 1;
        

