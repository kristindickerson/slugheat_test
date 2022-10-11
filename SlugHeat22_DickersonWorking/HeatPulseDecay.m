%%% ======================================================================
%   Purpose: 
%   This function computes thermal conductivities iteratively from a heat
%   pulse decay
%%% ======================================================================

function [ ...
        MeankPointAtMinkDiff, ...
        kSlopeAtMinkDiff, ...
        MeankPointAtZeroInfTemp, ...
        MeankPointAtMinRMS, ...
        kSlopeAtZeroInfTemp, ...
        kSlopeAtMinRMS, ...
        TempAtInf, ...
        NumberOfUsedPoints, ...
        MinimumPulseDelays, ...
        kError, ...
        h_axHPTempvTime, ...
        h_axHPRMS, ...
        h_axHPRMSLine, ...
        h_axHPTempvInvTime, ...
        h_axHPTempvInvTimeBestFit, ...
        h_axHPTempvTimeShift, ...
        h_axHPTempvTimeShiftBestFit ...
        ] = HeatPulseDecay( ...
            NumberOfSensors, ...
            SensorsToUse, ...
            PulseTime, ...
            PulseDelays, ...
            MinimumFricEqTemp, ...
            MinimumFricSlope, ...
            PulseTemp, ...
            Currentk, ...
            HyndmanCoeffs, ...
            SensorRadius, ...	
            PulseMaxStep, ...
            TimeShiftInc, ...
            PulseTauMin, ...
            PulseTauMax, ...
            PulsePower, ...
            HeatPulseLength, ...
            axes_CTempvCtime, ...
            axes_CTempv1_CTime, ...
            axes_MisfitvTimeShift, ...
            axes_TempvTimeShift, ...
            axes_HeatPulseTesting, ...
            h_axTempAboveBWT, ...
            Iteration, ...
            ChosenIteration, ...
            Pause)  

    % ====================================== %
    %               COMPUTE                  %
    % ====================================== %
    
    % Initialize heat pulse decay processing
    % ---------------------------------------
   %SensorsToUse = [1,2,3,4,5,6,7,8,9,10]; % KD added for testing

    NumberOfSensorsUsed = length(SensorsToUse);
    
    load('SlugHeat22.mat', 'Tau00Data', 'FAT00')
    
    Alpha=2.0;                  % Set to a constant value
    LIT = length(PulseTime);
    HC = HyndmanCoeffs;
    Kappa = repmat(1e-6*Currentk(SensorsToUse)./(HC(1) ...
        - HC(2)*Currentk(SensorsToUse) ...
        + HC(3)*Currentk(SensorsToUse).^2),LIT,1);
    Tau00Index = 1:Tau00Data(3)/Tau00Data(2);
    ResidualTime = repmat(PulseTime,[1 NumberOfSensorsUsed]);
    HeatPulseTime = repmat(PulseTime-PulseTime(1),[1 NumberOfSensorsUsed])-HeatPulseLength/2;
    
    % Obtain Tau and  F(α,τ) values corresponding to Time
    % --------------------------------------------------------
    ResidualTau = Kappa.*ResidualTime/(SensorRadius^2);
    HeatPulseTau = Kappa.*HeatPulseTime/(SensorRadius^2);
    ResidualTauIndex = round(ResidualTau/Tau00Data(2));
    HeatPulseTauIndex = round(HeatPulseTau/Tau00Data(2));
    
    % Don't consider data for Tau<=0 and,
    % if greater than the maximum Tau of FAT00, approximate it with 1/2AlphaTau !
    % ---------------------------------------------------------------------------
    
    ResidualTauIndex(ResidualTauIndex > Tau00Data(3)/Tau00Data(2)) = length(FAT00) + 1;
    HeatPulseTauIndex(HeatPulseTauIndex > Tau00Data(3)/Tau00Data(2)) = length(FAT00) + 1;
    ResidualTauIndex(ResidualTauIndex < 1) = length(FAT00) + 2;
    HeatPulseTauIndex(HeatPulseTauIndex < 1) = length(FAT00) + 2;
    FAT00(end+1) = 9;
    FAT00(end+1) = NaN;
    
    ResidualFAT = FAT00(ResidualTauIndex);
    HeatPulseFAT = FAT00(HeatPulseTauIndex);   
    
    iRF = find(ResidualFAT>8);
    iHPF = find(HeatPulseFAT>8);
    ResidualFAT(iRF) = 1./(4*ResidualTau(iRF))-1./(8*ResidualTau(iRF).^2);
    HeatPulseFAT(iHPF) = 1./(4*HeatPulseTau(iHPF))-1./(8*HeatPulseTau(iHPF).^2);
    
    % Compute and remove residual temperature of the frictional decay
    % ---------------------------------------------------------------
    
    ResidualTemp = repmat(MinimumFricEqTemp(SensorsToUse)',LIT,1) ...   
        + repmat(MinimumFricSlope(SensorsToUse)',LIT,1).*ResidualFAT;
    Temp = PulseTemp(:,SensorsToUse)-ResidualTemp; 
    
    % Correct the heat pulse decay for early Tau
    % ------------------------------------------
    
    CorrectedTemp = Temp./(2*Alpha*HeatPulseTau.*HeatPulseFAT);
    
    % Apply Tau window to heat pulse data
    % -----------------------------------
    
    DataTemp = NaN*ones(size(CorrectedTemp));
    [i,j] = find(HeatPulseTau > PulseTauMin & HeatPulseTau < PulseTauMax);
    DataTemp(i,j) = CorrectedTemp(i,j);
    DataTemp = repmat(DataTemp,[1 1 PulseMaxStep]);
    
    % Compute time shifts
    % -------------------
    
    TimeShifts = repmat(PulseDelays(SensorsToUse),[PulseMaxStep 1]) ...
        + repmat(-TimeShiftInc*(0:PulseMaxStep-1)',[1 NumberOfSensorsUsed]);
    
    ShiftedTime = repmat(PulseDelays(SensorsToUse),[LIT 1 PulseMaxStep]) ...
        + repmat(HeatPulseTime,[1 1 PulseMaxStep]) ...
        + repmat(permute(-TimeShiftInc*(0:PulseMaxStep-1),[3 1 2]),[LIT NumberOfSensorsUsed 1]);

%    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    % ADDED BY KD FOR TESTING
%    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    % Compute dimensionless time (Tau) Data
%% ---------------------------------------
%
%KappaMatrix = repmat(Kappa,[1 1 PulseMaxStep]);
%ShiftedTau = KappaMatrix.*ShiftedTime/SensorRadius^2;
%ShiftedTauIndex = round(ShiftedTau/Tau00Data(2));
%
%ShiftedTauIndex(ShiftedTauIndex > Tau00Data(3)/Tau00Data(2)) = length(FAT00) + 1;
%ShiftedTauIndex(ShiftedTauIndex < 1) = length(FAT00) + 2;
%FAT00(end+1) = 9;   %% Why do this?
%FAT00(end+1) = NaN; %% Why do this?
%
%DataFAT = FAT00(ShiftedTauIndex);
%iDF = find(DataFAT>8);
%DataFAT(iDF) = 1./(4*ShiftedTau(iDF))-1./(8*ShiftedTau(iDF).^2);
%DataTemp = repmat(DataTemp,[1 1 PulseMaxStep]);
%
%    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    % ADDED BY KD FOR TESTING
%    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    
    % Compute 1/time and remove infinite and negative 1/time
    % ------------------------------------------------------
    
    ShiftedTime(ShiftedTime<=0) = NaN;
    OneOverTime = 1./ShiftedTime;
    
    % Get rid of NaNs in OneOverTime and DataTemp and make 2-D arrays
    % ---------------------------------------------------------------
    
    [ix,jx] = find(~isnan(OneOverTime));
    [iy,jy] = find(~isnan(DataTemp));
    
    DataLimits = [max([min(ix) min(iy)]) min([max(ix) max(iy)])];
    NumberOfUsedPoints = 1+diff(DataLimits);
    clear ix iy jx jy
    
    X = reshape(OneOverTime(DataLimits(1):DataLimits(2),:,:), ...
        [NumberOfUsedPoints NumberOfSensorsUsed*PulseMaxStep]);
    Y = reshape(DataTemp(DataLimits(1):DataLimits(2),:,:), ...
        [NumberOfUsedPoints NumberOfSensorsUsed*PulseMaxStep]);

    
    [a,b,Sigmaa,Sigmab,Chi2] = ChiSquaredFit(X,Y);
    
    kSlope = (PulsePower/4/pi)./reshape(b,[NumberOfSensorsUsed PulseMaxStep]);
    TempAtInfinity = reshape(a,[NumberOfSensorsUsed PulseMaxStep]);
    kSlopeRMS = sqrt(reshape(Chi2,[NumberOfSensorsUsed PulseMaxStep])/(NumberOfUsedPoints-2));
    
    % Calculate kPoint for all delays and average and variance of kPoint
    % -----------------------------------
    
    kPoint = reshape(PulsePower.*X./(4*pi.*Y),[NumberOfUsedPoints NumberOfSensorsUsed PulseMaxStep]);
    
    kPointMean = squeeze(mean(kPoint));
    
    % Find the k's corresponding to the minimum RMS or to Zero asymptotic temperature
    % -------------------------------------------------------------------------------
    
    kError = NaN*zeros(NumberOfSensorsUsed,1);
    kSlopeAtMinkDiff = NaN*zeros(NumberOfSensorsUsed,1);
    MeankPointAtMinkDiff = NaN*zeros(NumberOfSensorsUsed,1);
    MeankPointAtZeroInfTemp = NaN*zeros(NumberOfSensorsUsed,1);
    kSlopeAtZeroInfTemp = NaN*zeros(NumberOfSensorsUsed,1);
    kSlopeAtMinRMS = NaN*zeros(NumberOfSensorsUsed,1);
    MeankPointAtMinRMS = NaN*zeros(NumberOfSensorsUsed,1);
    MinimumPulseDelays = NaN*zeros(NumberOfSensorsUsed,1);
    TempAtInf = NaN*zeros(NumberOfSensorsUsed,1);
    
    kDiff = abs(kSlope-repmat(Currentk(SensorsToUse)',[1 PulseMaxStep]));
    
    [MinkDiff,MinkDiffIndex] = min(kDiff,[],2);
    [dummy,MinkSlopeRMSIndex] = min(2*kSlopeRMS,[],2);
    [dummy,ZeroInfTempIndex] = min(abs(TempAtInfinity),[],2);
    
    kError(SensorsToUse) = dummy;
    kSlopeAtMinkDiff(SensorsToUse) = diag(kSlope(:,MinkDiffIndex));
    MeankPointAtMinkDiff(SensorsToUse) = diag(kPointMean(:,MinkDiffIndex));
    MeankPointAtZeroInfTemp(SensorsToUse) = diag(kPointMean(:,ZeroInfTempIndex));
    kSlopeAtZeroInfTemp(SensorsToUse) = diag(kSlope(:,ZeroInfTempIndex));
    MeankPointAtMinRMS(SensorsToUse) = diag(kPointMean(:,MinkSlopeRMSIndex));
    kSlopeAtMinRMS(SensorsToUse) = diag(kSlope(:,MinkSlopeRMSIndex));
    MinimumPulseDelays(SensorsToUse) = diag(TimeShifts(MinkDiffIndex,:));
    TempAtInf(SensorsToUse) = diag(TempAtInfinity(:,MinkDiffIndex));
    

    if Iteration == ChosenIteration || (Iteration ~= ChosenIteration && Pause == 1)
    % ====================================== %
    %                 PLOT                   %
    % ====================================== %
    
    % Plot Temperature vs. Time with optimally shifted 
    % heat pulse decay data
    % ---------------------------------------------
        
        n=1;
    
        for i = SensorsToUse
         h_axHPTempvTime(i) = plot(axes_CTempvCtime, ShiftedTime(:,n,MinkDiffIndex(n)),...
             DataTemp(:,n,MinkDiffIndex(n)),'-o','markersize',2, 'marker','v',...
            'Color',h_axTempAboveBWT(i).Color,'markerfacecolor',h_axTempAboveBWT(i).Color, 'tag', ['sensTemp_' num2str(i)]);
         hold(axes_CTempvCtime, 'on');
         ymax(i) = max(DataTemp(:,n,MinkDiffIndex(n)));
         n=n+1;
        end

        ymaxAll = max(ymax);
    
            % Set labels and axes limits
            % ---------------------------
            xlabel(axes_CTempvCtime, '\bfCorrected Time (s)', 'verticalalignment','top', ...
            'fontsize',16)
            ylabel(axes_CTempvCtime, '\bfCorrected Temperature ( ^oC)', 'verticalalignment',...
                'bottom', 'fontsize',16)
            set(axes_CTempvCtime,'xlim',[HeatPulseTime(1) HeatPulseTime(end)])
            set(axes_CTempvCtime, 'ylim', [0 ymaxAll+0.1])
    
    % Plot Residual Misfit from best fit line (RMS) with Time shift
    % -------------------------------------------------------------
    
        n=1;
    
        for i = SensorsToUse
         h_axHPRMS(i) = plot(axes_MisfitvTimeShift, TimeShifts(:,n),...
             kSlopeRMS(n,:),'-o','markersize',4, 'Color',h_axTempAboveBWT(i).Color,...
             'markerfacecolor',h_axTempAboveBWT(i).Color, 'tag', ['sens_' num2str(i)]);
         hold(axes_MisfitvTimeShift, 'on');
         n=n+1;
        end
    
        % Set labels and axes limits 
        % --------------------------
            xlabel(axes_MisfitvTimeShift, '\bfTime Shifts (s)', ...
                'verticalalignment','top', ...
                'fontsize',16)
            ylabel(axes_MisfitvTimeShift, '\bfResidual Misfit for k_{slope} (W m^{-1} ^oC^{-1})', ...
                'verticalalignment','top', ...
                'fontsize',16)
            set(axes_MisfitvTimeShift,'yaxislocation','right', ...
                'yscale','log')
    
        % Plot lines for minimum misfit from linear best fit line
        % -------------------------------------------------------
        for i = SensorsToUse
            h_axHPRMSLine(i) = xline(axes_MisfitvTimeShift, ...
                MinimumPulseDelays(i), 'color',h_axTempAboveBWT(i).Color,...
                'linestyle','--');
            hold(axes_MisfitvTimeShift, 'on');
        end
    
    % Plot Temperature vs. 1/Time with best fit line
    % ------------------------------------------------
        n=1;
    
        for i = SensorsToUse
         h_axHPTempvInvTime(i) = plot(axes_CTempv1_CTime, OneOverTime(:,n,MinkDiffIndex(n)), ...
             DataTemp(:,n,MinkDiffIndex(n)),'v','markersize',4, 'Color', ...
             h_axTempAboveBWT(i).Color,'markerfacecolor',h_axTempAboveBWT(i).Color, ...
             'tag', ['sens_' num2str(i)]);
         hold(axes_CTempv1_CTime, 'on');
         
         idx = find(~isnan(OneOverTime(:,n,MinkDiffIndex(n))));
    
         h_axHPTempvInvTimeBestFit(i) = plot(axes_CTempv1_CTime, ...
             [0 OneOverTime(idx(1),n,MinkDiffIndex(n))], ...
             TempAtInfinity(n,MinkDiffIndex(n)) + ...
             ((PulsePower/4/pi)./kSlope(n,MinkDiffIndex(n))) ...
             * [0 OneOverTime(idx(1),n,MinkDiffIndex(n))],'Color', ...
             h_axTempAboveBWT(i).Color,'tag', ['sensBestFit_' num2str(i)]);
    
         n=n+1;
        end
    
        % Set labels and axes limits 
        % --------------------------
          xlabel(axes_CTempv1_CTime, '\bf1/Time (s^{-1})', ...
            'verticalalignment','top', ...
            'fontsize',16)
          ylabel(axes_CTempv1_CTime, '\bfCorrected Temperature ( ^oC)', ...
            'verticalalignment','bottom', ...
            'fontsize',16)
          lims = get(axes_CTempvCtime,'ylim');
          set(axes_CTempv1_CTime,'xlim',[0 1./HeatPulseTime(DataLimits(1))], ...
              'ylim',[0 lims(2)])
    
           % Link Temp vs. Time and Temp vs. 1/Time axes by temp axis
           % --------------------------------------------------------
            ax=[axes_CTempv1_CTime axes_CTempvCtime];
                linkaxes(ax,'y');
       
     
    % Plot Asymptotic Temperature vs. Time Shift
    % --------------------------------------------
    
        n=1;
    
        for i = SensorsToUse
         h_axHPTempvTimeShift(i) = plot(axes_TempvTimeShift, TimeShifts(:,n), ...
             TempAtInfinity(n,:),'-x','markersize',4, 'Color', ...
             h_axTempAboveBWT(i).Color,'markerfacecolor',h_axTempAboveBWT(i).Color, ...
             'tag', ['sens_' num2str(i)]);
         hold(axes_TempvTimeShift, 'on');
    
         n=n+1;
        end
    
    
        % Set labels and axes limits 
        % --------------------------
        xlabel(axes_TempvTimeShift, '\bf Time Shifts (s)', ...
            'verticalalignment','top', ...
            'fontsize',16)
        ylabel(axes_TempvTimeShift, '\bfTemperature at Infinity ( ^oC)', ...
            'verticalalignment','top', ...
            'fontsize',16)
    
        set(axes_TempvTimeShift,'yaxislocation','right')
    
         % Link Residual Misfit for k vs. Time Shift and Temp vs. Time shift 
         % --------------------------------------------------------
            ax=[axes_TempvTimeShift axes_MisfitvTimeShift];
                linkaxes(ax,'x');
    
         % Plot lines  
         % ------------
         yline(axes_TempvTimeShift, 0, 'k--') % Horizontal line at 0°C
         
         for i = SensorsToUse
             h_axHPTempvTimeShiftBestFit(i) = xline(axes_TempvTimeShift, ...
                 MinimumPulseDelays(i), 'color',h_axTempAboveBWT(i).Color,...
                 'linestyle','--');
             hold(axes_TempvTimeShift, 'on');
         end
    
         drawnow;
         pause(1)

    else
        h_axHPTempvTime = zeros(1, NumberOfSensors);
        h_axHPRMS = zeros(1, NumberOfSensors);
        h_axHPRMSLine = zeros(1, NumberOfSensors);
        h_axHPTempvInvTime = zeros(1, NumberOfSensors);
        h_axHPTempvInvTimeBestFit = zeros(1, NumberOfSensors);
        h_axHPTempvTimeShift = zeros(1, NumberOfSensors);
        h_axHPTempvTimeShiftBestFit = zeros(1, NumberOfSensors);

    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% ADDED BY KD FOR TESTING EFFECT OF LOW HEAT PULSE POWER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%% Plot Temp vs. Tau during heat pulse
%% --------------------------------------------------------------
%% Plot Temperature vs. Dimensionless Time (Tau)
% % ---------------------------------------------
%    
% n=1;
%
%  for i = SensorsToUse
%     h_axHPTempvTau(i) = plot(axes_HeatPulseTesting, ShiftedTau(:,n,IndexOfMinimums(n)),...
%         DataTemp(:,n,MinkDiffIndex(n)),'-o','markersize',2, ...
%        'Color',h_axTempAboveBWT(i).Color,'markerfacecolor',h_axTempAboveBWT(i).Color, 'tag', ['sensTemp_' num2str(i)]);
%     hold(axes_HeatPulseTesting, 'on');
%     n=n+1;
% end
%
%      % Set labels and axes limits
%      % --------------------------------------------------
%        xlabel(axes_HeatPulseTesting, '\tau','fontsize',18,'verticalalignment','top')
%        ylabel(axes_HeatPulseTesting, '\bfTemperature ( ^oC)','fontsize',16,'verticalalignment','top')
%        set(axes_HeatPulseTesting,'yaxislocation','right', 'XLim', [0 PulseTauMax+1])
% 
%      % Lines indicating min and max of Tau (set by PAR file)
%      % -----------------------------------------------------
%        xline(axes_HeatPulseTesting, PulseTauMin, '--k', 'Label', 'Minimum Tau', ...
%            'FontSize',16, 'FontWeight', 'bold')
%        xline(axes_TempvTau, PulseTauMax, '--k', 'Label', 'Maximum Tau', ...
%            'FontSize',16, 'FontWeight', 'bold')
%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% ADDED BY KD FOR TESTING EFFECT OF LOW HEAT PULSE POWER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%









