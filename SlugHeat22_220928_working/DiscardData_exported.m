classdef DiscardData_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        figure_DiscardSensors  matlab.ui.Figure
        label_thermcon_2       matlab.ui.control.Label
        label_temp_2           matlab.ui.control.Label
        panel_thermcon         matlab.ui.container.Panel
        button_DiscardSensors  matlab.ui.control.Button
        panel_temp             matlab.ui.container.Panel
        label_thermcon         matlab.ui.control.Label
        label_temp             matlab.ui.control.Label
    end

    
    properties (Access = private)
        CallingApp 

        NumberOfSensors
        LogFileId
        ProgramLogId
        
        TempCheckboxes
        kCheckboxes
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, mainapp, IgnoredSensors, NumberOfSensors, AllSensors, h_axTempAboveBWT, LogFileId, ProgramLogId, Badk, BadT)
           app.CallingApp = mainapp;
           app.NumberOfSensors = NumberOfSensors;
           app.LogFileId = LogFileId;
           app.ProgramLogId = ProgramLogId;
           app.figure_DiscardSensors.WindowStyle = 'modal';
           movegui(app.figure_DiscardSensors, "center");
           Panels = {app.panel_temp, app.panel_thermcon};
           
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
           
                       for i=NumberOfSensors:-1:1
                           if n==1
                           app.TempCheckboxes{i} = uicheckbox(SensorGrids{i}, 'Text', '', ...
                               'Tooltip', ['Check to include data from sensor T' num2str(i) ...
                               ' in equilibrium temperature calculations'], ...
                             'tag',['temp_c_b_' num2str(i)]);
                           elseif n==2
                           app.kCheckboxes{i} = uicheckbox(SensorGrids{i}, 'Text', '', ...
                               'Tooltip', ['Check to include data from sensor T' num2str(i) ...
                               ' in thermal conductivity calculations'], ...
                             'tag',['k_c_b_' num2str(i)]);
                           end
                           
                           if any(Badk==i)
                               app.kCheckboxes{i}.Value = 0;
                           elseif any(BadT==i)
                               app.TempCheckboxes{i}.Value = 0;
                           else
                               app.TempCheckboxes{i}.Value = 1;                           
                               app.kCheckboxes{i}.Value = 1;  
                           end
                       end
           end
        end

        % Button pushed function: button_DiscardSensors
        function button_DiscardSensorsPushed(app, event)
            BadT = [];
            Badk = [];
            for i=app.NumberOfSensors:-1:1
                if app.TempCheckboxes{i}.Value == 0
                    BadT(i) = i;
                end
                if app.kCheckboxes{i}.Value == 0
                    Badk(i) = i;
                end
            end
            
            BadT(BadT==0) = [];
            Badk(Badk==0) = [];

            % Warn user before removing data
            % ------------------------------------
            confirmation = uiconfirm(app.figure_DiscardSensors, ['Recordings from all unchecked ' ...
                'sensors will be discarded and REMOVED from ' ...
                'data.' newline newline ...
                'Sensors discarded from equilibrium temperature calculations: ' newline int2str(BadT) newline ...
                'Sensors discarded from thermal conductivity calculations: ' newline int2str(Badk)], ...
                'Confirm sensor discard', 'Icon', 'warning');
            switch confirmation
            case 'OK'
            
                % Update LOG file to indicate which 
                % sensors are used and which are ignored
                % ----------------------------------------
                if isempty(Badk) && isempty(BadT)
                    PrintStatus(app.LogFileId,'All the sensors are used in processing!   ',2);
                else
                    PrintStatus(app.LogFileId,['These sensors are IGNORED in equilibrium temperature processing: ' ...
                            int2str(BadT)],2);
                    PrintStatus(app.LogFileId,['These sensors are IGNORED in thermal conductivity processing: ' ...
                            int2str(Badk)],2);
                end
                
	            PrintStatus(app.ProgramLogId, ['-- Removing bad data from sensors to be ignored ' ...
                    'in processing'],2);
            case 'Cancel'
                return
        
            end

            Status = 1;
            discardData(app.CallingApp, BadT, Badk, Status)
            
            delete(app)
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create figure_DiscardSensors and hide until all components are created
            app.figure_DiscardSensors = uifigure('Visible', 'off');
            app.figure_DiscardSensors.Color = [0.902 0.902 0.902];
            app.figure_DiscardSensors.Position = [100 100 525 945];
            app.figure_DiscardSensors.Name = 'MATLAB App';

            % Create label_temp
            app.label_temp = uilabel(app.figure_DiscardSensors);
            app.label_temp.HorizontalAlignment = 'center';
            app.label_temp.WordWrap = 'on';
            app.label_temp.FontName = 'Al Bayan';
            app.label_temp.FontSize = 20;
            app.label_temp.Position = [39 905 207 26];
            app.label_temp.Text = 'Sensors to include in';

            % Create label_thermcon
            app.label_thermcon = uilabel(app.figure_DiscardSensors);
            app.label_thermcon.HorizontalAlignment = 'center';
            app.label_thermcon.WordWrap = 'on';
            app.label_thermcon.FontName = 'Al Bayan';
            app.label_thermcon.FontSize = 20;
            app.label_thermcon.Position = [292 905 190 26];
            app.label_thermcon.Text = 'Sensors to include in';

            % Create panel_temp
            app.panel_temp = uipanel(app.figure_DiscardSensors);
            app.panel_temp.BorderType = 'none';
            app.panel_temp.TitlePosition = 'centertop';
            app.panel_temp.Position = [92 98 100 723];

            % Create button_DiscardSensors
            app.button_DiscardSensors = uibutton(app.figure_DiscardSensors, 'push');
            app.button_DiscardSensors.ButtonPushedFcn = createCallbackFcn(app, @button_DiscardSensorsPushed, true);
            app.button_DiscardSensors.WordWrap = 'on';
            app.button_DiscardSensors.BackgroundColor = [0.0039 0.3412 0.6078];
            app.button_DiscardSensors.FontName = 'Avenir Next';
            app.button_DiscardSensors.FontSize = 24;
            app.button_DiscardSensors.FontWeight = 'bold';
            app.button_DiscardSensors.FontAngle = 'italic';
            app.button_DiscardSensors.FontColor = [1 1 1];
            app.button_DiscardSensors.Position = [123 11 282 74];
            app.button_DiscardSensors.Text = 'Update data included in computations';

            % Create panel_thermcon
            app.panel_thermcon = uipanel(app.figure_DiscardSensors);
            app.panel_thermcon.BorderType = 'none';
            app.panel_thermcon.Position = [337 98 100 723];

            % Create label_temp_2
            app.label_temp_2 = uilabel(app.figure_DiscardSensors);
            app.label_temp_2.HorizontalAlignment = 'center';
            app.label_temp_2.WordWrap = 'on';
            app.label_temp_2.FontName = 'Al Bayan';
            app.label_temp_2.FontSize = 20;
            app.label_temp_2.FontWeight = 'bold';
            app.label_temp_2.FontAngle = 'italic';
            app.label_temp_2.Position = [24 831 237 65];
            app.label_temp_2.Text = 'equilibrium temperature calculations';

            % Create label_thermcon_2
            app.label_thermcon_2 = uilabel(app.figure_DiscardSensors);
            app.label_thermcon_2.HorizontalAlignment = 'center';
            app.label_thermcon_2.WordWrap = 'on';
            app.label_thermcon_2.FontName = 'Al Bayan';
            app.label_thermcon_2.FontSize = 20;
            app.label_thermcon_2.FontWeight = 'bold';
            app.label_thermcon_2.FontAngle = 'italic';
            app.label_thermcon_2.Position = [277 831 221 65];
            app.label_thermcon_2.Text = 'thermal conductivity calculations';

            % Show the figure after all components are created
            app.figure_DiscardSensors.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = DiscardData_exported(varargin)

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.figure_DiscardSensors)

            % Execute the startup function
            runStartupFcn(app, @(app)startupFcn(app, varargin{:}))

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.figure_DiscardSensors)
        end
    end
end