%%% ==============================================================================
%   Purpose: 
%     This function UPDATES the layout. All labels, text boxes, checkboxes,
%     legends, etc. are updated to current conditions.
%%% ==============================================================================

function updateLabels(label_currentpathfull, CurrentPath, label_calfilename, ...
    CalFileName, label_parfilename, ParFileName, label_penfilename, ...
    PenFileName, label_tapfilename, TAPFileName, label_resfilename, ...
    ResFileName, label_logfilename, LogFileName, label_Cruise, CruiseName, ...
    label_Station, StationName, label_Penetration, Penetration, ...
    label_Latitude, Latitude, label_Longitude, Longitude, edit_PenStart, ...
    PenetrationRecord, edit_PenEnd, EndRecord, edit_HP, HeatPulseRecord, edit_pulsepower, PulsePower)

    label_currentpathfull.Text = ['...' CurrentPath(end-20:end)];
    label_currentpathfull.Tooltip = CurrentPath;
    label_calfilename.Text = CalFileName;
    label_parfilename.Text = ParFileName;

    if ischar(PenFileName)
        label_penfilename.Text  = PenFileName;
        label_tapfilename.Text  = TAPFileName;
        label_resfilename.Text  = ResFileName;
        label_logfilename.Text  = LogFileName;
        label_Cruise.Text       = CruiseName;
        
        if isstring(StationName)
            label_Station.Text      = StationName;
            label_Penetration.Text  = Penetration;
            label_Latitude.Text     = Latitude;
            label_Longitude.Text    = Longitude;
        else
            label_Station.Text      = num2str(StationName);       
            label_Penetration.Text  = num2str(Penetration);
            label_Latitude.Text     = num2str(Latitude);
            label_Longitude.Text    = num2str(Longitude);
        end

        edit_PenStart.Value     = PenetrationRecord;
        edit_PenEnd.Value       = EndRecord;
        edit_HP.Value           = HeatPulseRecord;
        edit_pulsepower.Value   = PulsePower;
    end
