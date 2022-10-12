%%% ==============================================================================
%   Purpose: 
%     This function computes the frictional decay reduction...
%%% ==============================================================================

function [NumberOfFricUsedPoints, ...
        MinimumFricEqTemp, ...
        MinimumFricError, ...
        MinimumFricDelays, ...
        MinimumFricSlope, ...
        HPTooLow, ...
        ShiftedTime, ...
        IndexOfMinimums, ...
        DataTemp, ...
        TimeShifts, ...
        ShiftedTau, ...
        DataFAT, ...
        DataLimits, ...
        b, ...
        a, ...
        RMS ...
        ] = FrictionalDecay( ...
        figure_Main, ...
        FricTime, ...
        FricTemp, ...
        NumberOfSensors, ...
        FrictionalDelays, ...
        FricMaxStep, ...
        TimeInc, ...
        Currentk, ...
        HyndmanCoeffs, ...
        SensorRadius, ...
        FricTauMin, ...
        FricTauMax, ...
        SensorsToUse, ...
        loading)

% ====================================== %
%               COMPUTE                  %
% ====================================== %

% Initialize processing
% ----------------------

load('SlugHeat22.mat', 'Tau00Data', 'FAT00')

%SensorsToUse = [1,2,3,4,5,6,7,8,9,10]; % KD added for testing

NumberOfSensorsUsed = length(SensorsToUse);

DataTime = repmat(FricTime,1,NumberOfSensorsUsed);
DataTemp = NaN*ones(size(FricTemp(:,SensorsToUse)));
HC = HyndmanCoeffs;
Kappa = 1e-6*Currentk(SensorsToUse)./(HC(1) ...
    - HC(2)*Currentk(SensorsToUse) ...
    + HC(3)*Currentk(SensorsToUse).^2);
Kappa = repmat(Kappa,length(FricTime),1);
%
% AF 9/02  If statement added to handle negative Kappa values. These are bogus
%          but they can be created if there are thermistors that don't penetrate,
%          and iteration using these values results in negative conductivities.
%          It would be ideal to modify this later so that negative k values are 
%          are trapped and reset to initial values. 
%
LowestK=min(min(Kappa));
if LowestK < 0
    close(loading)
    uialert(figure_Main, ['Error during iteration. Some thermistors may not have penetrated. ' ...
        'Must reload penetration file, then remove bad sensors from data and process again. '],'Negative conductivity detected!', 'Icon','warning')
    pause;
    clc;
    clf reset;
    close all hidden;
    clear variables;
    more off;
    echo off all;
    fclose('all');
    
end
%
DataTau = Kappa.*DataTime/SensorRadius.^2;
Tau00Index = 1:Tau00Data(3)/Tau00Data(2);

% Truncate Data to selected dimensionless time (Tau) window
% ------------------------------------------------------------

[i,j] = find(DataTau > FricTauMin & DataTau < FricTauMax);
DataTemp(i,j) = FricTemp(i,SensorsToUse(j)'); 

% Compute time shifts
% -------------------

TimeShifts = repmat(FrictionalDelays(SensorsToUse), [FricMaxStep 1]) ...
    + repmat(TimeInc*(1:FricMaxStep)', [1 NumberOfSensorsUsed]);

ShiftedTime = repmat(FrictionalDelays(SensorsToUse),[length(FricTime) 1 FricMaxStep]) ...
    + repmat(FricTime,[1 NumberOfSensorsUsed FricMaxStep]) ...
    + repmat(permute(TimeInc*(1:FricMaxStep),[3 1 2]),[length(FricTime) NumberOfSensorsUsed 1]);

% Compute dimensionless time (Tau) Data
% ---------------------------------------

KappaMatrix = repmat(Kappa,[1 1 FricMaxStep]);
ShiftedTau = KappaMatrix.*ShiftedTime/SensorRadius^2;
ShiftedTauIndex = round(ShiftedTau/Tau00Data(2));

ShiftedTauIndex(ShiftedTauIndex > Tau00Data(3)/Tau00Data(2)) = length(FAT00) + 1;
ShiftedTauIndex(ShiftedTauIndex < 1) = length(FAT00) + 2;
FAT00(end+1) = 9;   
FAT00(end+1) = NaN; 

DataFAT = FAT00(ShiftedTauIndex);
iDF = find(DataFAT>8);
DataFAT(iDF) = 1./(4*ShiftedTau(iDF))-1./(8*ShiftedTau(iDF).^2);
DataTemp = repmat(DataTemp,[1 1 FricMaxStep]);

% Compute chi-square fits
% -----------------------

[ix,jx] = find(~isnan(DataFAT));
[iy,jy] = find(~isnan(DataTemp));

DataLimits = [max([min(ix) min(iy)]) min([max(ix) max(iy)])];
NumberOfFricUsedPoints = 1+diff(DataLimits);
clear ix iy jx jy

X = reshape(DataFAT(DataLimits(1):DataLimits(2),:,:), ...
    [NumberOfFricUsedPoints NumberOfSensorsUsed*FricMaxStep]);
Y = reshape(DataTemp(DataLimits(1):DataLimits(2),:,:), ...
    [NumberOfFricUsedPoints NumberOfSensorsUsed*FricMaxStep]);

clear ix jx iy jy
[a,b,Sigmaa,Sigmab,Chi2] = ChiSquaredFit(X,Y);
clear X Y

a = reshape(a,[NumberOfSensorsUsed FricMaxStep]);
b = reshape(b,[NumberOfSensorsUsed FricMaxStep]);
Sigmaa = reshape(Sigmaa,[NumberOfSensorsUsed FricMaxStep]);
Sigmab = reshape(Sigmab,[NumberOfSensorsUsed FricMaxStep]);

Chi2 = reshape(Chi2,[NumberOfSensorsUsed FricMaxStep]);
RMS = sqrt(Chi2/(NumberOfFricUsedPoints/2));

% Compute Errors and Standard deviation
% -------------------------------------

MinimumFricError = NaN*ones(NumberOfSensors,1);
MinimumFricDelays = NaN*ones(NumberOfSensors,1);
MinimumFricEqTemp = NaN*ones(NumberOfSensors,1);
MinimumFricSlope = NaN*ones(NumberOfSensors,1);

[Minimums,IndexOfMinimums] = min(2*RMS,[],2);
MinimumFricError(SensorsToUse) = Minimums;
MinimumFricDelays(SensorsToUse) = diag(TimeShifts(IndexOfMinimums,:));    
MinimumFricEqTemp(SensorsToUse) = diag(a(:,IndexOfMinimums));
MinimumFricSlope(SensorsToUse) = diag(b(:,IndexOfMinimums));


if any(all(isnan(DataTemp)))
    uialert(figure_Main, ['Error: heat pulse power too low. Must raise power ' ...
        'or ignore heat pulse reduction.'], 'HEAT PULSE POWER TOO LOW', 'Icon','error');
    HPTooLow = 1;
    return
else
    HPTooLow = 0;
end   
