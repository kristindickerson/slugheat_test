%%% ======================================================================================
%   Purpose: 
%     This function READS in the bottom water temperature calibration (.cal) file that was 
%     chosen in 'Initialize' function  and defined now as variable `CALFile`.
%     Saves variables for water calibration type and manual offset - both
%     to be used in water temp correction function TempCorrection
%%% ======================================================================================

function [WaterCorrectionType, Offset] = ReadCalFile(CalFile, ProgramLogId)
    
    % Opens the calibration (.cal) file
    % ----------------------------------
    fid = fopen(CalFile);
    
    % Finds all Carriage Line Returns (ascii code = 10)
    % -------------------------------------------------
    Lookup = fread(fid,inf);
    CR = find(Lookup==10);

    % Read in data
    % -------------------------------------------------
    
    % Line 1: Water Correction Type
    fseek(fid,CR(1),'bof');
    WaterCorrectionType = fscanf(fid,'%d',1);
    
    % Line 1: Manual Offset
    fseek(fid,CR(end),'bof');
    Offset = fscanf(fid,'%g',1);
    
    fclose(fid);


    PrintStatus(ProgramLogId, '-- Reading in parameters from calibration file',2)