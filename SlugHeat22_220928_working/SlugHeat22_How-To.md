# SlugHeat22_How-To

## System Requirements:
* MATLAB Version 2020b or later
* Directory `.../SlugHeat22_DickersonWorking` and all subfolders, including:
	- `SlugHeat22_working.mlapp` (main application)
	- All functions
	- Default input files
		+ Default PAR file (`SlugHeat22.par`)
		+ Default CAL file(`SlugHeat22.cal`)
		+ Default MAT file (`SlugHeat22.mat`)
	- Auxillary apps
		+ `DiscardData.mlapp`
		+ `SetParams.mlapp`
	- Required subfolders:
		+ `Images`
		+ `PenetrationFiles` (this is where you should put subfolders with your .pen and .tap files created in SlugPen)
* Main directory and all its subdirectories in you path (instructions for this below)


## I. Set up software
#### (1) Add current folder and all subfolders to MATLAB path
##### Make sure your current folder is `.../SlugHeat22_DickersonWorking` (the directory that houses the application and all of its functions and subfolders)
##### To ***temporarily*** add directory to MATLAB path:


In MATLAB Command Window:
```matlab
addpath(genpath(pwd))
```
##### To ***permanently*** add directory to MATLAB path:

In MATLAB toolbar at top right of screen:
* Select 'Set Path' in MATLAB toolbar
* Select 'Add with Subfolders...'
* Open directory 'SlugHeat22'
* Press Save

##### To check that directory `SlugHeat22_DickersonWorking` and all sub-directories are in your MATLAB path:

In MATLAB Command Window
```matlab
path 
```

#### (2) Run SlugHeat
In MATLAB Command Window

```matlab
SlugHeat22_working
```


## II. Set parameters
#### (1) Check default parameters, make adjustments if desired
* The default parameters are read in *during software start up* from the text file `SlugHeat22.par`
	- You can change this text file in an text editor, but I don't recommend this. 
* Instead, manually set the parameters by pressing the button ‘Manually set parameters’ (see (2) below)
* If you edit .par file in a text editor, be sure to *reload the penetration data again*
#### (2) Optional: `Manually set parameters` button
* This pulls up an auxillary app with all default parameters
* Changing a parameter in this aux app will also change its value in the main processing app
* Default parameters (.par) file and default calibration (.cal) file

## III. Load in penetration
#### (1) Press `Load Penetration` button
#### (2) Choose the .pen file you would like to load in
* Note: The folder containing the .pen file must be in your MATLAB path if you have a TAP file to be read in along with your .pen file
#### Penetration Files
* These are the names of the .pen file and .tap file that are loaded 
#### Output Files
* These are the names of the .log file and .res file that are created during processing
* LOG file: logs the activity of the software
* RES file: logs the results of the data processing
#### Penetration Tab
* Tab showing plotted data from penetration before processing

## IV. Process data
#### (1) Press `Process` button
#### (2) Navigate through different tabs at top of tabgroup
#### (3) Sensors on each plot can be turned on and off with checkboxes to the right of plots, but this only turns off the *display*
* To discard data from calculations, use `Discard Data` button
#### (4) Each time you re-process is another 'Trial'
#### (5) Optional: Switch `Pause Iterations` toggle switch 
* Switch to `On` in order to plot the data of each iteration and pause the program and look at each individual iteration before continuing
* To continue, press the `Next Iteration` button
* To stop iterating and use the thermal conductivity and temperature values from the current itreration to calculate heat flow, press the `End` button
#### (5) Processed results are summarized in the `Results Summary` tab at the far right
* This notes the cruise name, the penetration name, the trial number, how many iterations, which sensors were used for the temperature and thermal conductivity computations, and the heat flow.
*  To save this table as a .mat file in your current directory, hit the `Save` button

## V. Discard unwanted data
#### (1) Press the `Discard Data` button 
#### (2) Choose which sensors you would like to include in the heat pulse calculations
#### (3) You can choose sensors' thermal conductivity values or temperature values to be included separately. 
#### (4) Checked boxes next to each sensor means the data from that sensor is *included* in the heat pulse calculations
#### (5) Press the `Update` button to update the data that is included
#### (6) You ***must*** press the `Process` button againa after you have updated which data to include in order to re-process and see new heat flow calculations. 
* This will be updated later to automatically re-process

## Notable features
#### Hide Command Window
* `X` Button (top left of window)
#### Bring back Command Window
* Arrow to left of main window
#### Sensor checkboxes
* Turn sensors 'on' or 'off' with sensor legend bar to right of main window
* This only effects the ***display*** of each sensor on the various plots. The data from each sensor is still included in computations until discarded with `Discard Data` auxillary application (launched with red `Discard Data` button at bottom of Command Window)
#### Adjust timing of start of penetration, heat pulse, and end of penetration
* Edit record number under Data Controls panel in Command Window
#### Hide certain plots
* Use toggles in Plot Controls panel in Command Window
#### Pause processing between iterations
* Switch Pause Iterations toggle to 'On' before processing
* To continue with iterations, press `Next Iteration` button
* To calculate heat flow with current iteration, press `End` button
