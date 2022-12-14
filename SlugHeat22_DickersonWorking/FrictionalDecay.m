%%% ==============================================================================
%   Purpose: 
%     This function 
%%% ==============================================================================

function [NumberOfFricUsedPoints, ...
        MinimumFricEqTemp, ...
        MinimumFricError, ...
        MinimumFricDelays, ...
        MinimumFricSlope, ...
        h_axFricTempvTime, ...
        h_axFricTempvTau, ...
        h_axFricTempvTauPoints, ...
        h_axFricTempvTauLines, ...
        h_axFricRMSvTimeShift, ...
        h_axFricRMSvTimeShiftMinDelays,...
        HPTooLow] = FrictionalDecay( ...
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
        h_axTempAboveBWT, ...
        axes_TempvTime, ...
        axes_TempvTau, ...
        axes_TempvBullFunc,...
        axes_TimeShift, ...
        grid_FricDecayAxes, ...
        Iteration, ...
        ChosenIteration, ...
        Pause, ...
        PulseData, ...
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

if PulseData && Iteration == ChosenIteration || (PulseData && Iteration ~= ChosenIteration && Pause == 1) || ~PulseData

% ====================================== %
%                 PLOT                   %
% ====================================== %



% Reset all axes on frictional decay tab
% --------------------------------------
delete(axes_TempvTime.Children)
delete(axes_TempvTau.Children)
delete(axes_TempvBullFunc.Children)
delete(axes_TimeShift.Children)
grid_FricDecayAxes.RowHeight = {'1x', '1x'};
grid_FricDecayAxes.ColumnWidth = {'1x', '1x'};

axes_TempvTime.Color = [0.90 0.90 0.90];
axes_TempvTau.Color = [0.90 0.90 0.90];
axes_TempvBullFunc.Color = [0.90 0.90 0.90];
axes_TimeShift.Color = [0.90 0.90 0.90];

 % Plot Temperature vs. Time (s)
 % ------------------------------

 n=1;

 for i = SensorsToUse
     h_axFricTempvTime(i) = plot(axes_TempvTime, ShiftedTime(:,n,IndexOfMinimums(n)), ...
                DataTemp(:,n,IndexOfMinimums(n)),'-o','markersize',2, ...
        'Color',h_axTempAboveBWT(i).Color,'markerfacecolor',h_axTempAboveBWT(i).Color, 'tag', ['sensTemp_' num2str(i)]);
     hold(axes_TempvTime, 'on');
     n=n+1;
 end

      % Set labels and axes limits
      % --------------------------------------------------
        xlabel(axes_TempvTime, '\bfTime (s)','fontsize',16,'verticalalignment','top')
        ylabel(axes_TempvTime, '\bfTemperature ( ^oC)','fontsize',16,'verticalalignment','bottom')
        set(axes_TempvTime,'xlim',[FricTime(1)+min(min(TimeShifts)) ...
            FricTime(end)+max(max(TimeShifts))])

     % Lines indicating start and end of frictional decay
     % --------------------------------------------------
        xline(axes_TempvTime, FricTime(1), '--k', 'Label', 'Start of frictional decay', ...
         'FontSize',16, 'FontWeight', 'bold')
        xline(axes_TempvTime, FricTime(end), '--k', 'Label', 'End of frictional decay', ...
         'FontSize',16, 'FontWeight', 'bold')

 % Plot Temperature vs. Dimensionless Time (Tau)
 % ---------------------------------------------
    
 n=1;

  for i = SensorsToUse
     h_axFricTempvTau(i) = plot(axes_TempvTau, ShiftedTau(:,n,IndexOfMinimums(n)),...
         DataTemp(:,n,IndexOfMinimums(n)),'-o','markersize',2, ...
        'Color',h_axTempAboveBWT(i).Color,'markerfacecolor',h_axTempAboveBWT(i).Color, 'tag', ['sensTemp_' num2str(i)]);
     hold(axes_TempvTau, 'on');
     n=n+1;
 end

      % Set labels and axes limits
      % --------------------------------------------------
        xlabel(axes_TempvTau, '\tau','fontsize',18,'verticalalignment','top')
        ylabel(axes_TempvTau, '\bfTemperature ( ^oC)','fontsize',16,'verticalalignment','top')
        set(axes_TempvTau,'yaxislocation','right', 'XLim', [0 FricTauMax+1])
 
      % Lines indicating min and max of Tau (set by PAR file)
      % -----------------------------------------------------
        xline(axes_TempvTau, FricTauMin, '--k', 'Label', 'Minimum Tau', ...
            'FontSize',16, 'FontWeight', 'bold')
        xline(axes_TempvTau, FricTauMax, '--k', 'Label', 'Maximum Tau', ...
            'FontSize',16, 'FontWeight', 'bold')

 % Plot Temperature vs. Bullard Decay Function (F(alpha,tau))
 % ---------------------------------------------------------------
 n=1;

 for i = SensorsToUse
    h_axFricTempvTauPoints(i) = plot(axes_TempvBullFunc, DataFAT(:,n,IndexOfMinimums(n)),...
        DataTemp(:,n,IndexOfMinimums(n)),'d','markersize',2, ...
        'Color',h_axTempAboveBWT(i).Color,'markerfacecolor',h_axTempAboveBWT(i).Color, ...
        'tag', ['sensCorrectedTemp_' num2str(i)]);
     hold(axes_TempvBullFunc, 'on');
    h_axFricTempvTauLines(i) = plot(axes_TempvBullFunc, [0 DataFAT(DataLimits(1),n,IndexOfMinimums(n))],...
        b(n,IndexOfMinimums(n))*[0 DataFAT(DataLimits(1),n,IndexOfMinimums(n))] ...
        + a(n,IndexOfMinimums(n)), 'Color',h_axTempAboveBWT(i).Color,...
        'tag', ['sensBestFitLine_' num2str(i)]);

     n=n+1;

 end

      % Set labels
      % --------------------------------------------------
        xlabel(axes_TempvBullFunc, '\bfF(2,\rm\fontsize{18}\tau)\bf\fontsize{18}','fontsize',18,'verticalalignment','top')
        ylabel(axes_TempvBullFunc, '\bfTemperature ( ^oC)','fontsize',16,'verticalalignment','bottom')

      % Set plot limits -- not sure if this is necessary. does not do
      % anything to the penetration that I am testing with. maybe fixes
      % other ones?
      % ---------------------
        PlotLims = [0 ...
          max(diag(squeeze((DataFAT(DataLimits(1),:,IndexOfMinimums))))) ...
          min([MinimumFricEqTemp;min(min(min(DataTemp)))]) ...
          max([MinimumFricEqTemp;max(max(max(DataTemp)))])];
        
        PlotLims(2) = PlotLims(2)+PlotLims(2)/20;
        PlotLims(3) = PlotLims(3)-(PlotLims(4)-PlotLims(3))/20;
        PlotLims(4) = PlotLims(4)+(PlotLims(4)-PlotLims(3))/20;
        set(axes_TempvBullFunc,'xlim',PlotLims(1:2), ...
            'ylim',PlotLims(3:4))
        
 % Plot Residual Misfit (??C) vs. Time Shifts (s)
 % ---------------------------------------------------------------
    n=1;

    for i = SensorsToUse
        h_axFricRMSvTimeShift(i) = plot(axes_TimeShift, TimeShifts(:,n),...
            RMS(n,:),'-v','markersize',2, ...
            'Color',h_axTempAboveBWT(i).Color,'markerfacecolor',h_axTempAboveBWT(i).Color, ...
            'tag', ['sensCorrectedTemp_' num2str(i)]);
     
        hold(axes_TimeShift, 'on');

        h_axFricRMSvTimeShiftMinDelays(i) = xline(axes_TimeShift, MinimumFricDelays(n), ...
             'Color',h_axTempAboveBWT(i).Color, 'linestyle', '--', 'FontWeight','bold');
        n=n+1;
    end

          % Set labels and axes limits
          % ----------------------------
            xlabel(axes_TimeShift, '\bfTime Shifts (s)','fontsize',16,'verticalalignment','top')
            ylabel(axes_TimeShift, '\bfResidual Misfit ( ^oC)', ...
            'fontsize',16,'verticalalignment','top')
            set(axes_TimeShift,'yaxislocation','right','yscale','log')
else
        h_axFricTempvTime = zeros(1, NumberOfSensors);
        h_axFricTempvTau = zeros(1, NumberOfSensors);
        h_axFricTempvTauPoints = zeros(1, NumberOfSensors);
        h_axFricTempvTauLines = zeros(1, NumberOfSensors);
        h_axFricRMSvTimeShift = zeros(1, NumberOfSensors);
        h_axFricRMSvTimeShiftMinDelays = zeros(1, NumberOfSensors);
end


if any(all(isnan(DataTemp)))
    uialert(figure_Main, ['Error: heat pulse power too low. Must raise power ' ...
        'or ignore heat pulse reduction.'], 'HEAT PULSE POWER TOO LOW', 'Icon','error');
    HPTooLow = 1;
    return
else
    HPTooLow = 0;
end   
