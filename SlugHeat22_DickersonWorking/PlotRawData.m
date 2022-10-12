%%% ==============================================================================
%   Purpose: 
%     This function plots the inital raw data from the penetration and tap file
%     before any other processing has been done, except correcting temperature
%     of each thermistor with reference to bottom water. These plots are found under 
%     the Penetration Data tab on SlugHeat GUI.
%%% ==============================================================================

function    [BadT, Badk, S_Lines, AllSensors, ...
            h_axTempAboveBWT ...
            ] = ...
            PlotRawData(figure_Main, axes_TempAboveBWT, ...
            axes_BottomWaterTemp, ...
            axes_Depth, axes_Tilt, ...
            checkbox_BottomWaterPlot, ...
            checkbox_UseWS, ...
            checkbox_DepthPlot, checkbox_TiltPlot, ...
            AllSensorsTemp, ...
            NumberOfSensors, ...
            WaterThermistor, ...
            WaterSensorTemp, ...
            Tilt, TiltMean, ...
            Depth, DepthMean, ...
            TAPRecord, LogFileId, ...
            AllRecords, PenetrationRecord, HeatPulseRecord, EndRecord, ... 
            PulseData, ProgramLogId, grid_PenetrationInfo)

% Error trap if there is no bottom water thermistor
% --------------------------------------------------
%[~, NC] = size(AllSensorsTemp);
%if NC ~= NumberOfSensors
%    uialert(figure_Main, 'There is no bottom water sensor found. Update parameters before continuing', ...
%        'Error','Icon', 'error')
%    return
%end

% Define variables to be used in this function
% ---------------------------------------------

    BadT = [];
    Badk = [];

% Define plot colormap
% --------------------
    CMap= colormap(axes_TempAboveBWT, 'turbo');
    CMap = flipud(CMap);
    CMap = interp1(1:256,CMap,1:256/(NumberOfSensors):256); 
    colormap(axes_TempAboveBWT, CMap);


% Plot temperatures of all sensors, EXCEPT bottom water sensor on main plot
% -------------------------------------------------------------------------
    AllSensors = zeros(1, NumberOfSensors);
    for i=NumberOfSensors:-1:1
        % Plot by record number
    h_axTempAboveBWT(i) = plot(axes_TempAboveBWT, AllRecords,AllSensorsTemp(:,i),'-o','markersize',2, ...
        'Color',CMap(i,:),'markerfacecolor',CMap(i,:), 'tag', ['sensTemp_' num2str(i)]);    
    TempYLabel = ylabel(axes_TempAboveBWT, 'Temperature relative to bottom water (°C)', 'FontWeight', 'bold', 'FontSize',16);
    axes_TempAboveBWT.Color = [0.94,0.94,0.94];
    axes_TempAboveBWT.XMinorTick='on';
    axes_TempAboveBWT.YMinorTick= 'on';
                            
    hold(axes_TempAboveBWT, 'on');
    AllSensors(i) = i;
    end
    drawnow

    
% Plot temperatures of bottom water sensor
% --------------------------------------------
    if WaterThermistor == 1
       h_axBWT = plot(axes_BottomWaterTemp, AllRecords,WaterSensorTemp,'k-','markersize',3);
       BWTYLabel = ylabel(axes_BottomWaterTemp, '    Bottom Water Temperature  (°C)', 'FontWeight','bold');
       axes_BottomWaterTemp.Color = [0.94,0.94,0.94];
    else
        checkbox_BottomWaterPlot.Value = 0;
        checkbox_BottomWaterPlot.Enable = 'off';
        checkbox_UseWS.Value = 0;
        checkbox_UseWS.Enable = 'off';
    end
    drawnow;

% Plot depth sensor data 
% ------------------------
    if ~isempty(TAPRecord)
        plot(axes_Depth, TAPRecord, Depth, '-b', 'MarkerSize',3)
        DepthYLabel = ylabel(axes_Depth, 'Depth (m)', 'FontWeight','bold');
        axes_Depth.Color = [0.94,0.94,0.94];
        axes_Depth.YTickLabelRotation = 15;
        axes_Depth.YDir = 'reverse';
    else
        uialert(figure_Main, ['There is no tilt and pressure (TAP) record found.' fprintf('\n') 'Average depth = ' num2str(DepthMean) ' m'],'File not found', 'Icon', 'warning');
        checkbox_DepthPlot.Value = 0;
        checkbox_DepthPlot.Enable = 'off';
    end
    drawnow;

