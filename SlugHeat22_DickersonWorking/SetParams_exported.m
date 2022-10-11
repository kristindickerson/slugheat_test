classdef SetParams_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        figure_SetParams                matlab.ui.Figure
        panel_Main                      matlab.ui.container.Panel
        edit_SAkMax                     matlab.ui.control.NumericEditField
        edit_SAkMin                     matlab.ui.control.NumericEditField
        label_SAkMax                    matlab.ui.control.Label
        label_SAMin                     matlab.ui.control.Label
        label_SAkBounds                 matlab.ui.control.Label
        BoundaryConditionsLabel         matlab.ui.control.Label
        edit_kInit_7                    matlab.ui.control.NumericEditField
        label_kniit_1                   matlab.ui.control.Label
        edit_ManOffset                  matlab.ui.control.NumericEditField
        MaxstepsinfrictiondecayLabel_2  matlab.ui.control.Label
        edit_WaterCorrectionType        matlab.ui.control.NumericEditField
        WaterCorrectionTypeLabel        matlab.ui.control.Label
        TemperatureCalibrationInformationLabel  matlab.ui.control.Label
        edit_InitTimeShift              matlab.ui.control.NumericEditField
        InitialtimeshiftLabel_2         matlab.ui.control.Label
        edit_MaxkIter                   matlab.ui.control.NumericEditField
        MinimumchangeofSigmakLabel_2    matlab.ui.control.Label
        edit_MinSigChange               matlab.ui.control.NumericEditField
        MinimumchangeofSigmakLabel      matlab.ui.control.Label
        edit_TimeShiftInc               matlab.ui.control.NumericEditField
        InitialtimeshiftLabel           matlab.ui.control.Label
        UpdateParametersButton          matlab.ui.control.Button
        edit_HPTimeDelay                matlab.ui.control.NumericEditField
        HeatpulsetimedelaysEditFieldLabel  matlab.ui.control.Label
        edit_FricTimeDelay              matlab.ui.control.NumericEditField
        FrictionaltimedelaysEditFieldLabel  matlab.ui.control.Label
        edit_HPTauMax                   matlab.ui.control.NumericEditField
        edit_HPTauMin                   matlab.ui.control.NumericEditField
        edit_FricTauMax                 matlab.ui.control.NumericEditField
        edit_FricTauMin                 matlab.ui.control.NumericEditField
        label_HPTauMax                  matlab.ui.control.Label
        label_HPTauMin                  matlab.ui.control.Label
        label_HPTau                     matlab.ui.control.Label
        label_FricTauMax                matlab.ui.control.Label
        label_FricTauMin                matlab.ui.control.Label
        label_FricTau                   matlab.ui.control.Label
        edit_kInit_6                    matlab.ui.control.NumericEditField
        edit_kInit_5                    matlab.ui.control.NumericEditField
        edit_kInit_4                    matlab.ui.control.NumericEditField
        edit_kInit_3                    matlab.ui.control.NumericEditField
        edit_kInit_2                    matlab.ui.control.NumericEditField
        edit_kInit_1                    matlab.ui.control.NumericEditField
        label_kInit                     matlab.ui.control.Label
        edit_HyndCo_3                   matlab.ui.control.NumericEditField
        edit_HyndCo_2                   matlab.ui.control.NumericEditField
        edit_HyndCo_1                   matlab.ui.control.NumericEditField
        label_HyndCo                    matlab.ui.control.Label
        edit_DepthFirstTherm            matlab.ui.control.NumericEditField
        DepthoffirstthermistorbelowweightstandEditFieldLabel  matlab.ui.control.Label
        edit_UseFricDecayNoHP           matlab.ui.control.NumericEditField
        usefrictionaldecatfornoheatpulsesensitivityanalysis1Yes2NoLabel  matlab.ui.control.Label
        edit_HorizkAnisotropy           matlab.ui.control.NumericEditField
        HorizontalthermalconductivityanisotropyEditFieldLabel  matlab.ui.control.Label
        edit_MaxFricSteps               matlab.ui.control.NumericEditField
        MaxstepsinfrictiondecayLabel    matlab.ui.control.Label
        edit_PulsePower                 matlab.ui.control.NumericEditField
        PulsepowerperlengthJmEditFieldLabel  matlab.ui.control.Label
        edit_MinThickness               matlab.ui.control.NumericEditField
        MininumlayerthicknessforSensitivityanalysisEditFieldLabel  matlab.ui.control.Label
        edit_SAStandDev                 matlab.ui.control.NumericEditField
        StandarddeviationinkforSensitivityanalysisEditFieldLabel  matlab.ui.control.Label
        edit_HPDuration                 matlab.ui.control.NumericEditField
        DurationofheatpulsesEditFieldLabel  matlab.ui.control.Label
        edit_TempError                  matlab.ui.control.NumericEditField
        AssumedtemperatureerrorKEditFieldLabel  matlab.ui.control.Label
        edit_SAIterNum                  matlab.ui.control.NumericEditField
        NumberofIterationsforSensitivityanalysisEditFieldLabel  matlab.ui.control.Label
        edit_SensorSpacing              matlab.ui.control.NumericEditField
        edit_SensorRadius               matlab.ui.control.NumericEditField
        DistancebetweensensorsmEditFieldLabel  matlab.ui.control.Label
        RadiusofsensormLabel            matlab.ui.control.Label
        edit_HPTimeInc                  matlab.ui.control.NumericEditField
        TimeincrementinheatpulsedecaysEditFieldLabel  matlab.ui.control.Label
        edit_HPMaxSteps                 matlab.ui.control.NumericEditField
        MaxstepsinheatpulsedecayEditFieldLabel  matlab.ui.control.Label
        edit_ThermTiming                matlab.ui.control.NumericEditField
        TimebeteenthermistorreadingssLabel  matlab.ui.control.Label
        edit_WaterTempSensor            matlab.ui.control.NumericEditField
        Watertemperaturethermistor1Yes2NoLabel  matlab.ui.control.Label
        edit_ErrorTolerance             matlab.ui.control.NumericEditField
        edit_TimeScaling                matlab.ui.control.NumericEditField
        edit_NumSensors                 matlab.ui.control.NumericEditField
        ErrortoleranceonthermalconductivityiterationEditFieldLabel  matlab.ui.control.Label
        TimescalingfactorsecunitEditFieldLabel  matlab.ui.control.Label
        NumberofSensorsLabel            matlab.ui.control.Label
    end

    
    properties (Access = public)
      
    end
    
    properties (Access = private)
        CallingApp

        HyndCo
        kInitMat
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, mainapp, watercorrect, offset, numsen, watertherm, timescale, deltatime, sensrad, sensdist, temperror, hyndco, fricdelay, fricmaxstep, timeinc, frictaumin, frictaumax, pulsedelay, kinit, pulsepow, timshiftinit, timeshiftinc, pulsemaxstep, ktol, pulsetaumin, pulsetaumax, HPlength, minkchange, maxiter, maxSAiter, sigk, kmin, kmax, minthick, usefric, kAni, topsensor)
            app.CallingApp = mainapp;
            app.figure_SetParams.WindowStyle = 'modal';
            movegui(app.figure_SetParams, "center");
            
            app.edit_WaterCorrectionType.Value   = watercorrect;
            app.edit_ManOffset.Value             = offset;
            app.edit_NumSensors.Value            = numsen;
            app.edit_WaterTempSensor.Value       = watertherm;
            app.edit_TimeScaling.Value           = timescale;
            app.edit_ThermTiming.Value           = deltatime;
            app.edit_SensorRadius.Value          = sensrad;
            app.edit_SensorSpacing.Value         = sensdist;
            app.edit_TempError.Value             = temperror;
            app.edit_HyndCo_1.Value              = hyndco(1); 
            app.edit_HyndCo_2.Value              = hyndco(2);
            app.edit_HyndCo_3.Value              = hyndco(3);
            app.edit_FricTimeDelay.Value         = fricdelay(1);
            app.edit_MaxFricSteps.Value          = fricmaxstep;
            app.edit_HPTimeInc.Value             = timeinc;
            app.edit_FricTauMin.Value            = frictaumin;
            app.edit_FricTauMax.Value            = frictaumax;
            app.edit_HPTimeDelay.Value           = pulsedelay(1);
            app.edit_kInit_1.Value               = kinit(1);
            app.edit_kInit_2.Value               = kinit(2);
            app.edit_kInit_3.Value               = kinit(3);
            app.edit_kInit_4.Value               = kinit(4);
            app.edit_kInit_5.Value               = kinit(5);
            app.edit_kInit_6.Value               = kinit(6);
            app.edit_kInit_7.Value               = kinit(7);
            app.edit_PulsePower.Value            = pulsepow;
            app.edit_InitTimeShift.Value         = timshiftinit;
            app.edit_TimeShiftInc.Value          = timeshiftinc;
            app.edit_HPMaxSteps.Value            = pulsemaxstep;
            app.edit_ErrorTolerance.Value        = ktol;
            app.edit_HPTauMin.Value              = pulsetaumin;
            app.edit_HPTauMax.Value              = pulsetaumax;
            app.edit_HPDuration.Value            = HPlength;
            app.edit_MinSigChange.Value          = minkchange;
            app.edit_MaxkIter.Value              = maxiter;
            app.edit_SAIterNum.Value             = maxSAiter;
            app.edit_SAStandDev.Value            = sigk;
            app.edit_SAkMin.Value                = kmin;
            app.edit_SAkMax.Value                = kmax;
            app.edit_MinThickness.Value          = minthick;
            app.edit_UseFricDecayNoHP.Value      = usefric;
            app.edit_HorizkAnisotropy.Value      = kAni;
            app.edit_DepthFirstTherm.Value       = topsensor;

           
        
        end

        % Button pushed function: UpdateParametersButton
        function UpdateParametersButtonPushed(app, event)
            app.HyndCo = [app.edit_HyndCo_1.Value app.edit_HyndCo_2.Value app.edit_HyndCo_3.Value];
            app.kInitMat = [app.edit_kInit_1.Value app.edit_kInit_2.Value app.edit_kInit_3.Value app.edit_kInit_4.Value app.edit_kInit_5.Value app.edit_kInit_6.Value app.edit_kInit_7.Value];

    
            setParams(app.CallingApp, app.edit_WaterCorrectionType.Value, app.edit_ManOffset.Value, ...
                app.edit_NumSensors.Value, app.edit_WaterTempSensor.Value, ...
                app.edit_TimeScaling.Value, app.edit_ThermTiming.Value, ...
                app.edit_SensorRadius.Value, app.edit_SensorSpacing.Value, ...
                app.edit_TempError.Value, app.HyndCo(:), ...
                app.edit_FricTimeDelay.Value, app.edit_MaxFricSteps.Value, ...
                app.edit_HPTimeInc.Value, app.edit_FricTauMin.Value, ...
                app.edit_FricTauMax.Value, app.edit_HPTimeDelay.Value, ...
                app.kInitMat(:), app.edit_PulsePower.Value, app.edit_InitTimeShift.Value, ...
                app.edit_TimeShiftInc.Value, app.edit_HPMaxSteps.Value, ...
                app.edit_ErrorTolerance.Value, app.edit_HPTauMin.Value, app.edit_HPTauMax.Value, ...
                app.edit_HPDuration.Value, app.edit_MinSigChange.Value, app.edit_MaxkIter.Value, ...
                app.edit_SAIterNum.Value, app.edit_SAStandDev.Value, app.edit_SAkMin.Value, ...
                app.edit_SAkMax.Value, app.edit_MinThickness.Value, app.edit_UseFricDecayNoHP.Value, ...
                app.edit_HorizkAnisotropy.Value, app.edit_DepthFirstTherm.Value)

            delete(app)
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create figure_SetParams and hide until all components are created
            app.figure_SetParams = uifigure('Visible', 'off');
            app.figure_SetParams.Position = [100 100 1126 879];
            app.figure_SetParams.Name = 'MATLAB App';

            % Create panel_Main
            app.panel_Main = uipanel(app.figure_SetParams);
            app.panel_Main.TitlePosition = 'centertop';
            app.panel_Main.Title = 'Set Default Parameters';
            app.panel_Main.BackgroundColor = [0.9412 0.9412 0.9412];
            app.panel_Main.FontAngle = 'italic';
            app.panel_Main.FontWeight = 'bold';
            app.panel_Main.FontSize = 24;
            app.panel_Main.Position = [1 1 1126 879];

            % Create NumberofSensorsLabel
            app.NumberofSensorsLabel = uilabel(app.panel_Main);
            app.NumberofSensorsLabel.WordWrap = 'on';
            app.NumberofSensorsLabel.FontSize = 14;
            app.NumberofSensorsLabel.Position = [35 755 138 67];
            app.NumberofSensorsLabel.Text = 'Number of Sensors (excluding water termperature sensor):';

            % Create TimescalingfactorsecunitEditFieldLabel
            app.TimescalingfactorsecunitEditFieldLabel = uilabel(app.panel_Main);
            app.TimescalingfactorsecunitEditFieldLabel.WordWrap = 'on';
            app.TimescalingfactorsecunitEditFieldLabel.FontSize = 14;
            app.TimescalingfactorsecunitEditFieldLabel.Position = [320 767 103 44];
            app.TimescalingfactorsecunitEditFieldLabel.Text = 'Time scaling factor (sec/unit):';

            % Create ErrortoleranceonthermalconductivityiterationEditFieldLabel
            app.ErrortoleranceonthermalconductivityiterationEditFieldLabel = uilabel(app.panel_Main);
            app.ErrortoleranceonthermalconductivityiterationEditFieldLabel.WordWrap = 'on';
            app.ErrortoleranceonthermalconductivityiterationEditFieldLabel.FontSize = 14;
            app.ErrortoleranceonthermalconductivityiterationEditFieldLabel.Position = [583 609 180 68];
            app.ErrortoleranceonthermalconductivityiterationEditFieldLabel.Text = 'Error tolerance on thermal conductivity iteration:';

            % Create edit_NumSensors
            app.edit_NumSensors = uieditfield(app.panel_Main, 'numeric');
            app.edit_NumSensors.FontSize = 14;
            app.edit_NumSensors.Position = [203 789 33 22];

            % Create edit_TimeScaling
            app.edit_TimeScaling = uieditfield(app.panel_Main, 'numeric');
            app.edit_TimeScaling.FontSize = 14;
            app.edit_TimeScaling.Position = [460 778 33 22];

            % Create edit_ErrorTolerance
            app.edit_ErrorTolerance = uieditfield(app.panel_Main, 'numeric');
            app.edit_ErrorTolerance.FontSize = 14;
            app.edit_ErrorTolerance.Position = [773 639 52 22];

            % Create Watertemperaturethermistor1Yes2NoLabel
            app.Watertemperaturethermistor1Yes2NoLabel = uilabel(app.panel_Main);
            app.Watertemperaturethermistor1Yes2NoLabel.WordWrap = 'on';
            app.Watertemperaturethermistor1Yes2NoLabel.FontSize = 14;
            app.Watertemperaturethermistor1Yes2NoLabel.Position = [35 674 127 51];
            app.Watertemperaturethermistor1Yes2NoLabel.Text = {'Water temperature thermistor             '; '(1:Yes   2:No)'};

            % Create edit_WaterTempSensor
            app.edit_WaterTempSensor = uieditfield(app.panel_Main, 'numeric');
            app.edit_WaterTempSensor.FontSize = 14;
            app.edit_WaterTempSensor.Position = [203 689 33 22];

            % Create TimebeteenthermistorreadingssLabel
            app.TimebeteenthermistorreadingssLabel = uilabel(app.panel_Main);
            app.TimebeteenthermistorreadingssLabel.WordWrap = 'on';
            app.TimebeteenthermistorreadingssLabel.FontSize = 14;
            app.TimebeteenthermistorreadingssLabel.Position = [320 686 131 51];
            app.TimebeteenthermistorreadingssLabel.Text = 'Time between thermistor readings (s): ';

            % Create edit_ThermTiming
            app.edit_ThermTiming = uieditfield(app.panel_Main, 'numeric');
            app.edit_ThermTiming.FontSize = 14;
            app.edit_ThermTiming.Position = [460 701 33 22];

            % Create MaxstepsinheatpulsedecayEditFieldLabel
            app.MaxstepsinheatpulsedecayEditFieldLabel = uilabel(app.panel_Main);
            app.MaxstepsinheatpulsedecayEditFieldLabel.WordWrap = 'on';
            app.MaxstepsinheatpulsedecayEditFieldLabel.FontSize = 14;
            app.MaxstepsinheatpulsedecayEditFieldLabel.Position = [583 508 121 53];
            app.MaxstepsinheatpulsedecayEditFieldLabel.Text = 'Max steps in heat pulse decay:';

            % Create edit_HPMaxSteps
            app.edit_HPMaxSteps = uieditfield(app.panel_Main, 'numeric');
            app.edit_HPMaxSteps.FontSize = 14;
            app.edit_HPMaxSteps.Position = [773 531 33 22];

            % Create TimeincrementinheatpulsedecaysEditFieldLabel
            app.TimeincrementinheatpulsedecaysEditFieldLabel = uilabel(app.panel_Main);
            app.TimeincrementinheatpulsedecaysEditFieldLabel.WordWrap = 'on';
            app.TimeincrementinheatpulsedecaysEditFieldLabel.FontSize = 14;
            app.TimeincrementinheatpulsedecaysEditFieldLabel.Position = [875 525 125 53];
            app.TimeincrementinheatpulsedecaysEditFieldLabel.Text = 'Time increment in heat pulse decay (s):';

            % Create edit_HPTimeInc
            app.edit_HPTimeInc = uieditfield(app.panel_Main, 'numeric');
            app.edit_HPTimeInc.FontSize = 14;
            app.edit_HPTimeInc.Position = [1062 548 33 22];

            % Create RadiusofsensormLabel
            app.RadiusofsensormLabel = uilabel(app.panel_Main);
            app.RadiusofsensormLabel.WordWrap = 'on';
            app.RadiusofsensormLabel.FontSize = 14;
            app.RadiusofsensormLabel.Position = [35 591 116 53];
            app.RadiusofsensormLabel.Text = 'Radius of sensor (m):';

            % Create DistancebetweensensorsmEditFieldLabel
            app.DistancebetweensensorsmEditFieldLabel = uilabel(app.panel_Main);
            app.DistancebetweensensorsmEditFieldLabel.WordWrap = 'on';
            app.DistancebetweensensorsmEditFieldLabel.FontSize = 14;
            app.DistancebetweensensorsmEditFieldLabel.Position = [320 603 127 53];
            app.DistancebetweensensorsmEditFieldLabel.Text = 'Distance between sensors (m): ';

            % Create edit_SensorRadius
            app.edit_SensorRadius = uieditfield(app.panel_Main, 'numeric');
            app.edit_SensorRadius.FontSize = 14;
            app.edit_SensorRadius.Position = [203 613 52 22];

            % Create edit_SensorSpacing
            app.edit_SensorSpacing = uieditfield(app.panel_Main, 'numeric');
            app.edit_SensorSpacing.FontSize = 14;
            app.edit_SensorSpacing.Position = [460 621 33 22];

            % Create NumberofIterationsforSensitivityanalysisEditFieldLabel
            app.NumberofIterationsforSensitivityanalysisEditFieldLabel = uilabel(app.panel_Main);
            app.NumberofIterationsforSensitivityanalysisEditFieldLabel.WordWrap = 'on';
            app.NumberofIterationsforSensitivityanalysisEditFieldLabel.FontSize = 14;
            app.NumberofIterationsforSensitivityanalysisEditFieldLabel.Position = [583 417 184 51];
            app.NumberofIterationsforSensitivityanalysisEditFieldLabel.Text = 'Number of Iterations for Sensitivity analysis';

            % Create edit_SAIterNum
            app.edit_SAIterNum = uieditfield(app.panel_Main, 'numeric');
            app.edit_SAIterNum.FontSize = 14;
            app.edit_SAIterNum.Position = [773 433 33 22];

            % Create AssumedtemperatureerrorKEditFieldLabel
            app.AssumedtemperatureerrorKEditFieldLabel = uilabel(app.panel_Main);
            app.AssumedtemperatureerrorKEditFieldLabel.WordWrap = 'on';
            app.AssumedtemperatureerrorKEditFieldLabel.FontSize = 14;
            app.AssumedtemperatureerrorKEditFieldLabel.Position = [35 508 111 53];
            app.AssumedtemperatureerrorKEditFieldLabel.Text = 'Assumed temperature error (K):';

            % Create edit_TempError
            app.edit_TempError = uieditfield(app.panel_Main, 'numeric');
            app.edit_TempError.FontSize = 14;
            app.edit_TempError.Position = [203 533 52 22];

            % Create DurationofheatpulsesEditFieldLabel
            app.DurationofheatpulsesEditFieldLabel = uilabel(app.panel_Main);
            app.DurationofheatpulsesEditFieldLabel.WordWrap = 'on';
            app.DurationofheatpulsesEditFieldLabel.FontSize = 14;
            app.DurationofheatpulsesEditFieldLabel.Position = [320 520 97 53];
            app.DurationofheatpulsesEditFieldLabel.Text = 'Duration of heat pulse (s):';

            % Create edit_HPDuration
            app.edit_HPDuration = uieditfield(app.panel_Main, 'numeric');
            app.edit_HPDuration.FontSize = 14;
            app.edit_HPDuration.Position = [460 540 33 22];

            % Create StandarddeviationinkforSensitivityanalysisEditFieldLabel
            app.StandarddeviationinkforSensitivityanalysisEditFieldLabel = uilabel(app.panel_Main);
            app.StandarddeviationinkforSensitivityanalysisEditFieldLabel.WordWrap = 'on';
            app.StandarddeviationinkforSensitivityanalysisEditFieldLabel.FontSize = 14;
            app.StandarddeviationinkforSensitivityanalysisEditFieldLabel.Position = [583 318 179 51];
            app.StandarddeviationinkforSensitivityanalysisEditFieldLabel.Text = 'Standard deviation in k for Sensitivity analysis:';

            % Create edit_SAStandDev
            app.edit_SAStandDev = uieditfield(app.panel_Main, 'numeric');
            app.edit_SAStandDev.FontSize = 14;
            app.edit_SAStandDev.Position = [773 342 33 22];

            % Create MininumlayerthicknessforSensitivityanalysisEditFieldLabel
            app.MininumlayerthicknessforSensitivityanalysisEditFieldLabel = uilabel(app.panel_Main);
            app.MininumlayerthicknessforSensitivityanalysisEditFieldLabel.WordWrap = 'on';
            app.MininumlayerthicknessforSensitivityanalysisEditFieldLabel.FontSize = 14;
            app.MininumlayerthicknessforSensitivityanalysisEditFieldLabel.Position = [875 360 169 51];
            app.MininumlayerthicknessforSensitivityanalysisEditFieldLabel.Text = 'Mininum layer thickness for Sensitivity analysis';

            % Create edit_MinThickness
            app.edit_MinThickness = uieditfield(app.panel_Main, 'numeric');
            app.edit_MinThickness.FontSize = 14;
            app.edit_MinThickness.Position = [1062 376 52 22];

            % Create PulsepowerperlengthJmEditFieldLabel
            app.PulsepowerperlengthJmEditFieldLabel = uilabel(app.panel_Main);
            app.PulsepowerperlengthJmEditFieldLabel.WordWrap = 'on';
            app.PulsepowerperlengthJmEditFieldLabel.FontSize = 14;
            app.PulsepowerperlengthJmEditFieldLabel.Position = [35 434 145 51];
            app.PulsepowerperlengthJmEditFieldLabel.Text = 'Pulse power per length (J/m)';

            % Create edit_PulsePower
            app.edit_PulsePower = uieditfield(app.panel_Main, 'numeric');
            app.edit_PulsePower.FontSize = 14;
            app.edit_PulsePower.Position = [203 456 33 22];

            % Create MaxstepsinfrictiondecayLabel
            app.MaxstepsinfrictiondecayLabel = uilabel(app.panel_Main);
            app.MaxstepsinfrictiondecayLabel.WordWrap = 'on';
            app.MaxstepsinfrictiondecayLabel.FontSize = 14;
            app.MaxstepsinfrictiondecayLabel.Position = [320 442 132 53];
            app.MaxstepsinfrictiondecayLabel.Text = 'Max steps in frictional decay:';

            % Create edit_MaxFricSteps
            app.edit_MaxFricSteps = uieditfield(app.panel_Main, 'numeric');
            app.edit_MaxFricSteps.FontSize = 14;
            app.edit_MaxFricSteps.Position = [460 463 33 22];

            % Create HorizontalthermalconductivityanisotropyEditFieldLabel
            app.HorizontalthermalconductivityanisotropyEditFieldLabel = uilabel(app.panel_Main);
            app.HorizontalthermalconductivityanisotropyEditFieldLabel.WordWrap = 'on';
            app.HorizontalthermalconductivityanisotropyEditFieldLabel.FontSize = 14;
            app.HorizontalthermalconductivityanisotropyEditFieldLabel.Position = [875 269 169 51];
            app.HorizontalthermalconductivityanisotropyEditFieldLabel.Text = 'Horizontal thermal conductivity anisotropy:';

            % Create edit_HorizkAnisotropy
            app.edit_HorizkAnisotropy = uieditfield(app.panel_Main, 'numeric');
            app.edit_HorizkAnisotropy.FontSize = 14;
            app.edit_HorizkAnisotropy.Position = [1062 286 52 22];

            % Create usefrictionaldecatfornoheatpulsesensitivityanalysis1Yes2NoLabel
            app.usefrictionaldecatfornoheatpulsesensitivityanalysis1Yes2NoLabel = uilabel(app.panel_Main);
            app.usefrictionaldecatfornoheatpulsesensitivityanalysis1Yes2NoLabel.WordWrap = 'on';
            app.usefrictionaldecatfornoheatpulsesensitivityanalysis1Yes2NoLabel.FontSize = 14;
            app.usefrictionaldecatfornoheatpulsesensitivityanalysis1Yes2NoLabel.Position = [39 176 171 51];
            app.usefrictionaldecatfornoheatpulsesensitivityanalysis1Yes2NoLabel.Text = {'Use frictional decay for no heat pulse sensitivity analysis?      '; ''};

            % Create edit_UseFricDecayNoHP
            app.edit_UseFricDecayNoHP = uieditfield(app.panel_Main, 'numeric');
            app.edit_UseFricDecayNoHP.FontSize = 14;
            app.edit_UseFricDecayNoHP.Position = [229 200 33 22];

            % Create DepthoffirstthermistorbelowweightstandEditFieldLabel
            app.DepthoffirstthermistorbelowweightstandEditFieldLabel = uilabel(app.panel_Main);
            app.DepthoffirstthermistorbelowweightstandEditFieldLabel.WordWrap = 'on';
            app.DepthoffirstthermistorbelowweightstandEditFieldLabel.FontSize = 14;
            app.DepthoffirstthermistorbelowweightstandEditFieldLabel.Position = [301 176 183 51];
            app.DepthoffirstthermistorbelowweightstandEditFieldLabel.Text = 'Depth of first thermistor below weight stand:';

            % Create edit_DepthFirstTherm
            app.edit_DepthFirstTherm = uieditfield(app.panel_Main, 'numeric');
            app.edit_DepthFirstTherm.FontSize = 14;
            app.edit_DepthFirstTherm.Position = [488 193 52 22];

            % Create label_HyndCo
            app.label_HyndCo = uilabel(app.panel_Main);
            app.label_HyndCo.WordWrap = 'on';
            app.label_HyndCo.FontSize = 14;
            app.label_HyndCo.Position = [39 366 202 60];
            app.label_HyndCo.Text = 'Hyndman Coefficients for k:';

            % Create edit_HyndCo_1
            app.edit_HyndCo_1 = uieditfield(app.panel_Main, 'numeric');
            app.edit_HyndCo_1.FontSize = 14;
            app.edit_HyndCo_1.Position = [235 385 52 22];

            % Create edit_HyndCo_2
            app.edit_HyndCo_2 = uieditfield(app.panel_Main, 'numeric');
            app.edit_HyndCo_2.FontSize = 14;
            app.edit_HyndCo_2.Position = [309 385 52 22];

            % Create edit_HyndCo_3
            app.edit_HyndCo_3 = uieditfield(app.panel_Main, 'numeric');
            app.edit_HyndCo_3.FontSize = 14;
            app.edit_HyndCo_3.Position = [383 385 52 22];

            % Create label_kInit
            app.label_kInit = uilabel(app.panel_Main);
            app.label_kInit.WordWrap = 'on';
            app.label_kInit.FontSize = 14;
            app.label_kInit.Position = [39 248 102 60];
            app.label_kInit.Text = 'Initial thermals conductivities:';

            % Create edit_kInit_1
            app.edit_kInit_1 = uieditfield(app.panel_Main, 'numeric');
            app.edit_kInit_1.FontSize = 14;
            app.edit_kInit_1.Position = [401 307 46 22];

            % Create edit_kInit_2
            app.edit_kInit_2 = uieditfield(app.panel_Main, 'numeric');
            app.edit_kInit_2.FontSize = 14;
            app.edit_kInit_2.Position = [168 269 52 22];

            % Create edit_kInit_3
            app.edit_kInit_3 = uieditfield(app.panel_Main, 'numeric');
            app.edit_kInit_3.FontSize = 14;
            app.edit_kInit_3.Position = [230 269 52 22];

            % Create edit_kInit_4
            app.edit_kInit_4 = uieditfield(app.panel_Main, 'numeric');
            app.edit_kInit_4.FontSize = 14;
            app.edit_kInit_4.Position = [292 269 52 22];

            % Create edit_kInit_5
            app.edit_kInit_5 = uieditfield(app.panel_Main, 'numeric');
            app.edit_kInit_5.FontSize = 14;
            app.edit_kInit_5.Position = [354 269 52 22];

            % Create edit_kInit_6
            app.edit_kInit_6 = uieditfield(app.panel_Main, 'numeric');
            app.edit_kInit_6.FontSize = 14;
            app.edit_kInit_6.Position = [416 269 52 22];

            % Create label_FricTau
            app.label_FricTau = uilabel(app.panel_Main);
            app.label_FricTau.WordWrap = 'on';
            app.label_FricTau.FontSize = 14;
            app.label_FricTau.Position = [578 193 102 60];
            app.label_FricTau.Text = 'Frictional decay tau boundaries:';

            % Create label_FricTauMin
            app.label_FricTauMin = uilabel(app.panel_Main);
            app.label_FricTauMin.FontSize = 14;
            app.label_FricTauMin.Position = [744 231 32 22];
            app.label_FricTauMin.Text = 'Min:';

            % Create label_FricTauMax
            app.label_FricTauMax = uilabel(app.panel_Main);
            app.label_FricTauMax.FontSize = 14;
            app.label_FricTauMax.Position = [813 231 36 22];
            app.label_FricTauMax.Text = 'Max:';

            % Create label_HPTau
            app.label_HPTau = uilabel(app.panel_Main);
            app.label_HPTau.WordWrap = 'on';
            app.label_HPTau.FontSize = 14;
            app.label_HPTau.Position = [578 117 120 60];
            app.label_HPTau.Text = 'Heat pulse decay tau boundaries:';

            % Create label_HPTauMin
            app.label_HPTauMin = uilabel(app.panel_Main);
            app.label_HPTauMin.FontSize = 14;
            app.label_HPTauMin.Position = [744 155 32 22];
            app.label_HPTauMin.Text = 'Min:';

            % Create label_HPTauMax
            app.label_HPTauMax = uilabel(app.panel_Main);
            app.label_HPTauMax.FontSize = 14;
            app.label_HPTauMax.Position = [813 155 36 22];
            app.label_HPTauMax.Text = 'Max:';

            % Create edit_FricTauMin
            app.edit_FricTauMin = uieditfield(app.panel_Main, 'numeric');
            app.edit_FricTauMin.FontSize = 14;
            app.edit_FricTauMin.Position = [744 209 32 22];

            % Create edit_FricTauMax
            app.edit_FricTauMax = uieditfield(app.panel_Main, 'numeric');
            app.edit_FricTauMax.FontSize = 14;
            app.edit_FricTauMax.Position = [813 209 32 22];

            % Create edit_HPTauMin
            app.edit_HPTauMin = uieditfield(app.panel_Main, 'numeric');
            app.edit_HPTauMin.FontSize = 14;
            app.edit_HPTauMin.Position = [744 133 32 22];

            % Create edit_HPTauMax
            app.edit_HPTauMax = uieditfield(app.panel_Main, 'numeric');
            app.edit_HPTauMax.FontSize = 14;
            app.edit_HPTauMax.Position = [813 133 32 22];

            % Create FrictionaltimedelaysEditFieldLabel
            app.FrictionaltimedelaysEditFieldLabel = uilabel(app.panel_Main);
            app.FrictionaltimedelaysEditFieldLabel.HorizontalAlignment = 'right';
            app.FrictionaltimedelaysEditFieldLabel.FontSize = 14;
            app.FrictionaltimedelaysEditFieldLabel.Position = [583 778 142 22];
            app.FrictionaltimedelaysEditFieldLabel.Text = 'Frictional time delays:';

            % Create edit_FricTimeDelay
            app.edit_FricTimeDelay = uieditfield(app.panel_Main, 'numeric');
            app.edit_FricTimeDelay.FontSize = 14;
            app.edit_FricTimeDelay.Position = [773 778 33 22];

            % Create HeatpulsetimedelaysEditFieldLabel
            app.HeatpulsetimedelaysEditFieldLabel = uilabel(app.panel_Main);
            app.HeatpulsetimedelaysEditFieldLabel.HorizontalAlignment = 'right';
            app.HeatpulsetimedelaysEditFieldLabel.FontSize = 14;
            app.HeatpulsetimedelaysEditFieldLabel.Position = [875 778 152 22];
            app.HeatpulsetimedelaysEditFieldLabel.Text = 'Heat pulse time delays:';

            % Create edit_HPTimeDelay
            app.edit_HPTimeDelay = uieditfield(app.panel_Main, 'numeric');
            app.edit_HPTimeDelay.FontSize = 14;
            app.edit_HPTimeDelay.Position = [1062 778 33 22];

            % Create UpdateParametersButton
            app.UpdateParametersButton = uibutton(app.panel_Main, 'push');
            app.UpdateParametersButton.ButtonPushedFcn = createCallbackFcn(app, @UpdateParametersButtonPushed, true);
            app.UpdateParametersButton.BackgroundColor = [0 0.4471 0.7412];
            app.UpdateParametersButton.FontSize = 18;
            app.UpdateParametersButton.FontWeight = 'bold';
            app.UpdateParametersButton.FontAngle = 'italic';
            app.UpdateParametersButton.FontColor = [1 1 1];
            app.UpdateParametersButton.Position = [912 117 183 81];
            app.UpdateParametersButton.Text = 'Update Parameters';

            % Create InitialtimeshiftLabel
            app.InitialtimeshiftLabel = uilabel(app.panel_Main);
            app.InitialtimeshiftLabel.HorizontalAlignment = 'right';
            app.InitialtimeshiftLabel.FontSize = 14;
            app.InitialtimeshiftLabel.Position = [583 710 136 22];
            app.InitialtimeshiftLabel.Text = 'Time shift increment:';

            % Create edit_TimeShiftInc
            app.edit_TimeShiftInc = uieditfield(app.panel_Main, 'numeric');
            app.edit_TimeShiftInc.FontSize = 14;
            app.edit_TimeShiftInc.Position = [773 710 33 22];

            % Create MinimumchangeofSigmakLabel
            app.MinimumchangeofSigmakLabel = uilabel(app.panel_Main);
            app.MinimumchangeofSigmakLabel.WordWrap = 'on';
            app.MinimumchangeofSigmakLabel.FontSize = 14;
            app.MinimumchangeofSigmakLabel.Position = [875 442 169 43];
            app.MinimumchangeofSigmakLabel.Text = 'Minimum change of Sigma(k): ';

            % Create edit_MinSigChange
            app.edit_MinSigChange = uieditfield(app.panel_Main, 'numeric');
            app.edit_MinSigChange.FontSize = 14;
            app.edit_MinSigChange.Position = [1062 463 52 22];

            % Create MinimumchangeofSigmakLabel_2
            app.MinimumchangeofSigmakLabel_2 = uilabel(app.panel_Main);
            app.MinimumchangeofSigmakLabel_2.WordWrap = 'on';
            app.MinimumchangeofSigmakLabel_2.FontSize = 14;
            app.MinimumchangeofSigmakLabel_2.Position = [875 621 169 49];
            app.MinimumchangeofSigmakLabel_2.Text = 'Maximum number of iterations for k computations:';

            % Create edit_MaxkIter
            app.edit_MaxkIter = uieditfield(app.panel_Main, 'numeric');
            app.edit_MaxkIter.FontSize = 14;
            app.edit_MaxkIter.Position = [1062 639 33 22];

            % Create InitialtimeshiftLabel_2
            app.InitialtimeshiftLabel_2 = uilabel(app.panel_Main);
            app.InitialtimeshiftLabel_2.HorizontalAlignment = 'right';
            app.InitialtimeshiftLabel_2.FontSize = 14;
            app.InitialtimeshiftLabel_2.Position = [875 710 103 22];
            app.InitialtimeshiftLabel_2.Text = 'Initial time shift:';

            % Create edit_InitTimeShift
            app.edit_InitTimeShift = uieditfield(app.panel_Main, 'numeric');
            app.edit_InitTimeShift.FontSize = 14;
            app.edit_InitTimeShift.Position = [1062 710 33 22];

            % Create TemperatureCalibrationInformationLabel
            app.TemperatureCalibrationInformationLabel = uilabel(app.panel_Main);
            app.TemperatureCalibrationInformationLabel.FontSize = 16;
            app.TemperatureCalibrationInformationLabel.FontWeight = 'bold';
            app.TemperatureCalibrationInformationLabel.Position = [28 96 290 22];
            app.TemperatureCalibrationInformationLabel.Text = 'Temperature Calibration Information:';

            % Create WaterCorrectionTypeLabel
            app.WaterCorrectionTypeLabel = uilabel(app.panel_Main);
            app.WaterCorrectionTypeLabel.WordWrap = 'on';
            app.WaterCorrectionTypeLabel.FontSize = 14;
            app.WaterCorrectionTypeLabel.Position = [29 39 145 51];
            app.WaterCorrectionTypeLabel.Text = 'Water Correction Type:';

            % Create edit_WaterCorrectionType
            app.edit_WaterCorrectionType = uieditfield(app.panel_Main, 'numeric');
            app.edit_WaterCorrectionType.FontSize = 14;
            app.edit_WaterCorrectionType.Position = [197 53 33 22];

            % Create MaxstepsinfrictiondecayLabel_2
            app.MaxstepsinfrictiondecayLabel_2 = uilabel(app.panel_Main);
            app.MaxstepsinfrictiondecayLabel_2.WordWrap = 'on';
            app.MaxstepsinfrictiondecayLabel_2.FontSize = 14;
            app.MaxstepsinfrictiondecayLabel_2.Position = [301 37 132 53];
            app.MaxstepsinfrictiondecayLabel_2.Text = 'Manual offset';

            % Create edit_ManOffset
            app.edit_ManOffset = uieditfield(app.panel_Main, 'numeric');
            app.edit_ManOffset.FontSize = 14;
            app.edit_ManOffset.Position = [441 52 52 22];

            % Create label_kniit_1
            app.label_kniit_1 = uilabel(app.panel_Main);
            app.label_kniit_1.WordWrap = 'on';
            app.label_kniit_1.FontSize = 14;
            app.label_kniit_1.Position = [87 288 293 60];
            app.label_kniit_1.Text = 'Does an initial kInit(z) function exists (Yes=99)';

            % Create edit_kInit_7
            app.edit_kInit_7 = uieditfield(app.panel_Main, 'numeric');
            app.edit_kInit_7.FontSize = 14;
            app.edit_kInit_7.Position = [478 269 52 22];

            % Create BoundaryConditionsLabel
            app.BoundaryConditionsLabel = uilabel(app.panel_Main);
            app.BoundaryConditionsLabel.FontSize = 16;
            app.BoundaryConditionsLabel.FontWeight = 'bold';
            app.BoundaryConditionsLabel.Position = [578 265 171 22];
            app.BoundaryConditionsLabel.Text = 'Boundary Conditions:';

            % Create label_SAkBounds
            app.label_SAkBounds = uilabel(app.panel_Main);
            app.label_SAkBounds.WordWrap = 'on';
            app.label_SAkBounds.FontSize = 14;
            app.label_SAkBounds.Position = [578 18 136 85];
            app.label_SAkBounds.Text = 'Thermal conductivity boundaries for sensitivity analysis:';

            % Create label_SAMin
            app.label_SAMin = uilabel(app.panel_Main);
            app.label_SAMin.FontSize = 14;
            app.label_SAMin.Position = [744 65 32 22];
            app.label_SAMin.Text = 'Min:';

            % Create label_SAkMax
            app.label_SAkMax = uilabel(app.panel_Main);
            app.label_SAkMax.FontSize = 14;
            app.label_SAkMax.Position = [813 65 36 22];
            app.label_SAkMax.Text = 'Max:';

            % Create edit_SAkMin
            app.edit_SAkMin = uieditfield(app.panel_Main, 'numeric');
            app.edit_SAkMin.FontSize = 14;
            app.edit_SAkMin.Position = [744 39 32 22];

            % Create edit_SAkMax
            app.edit_SAkMax = uieditfield(app.panel_Main, 'numeric');
            app.edit_SAkMax.FontSize = 14;
            app.edit_SAkMax.Position = [813 39 32 22];

            % Show the figure after all components are created
            app.figure_SetParams.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = SetParams_exported(varargin)

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.figure_SetParams)

            % Execute the startup function
            runStartupFcn(app, @(app)startupFcn(app, varargin{:}))

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.figure_SetParams)
        end
    end
end