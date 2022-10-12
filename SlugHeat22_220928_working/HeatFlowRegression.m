%%% ==============================================================================
% 	Purpose: 
%	This function ...
%%% ==============================================================================

function [Scatter, ...
        TempOverDepth, ...
        Sigmaa, ...
        Sigmab, ...
        HFLine, ...
        ScatterLine, ...
        SigmaHFLine, ...
        SigmaScatterLine] =  HeatFlowRegression(...
            axes_HeatFlow, ...
            axes_Sigma, ...
            SensorsUsedForBullardFit, ...
            GoodkIndex, ...
            ShiftedRelativeDepths, ...
            ShiftedBullardDepths, ...
            MinimumFricEqTemp, ...
            MinimumFricError, ...
            Currentk, ...
            NumberOfSensors, ...
            Trial, ...
            ResFileName)

% ====================================== %
%               COMPUTE                  %
% ====================================== %

    % Initiate
    % ----------
     MinimumFricEqTemp = MinimumFricEqTemp';
     MinimumFricError = MinimumFricError';
     Currentk = Currentk';

    % Go through N trials
    % -------------------
    
    lUsable = length(SensorsUsedForBullardFit);
    NFit = lUsable-2;
    
    % MH errortrap. If only 2 sensors penetrate, then the following loop will
    % crash - no purpose in doing the regression analysis. Simply return
    if NFit == 0
        Scatter = [];
        TempOverDepth = [];
        Sigmaa = [];
        Sigmab = [];
        return
    end
    
    % Define what sensors to use
    % --------------------------
    
    BullardDepthsToUse = ShiftedBullardDepths(GoodkIndex);
    EqTempToUse = MinimumFricEqTemp(SensorsUsedForBullardFit);
    EqTempErrorToUse = MinimumFricError(SensorsUsedForBullardFit);
    idx = find(EqTempErrorToUse < 1e-8);
    if ~isempty(idx)
        EqTempErrorToUse(idx) = mean(EqTempErrorToUse)/100 + 1e-8;
    end    
    UseLength = lUsable;
    
    
    for i=1:NFit
        if length(1:UseLength-(NFit-i)) > 1
            X = BullardDepthsToUse(1:UseLength-(NFit-i));
            Y = EqTempToUse(1:UseLength-(NFit-i))';
            Sigma = EqTempErrorToUse(1:UseLength-(NFit-i))'/2;    
            [A(i),B(i),Sigmaa(i),Sigmab(i),Chi2(i),Scatter(i),Covab(i),rab(i),Q(i)] ...
                = ChiSquaredFit(X,Y,Sigma);
        end   
    end
    
    DepthAtZero = -A./B;
    TempOverDepth = B;
    TempDepthError = Sigmab;

% ====================================== %
%                 PLOT                   %
% ====================================== %
    
        fit = length(TempOverDepth);
    
% Number of Sensors Used vs. Heat FLow (left) 
%                   and
% Number of Sensors Used vs. Scatter (right)
% ------------------------------------------
        yyaxis(axes_HeatFlow, 'left') 
        HFLine = plot(axes_HeatFlow, 1:fit, TempOverDepth, 'd-');
        ylabel(axes_HeatFlow, 'Heat Flow (W m^{-2})')
        yyaxis(axes_HeatFlow, 'right') 
        ScatterLine = plot(axes_HeatFlow, 1:fit, Scatter, '*-');
        ylabel(axes_HeatFlow, 'Scatter')
    
        axes_HeatFlow.XTick = 1:fit;
        axes_HeatFlow.XTickLabel = NumberOfSensors-fit+1:NumberOfSensors;
        axes_HeatFlow.XLabel.String = 'Number of Sensors Used';
    
        drawnow;
        pause(1);

    
% Number of Sensors Used vs. Sigma Heat FLow (left) 
%                   and
% Number of Sensors Used vs. Sigma Scatter (right)
% ------------------------------------------
        yyaxis(axes_Sigma, 'left') 
        SigmaHFLine = plot(axes_Sigma, 1:fit, Sigmab, 'd-');
        ylabel(axes_Sigma, '\fontsize{16}\sigma\fontsize{12}\bf_{HF} (W m^{-2})')
        yyaxis(axes_Sigma, 'right') 
        SigmaScatterLine = plot(axes_Sigma, 1:fit, Sigmab.*Scatter/max(Sigmab.*Scatter), '*-');
        ylabel(axes_Sigma, '\fontsize{16}\sigma\fontsize{12}\bf_b \rmx\bf Scatter \fontsize{11}\rm(normalized)')
    
        axes_Sigma.XTick = 1:fit;
        axes_Sigma.XTickLabel = NumberOfSensors-fit+1:NumberOfSensors;
        axes_Sigma.XLabel.String = 'Number of Sensors Used';
    
        drawnow;
        pause(1);
    