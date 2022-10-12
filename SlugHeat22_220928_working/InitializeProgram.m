%%% ==============================================================================
% 	Purpose: 
%	This function INITIALIZES the program, loads in variables from MAT file,
%   and begins writing the log
%%% ==============================================================================

function [Version, Update, ...
			NumberOfColumns, ...
			CurrentPath, CurrentDateTime, ...
            ParFile, ParFilePath, ParFileName, ...
            DefaultParFile, ...
    	    CalFile, CalFilePath, CalFileName, ProgramLogId] =  InitializeProgram(DepthPlot, ...
            TiltPlot, BWPlot, ...
            image_UCSCLogo, image_WHLogo, image_OSULogo, ...
            image_SlugHeat, button_ControlWindowExit, button_OpenControlsPanel);


    % Clear command window and workspace
	% -------------------------------------------------------
	clc 
	clear 

    % Load in MAT file with logos, images, and all default parameters for
    % any general penetration
    % --------------------------------------------------------------------
    load SlugHeat22.mat;


    % Open temporary log file
    % -------------------------------------------------------
	ProgramLogId = fopen('SlugHeat22.log', 'w');
    CurrentDateTime = datestr(datetime('now'));
    CurrentPath = [pwd '/'];
    PrintStatus(ProgramLogId, '----------------------------------------------',1);
    PrintStatus(ProgramLogId, '----------------------------------------------',1);
	PrintStatus(ProgramLogId,['SlugHeat22 start time: ' CurrentDateTime],1)
	PrintStatus(ProgramLogId, '----------------------------------------------',1);
	PrintStatus(ProgramLogId, '----------------------------------------------',2);

	PrintStatus(ProgramLogId, [CurrentDateTime ' Processing set up and data preparation'], 1)
	PrintStatus(ProgramLogId, '==================================================================================================',2);
    
    % Add images from MAT file to layout
    % ------------------------------------
    % image_UCSCLogo.ImageSource = imshow(UCSCLogo);
    % image_WHLogo.ImageSource = imshow(WoodsHoleLogo);
    % image_OSULogo.ImageSource = imshow(OSULogo);
    % image_SlugHeat.ImageSource = imshow(SlugHeatLogo);
  

    %  button_ControlWindowExit.Icon = imshow(xImage);
    %  button_OpenControlsPanel.Icon = imshow(TabImage);


    % Define version information and other default parameters
    % -------------------------------------------------------
    
    Version = '22';                         % Version number
    Update = '2022';                        % Date of last update
    NumberOfColumns = 79;                   % # of columns in Log and Res files
    DefaultParFile = 'SlugHeat22.par';

    % Parameters (PAR) file name and path  
    % ---------------------------------------------
    PrintStatus(ProgramLogId, ' -- Finding parameter file...',1);

    CurrentPath = [pwd '/']; % location of .par and .pen file should be placed in current folder before SlugHeat is run

	% *****************************************************************
	% If there is no default 'SlugHeat22.par' file in the current directory,
	%	User to choose new .par file
	% If there is 'SlugHeat22.par' in the current directory,
	%	This file is used as the default parameter file
	% *****************************************************************

    if ~exist('SlugHeat22.par', 'file')
        [ParFileName, ParFilePath] = uigetfile( ...
			[CurrentPath '*.par'], ...
			'Select parameter file');
    else
        ParFileName = 'SlugHeat22.par';
        ParFilePath = CurrentPath;
    end

    ParFile = [ParFilePath ParFileName];

	PrintStatus(ProgramLogId, ['Parameter file: ' ParFile],2);

    % Calibration (CAL) file name and path
    % ---------------------------------------------
	PrintStatus(ProgramLogId, ' -- Finding calibration file...',1);

	% *****************************************************************
	% If there is no default 'SlugHeat22.cal' file in the current directory,
	%	User to choose new .cal file
	% If there is 'SlugHeat22.cal' in the current directory,
	%	This file is used as the default calibration file
	% *****************************************************************

    if ~exist('SlugHeat22.cal', 'file')
        [CalFileName, CalFilePath] = uigetfile( ...
		[CurrentPath '*.cal'], ...
		'Select calibration file');
    else
        CalFileName = 'SlugHeat22.cal';
        CalFilePath = CurrentPath;
    end

	CalFile = [CalFilePath CalFileName];

	PrintStatus(ProgramLogId, ['Calibration file: ' CalFile],2);


    
% ---------------------------------------------------------
% KD: added these that were hard coded, now in the PAR file
%		 MinTotalkChange ...
%        MaxNumberOfIterations ...
%        MaxMCIterations ...
%        Sigmak0 ...
%        kMin ...
%        kMax ...
%        MinThickness ...
%        UseFrictional ...
%        kAnisotropy ...
%        TopSensorDepth ...
% ---------------------------------------------------------
