%%% ==============================================================================
%   Purpose: 
%     This function RESETS the axes and all information prior to reading in
%     a penetration file. Default parameters remain those read in from the
%     default .par file and default .cal file.
%%% ==============================================================================

function ResetAll(axes_TempAboveBWT, axes_BottomWaterTemp, ...
            axes_Depth, axes_Tilt, axes_TempvTime, axes_TempvTau, ...
            axes_TempvBullFunc, axes_TimeShift, axes_CTempvCtime, ...
            axes_CTempv1_CTime, axes_MisfitvTimeShift, axes_TempvTimeShift, ...
            axes_TempvDepth, axes_TCvDepth, axes_TempvCTR, ...
            axes_HeatFlow, axes_Sigma, ...
            label_gradient, label_depthoftop, label_averagek, label_heatflow, label_shift, ...
            label_trial, label_Iteration, label_currentpathfull, ...
            label_parfilename, label_calfilename, label_penfilename, label_tapfilename, ...
            label_logfilename, label_resfilename, ...
            edit_PenStart, edit_HP, edit_PenEnd, ...
            checkbox_BottomWaterPlot, checkbox_DepthPlot, ...
            checkbox_TiltPlot, PenCheckboxes, FricCheckboxes, HPCheckboxes, ...
            checkbox_UseWS, checkbox_UseHP, ...
            S_MATFile, NumberOfSensors, ProgramLogId, SensorsToUse)

    disp('SlugHeat Reset: clearing all...')
                
    %% RESET AXES
    % -------------
    % Penetration data axes
    % ---------------------
    cla(axes_TempAboveBWT, 'reset')
    axes_TempAboveBWT.Color = [0.90 0.90 0.90];
    cla(axes_BottomWaterTemp, 'reset')
    axes_BottomWaterTemp.Color = [0.90 0.90 0.90];
    cla(axes_Depth, 'reset')
    axes_Depth.Color = [0.90 0.90 0.90];
    cla(axes_Tilt, 'reset')
    axes_Tilt.Color = [0.90 0.90 0.90];
    
    % Frictional decay axes
    % ---------------------
    cla(axes_TempvTime, 'reset')
    axes_TempvTime.Color = [0.90 0.90 0.90];
    cla(axes_TempvTau, 'reset')
    axes_TempvTau.Color = [0.90 0.90 0.90];
    cla(axes_TempvBullFunc, 'reset')
    axes_TempvBullFunc.Color = [0.90 0.90 0.90];
    cla(axes_TimeShift, 'reset')
    axes_TimeShift.Color = [0.90 0.90 0.90];
    
    % Heat Pulse decay axes
    % ----------------------
    cla(axes_CTempvCtime, 'reset')
    axes_CTempvCtime.Color = [0.90 0.90 0.90];
    cla(axes_CTempv1_CTime, 'reset')
    axes_CTempv1_CTime.Color = [0.90 0.90 0.90];
    cla(axes_MisfitvTimeShift, 'reset')
    axes_MisfitvTimeShift.Color = [0.90 0.90 0.90];
    cla(axes_TempvTimeShift, 'reset')
    axes_TempvTimeShift.Color = [0.90 0.90 0.90];
    
    % Bullard Analysis axes
    % ----------------------
    cla(axes_TempvDepth, 'reset')
    axes_TempvDepth.Color = [0.90 0.90 0.90];
    cla(axes_TCvDepth, 'reset')
    axes_TCvDepth.Color = [0.90 0.90 0.90];
    cla(axes_TempvCTR, 'reset')
    axes_TempvCTR.Color = [0.90 0.90 0.90];
    label_gradient.Text = '';
    label_depthoftop.Text = '';
    label_averagek.Text = '';
    label_heatflow.Text = ''; 
    label_shift.Text = '';

    % Heat Flow Regression axes
    % ----------------------
    cla(axes_HeatFlow, 'reset')
    axes_HeatFlow.Color = [0.90 0.90 0.90];
    cla(axes_Sigma, 'reset')
    axes_Sigma.Color = [0.90 0.90 0.90];
    
    % Main figure labels
    % -------------------
    label_trial.Text = '';
    label_Iteration.Text = '';
    label_currentpathfull.Text = '';
    label_parfilename.Text = '';
    label_calfilename.Text = '';
    label_penfilename.Text = '';
    label_tapfilename.Text = '';
    label_logfilename.Text = '';
    label_resfilename.Text = '';

    edit_PenStart.Value = 0;
    edit_HP.Value = 0;
    edit_PenEnd.Value = 0;
    
        % Temperature above bottom water plot
        % --------------------------------------
        ylabel(axes_TempAboveBWT, 'Temperature relative to bottom water (°C)')
        zlabel(axes_TempAboveBWT, 'Z')
        axes_TempAboveBWT.AmbientLightColor = [0.9412 0.9412 0.9412];
        axes_TempAboveBWT.FontWeight = 'bold';
        axes_TempAboveBWT.XMinorTick = 'on';
        axes_TempAboveBWT.YMinorTick = 'on';
        axes_TempAboveBWT.Color = [0.9412 0.9412 0.9412];
        axes_TempAboveBWT.FontSize = 14;
        axes_TempAboveBWT.Box = 'on';
        axes_TempAboveBWT.Layout.Row = 1;
        axes_TempAboveBWT.Layout.Column = 1;
    
        % Bottom water tempearture plot
        % ------------------------------
        ylabel(axes_BottomWaterTemp, 'Bottom Water Temperature (°C)')
        zlabel(axes_BottomWaterTemp, 'Z')
        axes_BottomWaterTemp.FontWeight = 'bold';
        axes_BottomWaterTemp.XMinorTick = 'on';
        axes_BottomWaterTemp.YTickLabelRotation = 0;
        axes_BottomWaterTemp.Color = [0.9412 0.9412 0.9412];
        axes_BottomWaterTemp.Box = 'on';
        axes_BottomWaterTemp.Layout.Row = 2;
        axes_BottomWaterTemp.Layout.Column = 1;
    
        % Depth plot
        % ------------
        ylabel(axes_Depth, 'Depth (m)')
        zlabel(axes_Depth, 'Z')
        axes_Depth.FontWeight = 'bold';
        axes_Depth.YDir = 'reverse';
        axes_Depth.XMinorTick = 'on';
        axes_Depth.Color = [0.9412 0.9412 0.9412];
        axes_Depth.Box = 'on';
        axes_Depth.Layout.Row = 3;
        axes_Depth.Layout.Column = 1;
    
        % Tilt plot
        % ------------
        ylabel(axes_Tilt, 'Tilt (°)')
        zlabel(axes_Tilt, 'Z')
        axes_Tilt.FontWeight = 'bold';
        axes_Tilt.XTickLabelRotation = 0;
        axes_Tilt.XMinorTick = 'on';
        axes_Tilt.Color = [0.9412 0.9412 0.9412];
        axes_Tilt.TickDir = 'in';
        axes_Tilt.Box = 'on';
        axes_Tilt.Layout.Row = 4;
        axes_Tilt.Layout.Column = 1;
    
    %% RESET PLOT CONTROLS
    % --------------------
    
    checkbox_BottomWaterPlot.Enable = 'on';
    checkbox_DepthPlot.Enable = 'on';
    checkbox_TiltPlot.Enable = 'on';
    
    checkbox_BottomWaterPlot.Value = 1;
    checkbox_DepthPlot.Value = 1;
    checkbox_TiltPlot.Value = 1;

    %% RESET CHECKBOXES
    % -----------------
    for i = SensorsToUse
        PenCheckboxes{i}.Enable = 'on';
        FricCheckboxes{i}.Enable = 'on';
        HPCheckboxes{i}.Enable = 'on';

        PenCheckboxes{i}.Value = 1;
        FricCheckboxes{i}.Value = 1;
        HPCheckboxes{i}.Value = 1;
    end

    checkbox_UseWS.Enable = 'on';
    checkbox_UseHP.Enable = 'on';

    checkbox_UseWS.Value = 1;
    checkbox_UseHP.Value = 1;
    
    %% CLEAR PENETRATION INFO
    % ------------------------
    
    S_MATFile.S_PenHandles.StationName      = '';
    S_MATFile.S_PenHandles.Penetration      = '';
    S_MATFile.S_PenHandles.CruiseName       = '';
    S_MATFile.S_PenHandles.Datum            = '';
    S_MATFile.S_PenHandles.Latitude         = '';
    S_MATFile.S_PenHandles.Longitude        = '';
    S_MATFile.S_PenHandles.Depth            = '';
    S_MATFile.S_PenHandles.Tilt             = '';
    S_MATFile.S_PenHandles.LoggerId         = '';
    S_MATFile.S_PenHandles.ProbeId          = '';
    S_MATFile.S_PenHandles.NumberofSensors  = '';
    
    S_MATFile.S_PENVAR.PenetrationRecord    = 0 ;
    S_MATFile.S_PENVAR.HeatPulseRecord      = 0;
    S_MATFile.S_PENVAR.EndRecord            = 0;
    S_MATFile.S_PENVAR.BototmWaterRawData   = zeros(1, NumberOfSensors);
    S_MATFile.S_PENVAR.AllRecords           = zeros(80, 1);
    S_MATFile.S_PENVAR.AllSensorsRawData    = zeros(80, NumberOfSensors);
    S_MATFile.S_PENVAR.WaterSensorRawData   = zeros(80, 1);
    S_MATFile.S_PENVAR.EqmStartRecord       = 0;
    S_MATFile.S_PENVAR.EqmEndRecord         = 0;
    
    PrintStatus(ProgramLogId, '-- Resetting penetration information',2)