% Plot tilt sensor data
% ------------------------
    if ~isempty(TAPRecord)
        plot(axes_Tilt, TAPRecord, Tilt, '-r', 'MarkerSize',3);
        TiltYLabel = ylabel(axes_Tilt, 'Tilt (°)', 'FontWeight','bold');
        axes_Tilt.Color = [0.94,0.94,0.94];
        
    else
        uialert(figure_Main,['There is no tilt and pressure (TAP) record.' fprintf('\n') 'Average tilt = ' num2str(TiltMean) '°'], 'File not found', 'Icon', 'warning');
        checkbox_TiltPlot.Value = 0;
        checkbox_TiltPlot.Enable = 'off';
        grid_PenetrationInfo.RowHeight = {'1x', '1x', '0x', '0x'};
    end
    drawnow;
    
% Plot lines for start and end of penetration and heat pulse
% -----------------------------------------------------------
    PenLine = xline(axes_TempAboveBWT, PenetrationRecord, '--k', ...
        'FontWeight', 'bold', 'FontSize', 16);
    PenLine.Label = 'Start of Penetration';
    PenBWTLine = xline(axes_BottomWaterTemp, PenetrationRecord, '--k');
    PenDepthLine = xline(axes_Depth, PenetrationRecord, '--k');
    PenTiltLine = xline(axes_Tilt, PenetrationRecord, '--k');
    
    if PulseData
        HPLine = xline(axes_TempAboveBWT, HeatPulseRecord, '--k', ...
            'FontWeight', 'bold', 'LabelHorizontalAlignment','left', ...
            'FontSize', 16);
        HPLine.Label = 'Heat Pulse';
        HPBWTLine = xline(axes_BottomWaterTemp, HeatPulseRecord, '--k');
        HPDepthLine = xline(axes_Depth, HeatPulseRecord, '--k');
        HPTiltLine = xline(axes_Tilt, HeatPulseRecord, '--k');
    end

    EndLine = xline(axes_TempAboveBWT, EndRecord, '--k', ...
        'LabelHorizontalAlignment','left', 'FontWeight', 'bold', ...
        'FontSize', 16);
    EndLine.Label = 'End of Penetration';
    EndBWTLine = xline(axes_BottomWaterTemp, EndRecord, '--k');
    EndDepthLine = xline(axes_Depth, EndRecord, '--k');
    EndTiltLine = xline(axes_Tilt, EndRecord, '--k');
    drawnow;

    S_PenLines = struct('PenLine', PenLine, 'PenBWTLine', PenBWTLine, 'PenDepthLine', ...
        PenDepthLine, 'PenTiltLine', PenTiltLine);
    S_HPLines = struct('HPLine', HPLine, 'HPBWTLine', ...
        HPBWTLine, 'HPDepthLine', HPDepthLine, 'HPTiltLine', HPTiltLine);
    S_EndPenLines = struct('EndLine', EndLine, 'EndBWTLine', EndBWTLine, 'EndDepthLine', EndDepthLine, ...
        'EndTiltLine', EndTiltLine);

    S_Lines = struct('S_PenLines', S_PenLines, 'S_HPLines', S_HPLines, ...
        'S_EndPenLines', S_EndPenLines);
 
% Link X axes of all four plots -- zooming or panning on one does the same to
% rest
% -------------------------------------------------------------------------
    
    ax=[axes_TempAboveBWT axes_BottomWaterTemp axes_Depth axes_Tilt];
    linkaxes(ax,'x');
    TempPreHP = AllSensorsTemp(AllRecords<HeatPulseRecord);
    xlim(axes_TempAboveBWT, [(PenetrationRecord-5), (EndRecord+1)])
    ylim(axes_TempAboveBWT, [0, max(TempPreHP)*2])
    

% Save all variables created so far in a MAT file and update LOG file
% ------------------------------------------------------------------------
    %save(['SlugHeat22_' PenFileName])
    
    PrintStatus(LogFileId,[datestr(datetime('now')) ' - End of raw data reading and preparation !'],1);
    PrintStatus(LogFileId,'==========================================================================',3);

    PrintStatus(ProgramLogId, '-- Plotting unprocessed penetration data on "Penetration Data" tab',2)

end



