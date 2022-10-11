%%% ======================================================================
%   Purpose: 
%   This function ...
%%% ======================================================================

function   [ ...
             SensorsUsedForBullardFit, ...
             GoodkIndex, ...
             CTRToUse, ... 
             CTR, ...
             ShiftedCTR, ...
             ShiftedRelativeDepths, ...
             SigmaR, ...
             PenetrationLag, ...
             Slope, ...
             Shift, ...
             S_BullPlots, ...
             HeatFlow, ...
             Averagek, ...
             Gradient] = HeatFlowAnalysis(NumberOfSensors, ...
             RelativeDepths, ...
             Currentk, ...
             MinimumFricEqTemp, ...
             Badk, ...
             BadT, ...
             h_axTempAboveBWT, ...
             SensorsToUse, ...
             axes_TempvDepth, ...
             axes_TCvDepth, ...
             axes_TempvCTR, ...
             label_gradient, ...
             label_depthoftop, ...
             label_averagek, ...
             label_heatflow, ...
             label_shift)

             
S_BullPlots = [];
HeatFlow = [];
Gradient = [];
Averagek = [];


% ====================================== %
%               COMPUTE                  %
% ====================================== %

    % Define what sensors to use
    % --------------------------
    
    GoodT = setxor(1:NumberOfSensors,BadT);
    Goodk = setxor(1:NumberOfSensors,Badk);
    
    TToUse = intersect(GoodT,SensorsToUse);    % SensorsToUse for temperature calculations (T)
    kToUse = intersect(Goodk,SensorsToUse);    % SensorsToUse for thermal conductivity calculations (k)


    % Shift Relative Depths
    % ---------------------
    
    % Here we do a least-squares fit of the temperatures other than 
    % those ignored from the beginning and those discarded after initial 
    % processing (BadT).

    MinimumFricEqTemp = MinimumFricEqTemp';
    
    [pz, Sz] = polyfit(MinimumFricEqTemp(TToUse),RelativeDepths(TToUse),1);
    % pz returns a vector of coefficients for a polynomial with 1 degree 
    % y = mx + b
        % y = relative depths
        % x = equilibrium temperatures
        % m = pz(1) = slope of linear best fit line
        % b = pz(2) = y intercept of the linear best fit line

    Shift(1) = -pz(2);
    Slope(1) = pz(1);
    
    % Shift the relative depths so that the linear best fit line goes
    % through zero at the seafloor 
    ShiftedRelativeDepths = RelativeDepths + Shift(1);	
    
    % Define the shifted depth of the SHALLOWEST (top most) sensor as the
    % penetation lag (how far the shallowest sensor is form the seafloor)
    PenetrationLag(1) = ShiftedRelativeDepths(max(TToUse));  

    % Error assesment of linear best fit line (vector SigmaT shows
    % difference in each sensor's temperature relative to the best fit
    % line)
    [~,SigmaT] = polyval(pz,MinimumFricEqTemp(TToUse),Sz);
    MeanSigmaT = mean(SigmaT);

    % Define depth min and max for plotting axes limits
    z1min = min([RelativeDepths ShiftedRelativeDepths]);
    z1max = max([RelativeDepths ShiftedRelativeDepths]);


    % Cumulative Thermal Resistance
    % -----------------------------
    
    % Here we compute Cumulative Thermal Resistance using all conductivities 
    % not ignored or discarded (even if the Temperature was discarded)
    
    CTR = NaN*ones(NumberOfSensors,1);

    CTR(kToUse) = ShiftedRelativeDepths(max(kToUse))/Currentk(max(kToUse)) ...
        + fliplr(cumtrapz(fliplr(ShiftedRelativeDepths(kToUse)),1./fliplr(Currentk(kToUse))));
    
    % Now we need to determine the indices of the CTR vector that correspond to
    % to the valid temperatures (i.e., those not discarded - we can forget about the Sensors
    % originally ignored because their conductivities were ignored in the
    % Cumulative Thermal Resistance calculation.)
    
    [CTRToUse, GoodTIndex, GoodkIndex] = intersect(TToUse,kToUse);
    SensorsUsedForBullardFit = CTRToUse;

    % Get linear best fit line of temperature vs cumulative thermal resistance (instead of depth)
    % but only for sensors used in cumulative thermal resistance calculation
    [pR,SR] = polyfit(MinimumFricEqTemp(CTRToUse),CTR(CTRToUse),1);

    % Error assesment of linear best fit line (vector SigmaR shows
    % difference in each sensor's temperature relative to the best fit
    % line)
    [~,SigmaR] = polyval(pR,MinimumFricEqTemp(CTRToUse),SR);

    % Define shift and slope of temperature vs CTR 
    Shift(2) = -pR(2);
    Slope(2) = pR(1);

    % Confused by this? Why make CTR independent and temp dependent? Why
    % use the error of this plot and call it the error in thermal gradient,
    % when we use temp vs depth slope for thermal gradient? 
    [pGradient,sGradient]=polyfit(CTR(CTRToUse),MinimumFricEqTemp(CTRToUse),1);
    [dummyGradient,SigmaRGradient]=polyval(pGradient,CTR(CTRToUse),sGradient);
    MeanSigmaRGradient = mean(SigmaRGradient)/2;

    % Shift the cumulative thermal resistance so that the linear best fit 
    % line goes through zero when CTR is zero 
    ShiftedCTR = CTR + Shift(2);

    % Define depth min and max for plotting axes limits
    z2min = min([CTR ShiftedCTR]);
    z2max = max([CTR ShiftedCTR]);

    

