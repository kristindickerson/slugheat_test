%%% ======================================================================
%   Purpose: 
%   This function removes any unchecked sensors from the data. This is NOT
%   only display. Whatever sensors are unchecked when this funciton is run
%   will NOT be included in further processing.
%%% ======================================================================

function [A, B, C, D, E, F, kInit, kFunction...
            ] = DiscardSensorsNoHP(AllSensors, ...
            kInit, PulseData, NumberOfSensors, SensorDistance, TopSensorDepth)
    % Define which sensors are to be ignored
    % ------------------------------------
        IgnoredSensors=zeros(size(AllSensors));
        IgnoredSensors(IgnoredSensors==0) = [];
        SensorsToUse = AllSensors;

        if ~PulseData    

            RelativeDepths = (repmat(NumberOfSensors,1,NumberOfSensors)-[1:NumberOfSensors]) ...
           * SensorDistance + TopSensorDepth;
       
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
                
            %else
                %Currentk = kInit;
            end   
        
        end