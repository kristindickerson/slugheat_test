
%%% ======================================================================
%   Purpose: 
%   This function plots results of the Bullard Analysis. Plots include Temp
%   relative to bottom water vs. Depths, Thermal Conductivity vs. Depth, and 
%   Temp relative to bottom water vs. Cumulative Thermal Resitance. The
%   gradient of this final plot is the heat flow value.
%%% ======================================================================

function PlotHeatFlow
% ====================================== %
%                 PLOT                   %
% ====================================== %
if Iteration == MaxNumberOfIterations ...
                       || abs(sum(kChange(~isnan(kChange)))) < MinTotalkChange
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
    
        h_axBullTempvDepthBAD = plot(axes_TempvDepth, MinimumFricEqTemp(intersect(BadT,SensorsToUse)), ...
            RelativeDepths(intersect(BadT,SensorsToUse)),'rx','markersize',30);
        h_axBullTempvShiftedDepthBAD = plot(axes_TempvDepth, MinimumFricEqTemp(intersect(BadT,SensorsToUse)), ...
            ShiftedRelativeDepths(intersect(BadT,SensorsToUse)),'rx','markersize',30);
        h_axBullTempvShiftedDepthBestFit = plot(axes_TempvDepth, [0 max(MinimumFricEqTemp)],Slope(1)*[0 max(MinimumFricEqTemp)],'k');
        
        xlabel(axes_TempvDepth, '\bfTemperature ( ^oC)', ...
            'fontsize',16, ...
            'verticalalignment','bottom')
        ylabel(axes_TempvDepth, '\bfRelative Depth (m)', ...
            'fontsize',16, ...
            'verticalalignment','bottom')
        axis(axes_TempvDepth, [Tmin Tmax zmin zmax]);
   
        axes_TempvDepth.YDir = 'reverse';
        axes_TempvDepth.XAxisLocation = "top";
   
   
        pause(1);
        drawnow;

        % Plot Thermal Conductivities vs. Relative Depths
        % -----------------------------------------------
        for i = SensorsToUse
            h_axTCvDepth(i) = plot(axes_TCvDepth, Currentk(i),ShiftedRelativeDepths(i),...
                'd','markersize',10, ...
               'Color',h_axTempAboveBWT(i).Color,'markerfacecolor',h_axTempAboveBWT(i).Color, 'tag', ['sensTC_' num2str(i)]);
            hold(axes_TCvDepth, 'on');
   
            x = Currentk(kToUse);
            x = [x(1) x];
            y = ShiftedRelativeDepths(kToUse);
            y = [y(1) y(1:end-1) + diff(y)/2 0];
            h_axTCvDepthStairs = stairs(axes_TCvDepth, x,y,'k');
            hold(axes_TCvDepth, 'on');
        end
    
        h_axTCvDepthBAD = plot(axes_TCvDepth, Currentk(intersect(Badk,SensorsToUse)), ...
            ShiftedRelativeDepths(intersect(Badk,SensorsToUse)),'rx','markersize',30);
        
        xlabel(axes_TCvDepth, '\bfThermal Conductivity (W m^{-1} ^oC^{-1})', ...
            'fontsize',16, ...
            'verticalalignment','bottom')
        axis(axes_TCvDepth, [kmin kmax zmin zmax]);
        axes_TCvDepth.YTickLabel = [];

        axes_TCvDepth.YDir = 'reverse';
        axes_TCvDepth.XAxisLocation = "top";
        
        % Average Thermal Conductivity +/- 1 std
        % --------------------------------------
        kmean = mean(x);
        kstd  = std(x);
        
        pause(1);
        drawnow;


        % Plot Cumulative Thermal Resistance (CTR) vs. Relative Depths
        % --------------------------------------------------------------
        for i = 1:length(GoodBullardDepths)
             h_axCTRvDepth(i) = plot(axes_TempvCTR, MinimumFricEqTemp(GoodBullardDepths(i)), ...
                 BullardDepths(GoodkIndex(i)), 'o','markersize',7, ...
                'Color',h_axTempAboveBWT(GoodBullardDepths(i)).Color,'markerfacecolor', ...
                h_axTempAboveBWT(GoodBullardDepths(i)).Color, 'tag', ['sensCTR_' num2str(i)]);
             hold(axes_TempvCTR, 'on');

             h_axCTRvShiftedDepth(i) = plot(axes_TempvCTR, MinimumFricEqTemp(GoodBullardDepths(i)), ...
                 ShiftedBullardDepths(GoodkIndex(i)), 'o','markersize',10, ...
                'Color',h_axTempAboveBWT(GoodBullardDepths(i)).Color,'markerfacecolor', ...
                h_axTempAboveBWT(GoodBullardDepths(i)).Color, 'tag', ['sensCTR_' num2str(i)]);
             hold(axes_TempvCTR, 'on');
        end

        h_axCTRvShiftedDepthBestFit = plot(axes_TempvCTR, [0 max(MinimumFricEqTemp)],Slope(2)*[0 max(MinimumFricEqTemp)],'k');
        xlabel(axes_TempvCTR, '\bfTemperature ( ^oC)', ...
            'fontsize',16, ...
            'verticalalignment','bottom')
        ylabel(axes_TempvCTR, '\bfCumulative thermal resistance (m^2 ^oC W^{-1})', ...
            'fontsize',16, ...
            'verticalalignment','bottom')
        axis(axes_TempvCTR, [Tmin Tmax zmin zmax]);

        axes_TempvCTR.YDir = 'reverse';
        axes_TempvCTR.XAxisLocation = "top";



        % Update results with gradient, depth of top sensor, average k,
        % heat flow, and shift
        % -------------------------------------------------------------
        label_gradient.Interpreter = 'latex';
        label_depthoftop.Interpreter = 'latex';
        label_averagek.Interpreter = 'latex';
        label_heatflow.Interpreter = 'latex';
        label_shift.Interpreter = 'latex';
        
        Gradient = 1/Slope(1);
        DepthToTopSens = PenetrationLag(1);

        % Convert to mW
        % ------------
        Averagek = kmean*1000;
        HeatFlow = (1/Slope(2))*1000;
        
        HFShift = Shift(2);

        label_gradient.Text = [num2str(Gradient, 3) ' +/- ' num2str(MeanSigmaRGradient, 1)  ' $°C m^{-1}$'];
        label_depthoftop.Text = [num2str(DepthToTopSens, 3) ' m'];
        label_averagek.Text = [num2str((Averagek),2),' +/- ',num2str((kstd),2) ' $mW m^{-1} °C^{-1}$'];
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

        %panel_TempvDepth = axes_TempvDepth.Parent;
        %panel_TCvDepth = axes_TCvDepth.Parent;
        %panel_TempvCTR = axes_TempvCTR.Parent;

        trial_name = [PenFileName(1:end-4) '_Trial_' num2str(Trial)];

        %save(trial_name, 'axes_TempvDepth', 'axes_TCvDepth', 'axes_TempvCTR')

end