% ================================================ %
% CALCULATE THERMAL GRADIENT, AVERAGE k, HEAT FLOW
% ================================================ %
     
    % Calculate thermal gradient and depth to top sensor
    % -------------------------------------------------
    Gradient = 1/Slope(1);
    DepthToTopSens = PenetrationLag(1);

    % Calculate Average Thermal Conductivity +/- 1 std
    % ------------------------------------------------
    kmean = mean(Currentk(kToUse));
    kstd  = std(Currentk(kToUse));
    Averagek = kmean;

    % Calculate heat flow and heat flow shift
    % ---------------------------------------
    HeatFlow = round((1/Slope(2))*1000);
    HFShift = Shift(2);

% ====================================== %
%                 PLOT                   %
% ====================================== %

        % Define axes limit
        % -------------------
        
        zmin = min([0 z1min z2min]);
        zmax = max([z1max z2max 0]);
        Tmin = min([0 MinimumFricEqTemp]);
        Tmax = max([MinimumFricEqTemp 0]);
        
        kmin = min(Currentk);
        kmax = max(Currentk);
        kmin = kmin - 0.15*(kmax-kmin);
        kmax = kmax + 0.15*(kmax-kmin);
        
        if Tmax == Tmin
            Tmax = Tmax + 0.05*Tmax;
            Tmin = Tmin - 0.05*Tmin;
        end
        
        if kmax == kmin
            kmax = kmax + 0.05*kmax;
            kmin = kmin - 0.05*kmin;
        end
        
        if zmax == zmin
            zmax = zmax + 0.05*zmax;
            zmin = zmin - 0.05*zmin;
        end


        % Plot Temperature vs. Relative Depths
        % -------------------------------------
        
        for i = SensorsToUse
             % Relative depths
             % ----------------
             h_axBullTempvDepth(i) = plot(axes_TempvDepth, MinimumFricEqTemp(i),RelativeDepths(i),...
                 '-o','markersize',7, ...
                'Color',h_axTempAboveBWT(i).Color, 'markerfacecolor',h_axTempAboveBWT(i).Color, 'tag', ['sensDepth_' num2str(i)]);
             hold(axes_TempvDepth, 'on');
    
             % Shift depths
             % ------------
             h_axBullTempvShiftedDepth(i) = plot(axes_TempvDepth, MinimumFricEqTemp(i),ShiftedRelativeDepths(i),...
                 '-o','markersize',10, ...
                 'Color',h_axTempAboveBWT(i).Color,'markerfacecolor',h_axTempAboveBWT(i).Color, 'tag', ['sensDepth_' num2str(i)]);
             hold(axes_TempvDepth, 'on');
        end
    
        % Plot temps from sensors that are ignored in computations with x's    
        h_axBullTempvDepthBAD = plot(axes_TempvDepth, MinimumFricEqTemp(intersect(BadT,SensorsToUse)), ...
            RelativeDepths(intersect(BadT,SensorsToUse)),'rx','markersize',30);
        h_axBullTempvShiftedDepthBAD = plot(axes_TempvDepth, MinimumFricEqTemp(intersect(BadT,SensorsToUse)), ...
            ShiftedRelativeDepths(intersect(BadT,SensorsToUse)),'rx','markersize',30);

        % Plot linear best fit line for temps with 0°C at 0 depth and with
        % calculated thermal gradient as slope of line
        h_axBullTempvShiftedDepthBestFit = plot(axes_TempvDepth, [0 max(MinimumFricEqTemp)],Slope(1)*[0 max(MinimumFricEqTemp)],'k');
        
        % Update labels and axes limits and orientations
        xlabel(axes_TempvDepth, '\bfTemperature relative to bottom water ( ^oC)', ...
            'FontSize',18, 'Color',[0.00,0.45,0.74], ...
            'verticalalignment','bottom')
        ylabel(axes_TempvDepth, '\bfRelative Depth (m)', ...
            'FontSize',18, 'Color',[0.00,0.45,0.74], ...
            'verticalalignment','bottom')
        axis(axes_TempvDepth, [Tmin Tmax 0 zmax]);
        axes_TempvDepth.YDir = 'reverse';
        axes_TempvDepth.XAxisLocation = "top";
     
        pause(1);
        drawnow;

        % Plot Thermal Conductivities vs. Relative Depths
        % -----------------------------------------------
        for i = SensorsToUse
            % Plot thermal conductivity vs shifted depths
            h_axTCvDepth(i) = plot(axes_TCvDepth, Currentk(i),ShiftedRelativeDepths(i),...
                'd','markersize',10, ...
               'Color',h_axTempAboveBWT(i).Color,'markerfacecolor',h_axTempAboveBWT(i).Color, 'tag', ['sensTC_' num2str(i)]);
            hold(axes_TCvDepth, 'on');
   
            % Plot stairs connecting k points
            x = Currentk(kToUse);
            x = [x(1) x];
            y = ShiftedRelativeDepths(kToUse);
            y = [y(1) y(1:end-1) + diff(y)/2 0];
            h_axTCvDepthStairs = stairs(axes_TCvDepth, x,y,'k');
            hold(axes_TCvDepth, 'on');
        end
        
        % Plot thermal conductivities from sensors that are ignored in computations with x's 
        h_axTCvDepthBAD = plot(axes_TCvDepth, Currentk(intersect(Badk,SensorsToUse)), ...
            ShiftedRelativeDepths(intersect(Badk,SensorsToUse)),'rx','markersize',30);
        
        % Update labels and axes limits and orientations
        xlabel(axes_TCvDepth, '\bfThermal Conductivity (W m^{-1} ^oC^{-1})', ...
            'FontSize',18, 'Color',[0.00,0.45,0.74], ...
            'verticalalignment','bottom')
        axis(axes_TCvDepth, [kmin kmax 0 zmax]);
        axes_TCvDepth.YTickLabel = [];
        axes_TCvDepth.YDir = 'reverse';
        axes_TCvDepth.XAxisLocation = "top";
        


        % Plot Cumulative Thermal Resistance (CTR) vs. Relative Depths
        % --------------------------------------------------------------
        for i = SensorsToUse
             h_axCTRvDepth(i) = plot(axes_TempvCTR, MinimumFricEqTemp(i), ...
                 CTR(i), 'o','markersize',7, ...
                'Color',h_axTempAboveBWT(i).Color,'markerfacecolor', ...
                h_axTempAboveBWT(i).Color, 'tag', ['sensCTR_' num2str(i)]);
             hold(axes_TempvCTR, 'on');

             h_axCTRvShiftedDepth(i) = plot(axes_TempvCTR, MinimumFricEqTemp(i), ...
                 ShiftedCTR(i), 'o','markersize',10, ...
                'Color',h_axTempAboveBWT(i).Color,'markerfacecolor', ...
                h_axTempAboveBWT(i).Color, 'tag', ['sensCTR_' num2str(i)]);
             hold(axes_TempvCTR, 'on');
        end

        h_axCTRvShiftedDepthBestFit = plot(axes_TempvCTR, [0 max(MinimumFricEqTemp)],Slope(2)*[0 max(MinimumFricEqTemp)],'k');
        xlabel(axes_TempvCTR, '\bfTemperature ( ^oC)', ...
            'FontSize',18, 'Color',[0.00,0.45,0.74], ...
            'verticalalignment','bottom')
        ylabel(axes_TempvCTR, '\bfCumulative thermal resistance (m^2 ^oC W^{-1})', ...
            'FontSize',18, 'Color',[0.00,0.45,0.74], ...
            'verticalalignment','bottom')
        axis(axes_TempvCTR, [Tmin Tmax 0 zmax]);

        axes_TempvCTR.YDir = 'reverse';
        axes_TempvCTR.XAxisLocation = "top";

        % Link Y axes of all three plots
        % --------------------------------------------------------
         ax=[axes_TempvDepth axes_TCvDepth axes_TempvCTR];
         linkaxes(ax,'y', 'x');


