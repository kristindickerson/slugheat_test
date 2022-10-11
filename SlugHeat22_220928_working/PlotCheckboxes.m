%%% ==============================================================================
%   Purpose: 
%     This function plots all sensor checkbox panels for each tab, along
%     with callbacks for each checkbox to turn sensor lines on and off
%%% ==============================================================================

function [PenCheckboxes, ...
          FricCheckboxes, ...
          HPCheckboxes ...
          ] = PlotCheckboxes( ...
              SensorsToUse, ...
              NumberOfSensors, ...
              panel_PD_Thermistors, ...
              panel_FD_Thermistors, ...
              panel_HPD_Thermistors, ...
              panel_BA_Thermistors, ...
              panel_HF_Thermistors, ...
              panel_SA_Thermistors, ...
              h_axTempAboveBWT, ...
              h_axFricTempvTime, ...
              h_axFricTempvTau, ...
              h_axFricTempvTauPoints, ...
              h_axFricTempvTauLines, ...
              h_axFricRMSvTimeShift, ...
              h_axFricRMSvTimeShiftMinDelays, ...
              h_axHPTempvTime, ...
              h_axHPRMS, ...
              h_axHPRMSLine, ...
              h_axHPTempvInvTime, ...
              h_axHPTempvInvTimeBestFit, ...
              h_axHPTempvTimeShift, ...
              h_axHPTempvTimeShiftBestFit)

Panels = {panel_PD_Thermistors, panel_FD_Thermistors, ...
              panel_HPD_Thermistors, ...
              panel_BA_Thermistors, ...
              panel_HF_Thermistors, ...
              panel_SA_Thermistors};

for n=1:numel(Panels)

% Plot sensor checkboxes
% ----------------------

    % Grid layout for sensor panel
    % -----------------------------
        
        for i=NumberOfSensors:-1:1
            ThermistorGrid = uigridlayout(Panels{n}, 'BackgroundColor', ...
            [0.94 0.94 0.94], 'ColumnWidth', {'100x'}, 'RowHeight', cellstr(repmat('1x', NumberOfSensors, 1))');
        end


    % Create panels for each sensor
    % ------------------------------
        for i=NumberOfSensors:-1:1
            SensorPanels{i} = uipanel(ThermistorGrid, 'BorderType', ...
                'none', 'TitlePosition', 'centertop', ...
                'Title', [' T' num2str(i)], 'FontWeight', 'bold', ...
                'BackgroundColor', [0.94 0.94 0.94]);
        end


    % Grid layout for each sensor
    % -----------------------------
        for i=NumberOfSensors:-1:1
            SensorGrids{i} = uigridlayout(SensorPanels{i}, 'ColumnWidth', ...
                {'100x'}, 'RowHeight', {'100x'}, 'Padding',[5 5 5 5], ...
                'BackgroundColor', h_axTempAboveBWT(i).Color);
        end

    % Checkbox for each sensor
    % -----------------------------

      for i=NumberOfSensors:-1:1
          if n==1
              PenCheckboxes{i} = uicheckbox(SensorGrids{i}, 'Text', '', ...
                  'Value',true, 'Tooltip', ['Check to display data from sensor T' num2str(i) ' on plots'], ...
                  'tag',['c_b_' num2str(i)]);
                  
              drawnow;
              
              if ~ismember(i, SensorsToUse)
                  PenCheckboxes{i}.Enable = 'off';
                  PenCheckboxes{i}.Value = 0;
              end

          elseif n==2
              FricCheckboxes{i} = uicheckbox(SensorGrids{i}, 'Text', '', ...
                  'Value',true, 'Tooltip', ['Check to display data from sensor T' num2str(i) ' on plots'], ...
                  'tag',['c_b_' num2str(i)]);
              drawnow;

              if ~ismember(i, SensorsToUse)
                  FricCheckboxes{i}.Enable = 'off';
                  FricCheckboxes{i}.Value = 0;
              end

          elseif n==3
              HPCheckboxes{i} = uicheckbox(SensorGrids{i}, 'Text', '', ...
                  'Value',true, 'Tooltip', ['Check to display data from sensor T' num2str(i) ' on plots'], ...
                  'tag',['c_b_' num2str(i)]);


              if ~ismember(i, SensorsToUse)
                  FricCheckboxes{i}.Enable = 'off';
                  FricCheckboxes{i}.Value = 0;
              end
              
          end
      end

end



    for i=SensorsToUse
    PenCheckboxes{i}.ValueChangedFcn = {@cbValueChange, ...
                  h_axTempAboveBWT(i), ...
                  h_axFricTempvTime(i), ...
                  h_axFricTempvTau(i), ...
                  h_axFricTempvTauPoints(i), ...
                  h_axFricTempvTauLines(i), ...
                  h_axFricRMSvTimeShift(i), ...
                  h_axFricRMSvTimeShiftMinDelays(i), ...
                  h_axHPTempvTime(i), ...
                  h_axHPRMS(i), ...
                  h_axHPRMSLine(i), ...
                  h_axHPTempvInvTime(i), ...
                  h_axHPTempvInvTimeBestFit(i), ...
                  h_axHPTempvTimeShift(i), ...
                  h_axHPTempvTimeShiftBestFit(i), ...
                  PenCheckboxes(i), ...
                  FricCheckboxes(i), ...
                  HPCheckboxes(i)};
    end
    for i=SensorsToUse
    FricCheckboxes{i}.ValueChangedFcn = {@cbValueChange, ...
                  h_axTempAboveBWT(i), ...
                  h_axFricTempvTime(i), ...
                  h_axFricTempvTau(i), ...
                  h_axFricTempvTauPoints(i), ...
                  h_axFricTempvTauLines(i), ...
                  h_axFricRMSvTimeShift(i), ...
                  h_axFricRMSvTimeShiftMinDelays(i), ...
                  h_axHPTempvTime(i), ...
                  h_axHPRMS(i), ...
                  h_axHPRMSLine(i), ...
                  h_axHPTempvInvTime(i), ...
                  h_axHPTempvInvTimeBestFit(i), ...
                  h_axHPTempvTimeShift(i), ...
                  h_axHPTempvTimeShiftBestFit(i), ...
                  PenCheckboxes(i), ...
                  FricCheckboxes(i), ...
                  HPCheckboxes(i)};
    end
    for i=SensorsToUse
    HPCheckboxes{i}.ValueChangedFcn = {@cbValueChange, ...
                  h_axTempAboveBWT(i), ...
                  h_axFricTempvTime(i), ...
                  h_axFricTempvTau(i), ...
                  h_axFricTempvTauPoints(i), ...
                  h_axFricTempvTauLines(i), ...
                  h_axFricRMSvTimeShift(i), ...
                  h_axFricRMSvTimeShiftMinDelays(i), ...
                  h_axHPTempvTime(i), ...
                  h_axHPRMS(i), ...
                  h_axHPRMSLine(i), ...
                  h_axHPTempvInvTime(i), ...
                  h_axHPTempvInvTimeBestFit(i), ...
                  h_axHPTempvTimeShift(i), ...
                  h_axHPTempvTimeShiftBestFit(i), ...
                  PenCheckboxes(i), ...
                  FricCheckboxes(i), ...
                  HPCheckboxes(i)};
    end