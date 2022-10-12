%%% ======================================================================
%   Purpose: 
%   This function removes any unchecked sensors from the data. This is NOT
%   only display. Whatever sensors are unchecked when this funciton is run
%   will NOT be included in further processing.
%%% ======================================================================

function [IgnoredSensors, SensorsToUse...
           ]  = RemoveSensors(figure_Main, PenCheckboxes, AllSensors, LogFileId, ProgramLogId)

    % Warn user 
    % ------------
    confirmation = uiconfirm(figure_Main, ['Recordings from all unchecked sensors will be discarded and REMOVED from ' ...
        'data.'], 'Confirm sensor discard', 'Icon', 'warning');
    switch confirmation
    case 'OK'
        
        % Remove unchecked sensors 
        % ------------------------
        IgnoredSensors=zeros(size(AllSensors));
        for i=1:numel(AllSensors)
            if PenCheckboxes(i).Value == 0
                IgnoredSensors(i) = i;
            end
        end
        
        IgnoredSensors(IgnoredSensors==0) = [];
        SensorsToUse = setdiff(AllSensors,IgnoredSensors);
    
        % Update LOG file to indicate which 
        % sensors are used and which are ignored
        % ----------------------------------------
        if isempty(IgnoredSensors)
            PrintStatus(LogFileId,'All the sensors are used in processing!   ',2);
        else
            PrintStatus(LogFileId,['These sensors are IGNORED in processing: ' ...
                    int2str(IgnoredSensors)],2);
            PrintStatus(LogFileId,['These sensors are USED in processing: ' ...
                    int2str(SensorsToUse)],2);
        end
        
	    PrintStatus(ProgramLogId, ['-- Removing unchecked sensors to be ignored ' ...
            'in processing'],2);
    case 'Cancel'
        IgnoredSensors = [];
        SensorsToUse = AllSensors;
        return

    end