% Update results with gradient, depth of top sensor, average k,
% heat flow, and shift
% -------------------------------------------------------------
        label_gradient.Interpreter = 'latex';
        label_depthoftop.Interpreter = 'latex';
        label_averagek.Interpreter = 'latex';
        label_heatflow.Interpreter = 'latex';
        label_shift.Interpreter = 'latex';
       

        label_gradient.Text = [num2str(Gradient, 3) ' $°C m^{-1}$'];
        label_depthoftop.Text = [num2str(DepthToTopSens, 3) ' m'];
        label_averagek.Text = [num2str((Averagek),2),' +/- ',num2str((kstd),2) ' $W m^{-1} °C^{-1}$'];
        label_heatflow.Text = [num2str(HeatFlow,5) ' $mW m^{-2}$'];
        label_shift.Text = [num2str(HFShift,3) ' $m^2 °C W^{-1}$'];

        drawnow;


        S_BullPlots = struct('h_axBullTempvDepth', h_axBullTempvDepth, 'h_axBullTempvShiftedDepth', ...
            h_axBullTempvShiftedDepth, 'h_axBullTempvDepthBAD', h_axBullTempvDepthBAD, ...
            'h_axBullTempvShiftedDepthBAD', h_axBullTempvShiftedDepthBAD, ...
            'h_axBullTempvShiftedDepthBestFit', h_axBullTempvShiftedDepthBestFit, ...
            'h_axTCvDepth', h_axTCvDepth, 'h_axTCvDepthStairs', h_axTCvDepthStairs, ...
            'h_axTCvDepthBAD', h_axTCvDepthBAD, 'h_axCTRvDepth', h_axCTRvDepth, ...
            'h_axCTRvShiftedDepth', h_axCTRvShiftedDepth, 'h_axCTRvShiftedDepthBestFit', h_axCTRvShiftedDepthBestFit);


        pause(1);
        drawnow;
