===============================================================================
===============================================================================
===                                                                         ===
===       SlugHeat  -  Version: 22  -  Update: 2022                         ===
===                                                                         ===
===============================================================================
===============================================================================


------------------------------------------------------------------------------------------------------------------------------------------------
--                                                                                                                                            --
--  RESULTS FILE: /Volumes/GoogleDrive/My Drive/Research/Heat_Flow /SlugHeat/code/SlugHeat22/SlugHeat22_DickersonWorking/test5_station_1.res  --
--                                                                                                                                            --
--                                                      Processed: 28-Sep-2022 08:19:48                                                       --
--                                                                                                                                            --
------------------------------------------------------------------------------------------------------------------------------------------------



Penetration file:  /Volumes/GoogleDrive/My Drive/Research/Heat_Flow /SlugHeat/code/SlugHeat22/SlugHeat22_DickersonWorking/PenetrationFiles/test5_station_1.pen

Parameter file (*):  /Volumes/GoogleDrive/My Drive/Research/Heat_Flow /SlugHeat/code/SlugHeat22/SlugHeat22_DickersonWorking/SlugHeat22.par

Log file: /Volumes/GoogleDrive/My Drive/Research/Heat_Flow /SlugHeat/code/SlugHeat22/SlugHeat22_DickersonWorking/test5_station_1.log


(*) File SlugHeat22.par found in the working directory !


                          ---------------------------
                          PARAMETERS READ IN PAR FILE
                          ---------------------------


Number Of Sensors:		11
Time Scaling Factor (s):	10.0
Sensor Radius (m):		4.76e-03
Inter-sensor spacing (m):	0.30

Calibration Coefficients ( T = 1000*[a.x^2 + b.x + c] degC ):

  a: 0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  
  b: 1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  
  c: 0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  

Hyndman Coefficients ( Kappa = k/[a - b.k + c.k^2] 10^-6 m^2/s ):

  a: 5.790
  b: 3.670
  c: 1.016

Initial Frictional Delays (s):

  200.0  200.0  200.0  200.0  200.0  200.0  200.0  200.0  200.0  200.0  200.0  

Time Shift Increment (s):  	-8
Maximum Frictional Step:  	50
Minimum Frictional Tau:  	1.6
Maximum Fricional Tau:  	10.0

Assumed Initial Conductivities (W/m/degC):  

  k(z) = +0.909 +0.024z

Initial Heat Pulse Delays (s):

  10.0  10.0  10.0  10.0  10.0  10.0  10.0  10.0  10.0  10.0  10.0  

Time Shift Increment (s): 	1.0
Maximum Heat Pulse Step:  	50
Minimum Heat Pulse Tau:  	1.6
Maximum Heat Pulse Tau:  	10.0
Heat Pulse Length (s):  	20.0
Tolerance on k (degC):  	0.0
Minimum change of Sigma(k):  	0.0
Maximum number of iterations for k computations:  	10.0
Number of Iterations for Sensitivity analysis:  	100.0
Standard deviation in thermal conductivity for Sensitivity analysis:  	0.1
Minimum thermal conductivity cutoff for Sensitivity analysis:  	0.6
Maximum thermal conductivity cutoff for Sensitivity analysis:  	1.5
Mininum layer thickness for Sensitivity analysis:  	0.1
Use Frictional decay for No Heat pulse Sensitivity analysis ?:  	0.0
Horizontal thermal conductivity Anisotropy:  	1.1
Depth of first thermistor below weight stand:  	0.250


Applying tilt correction ...
Mean tilt is now :      3.6 degrees.
Inter-Sensor distance : 0.299 m.

       -----------------------------------------------------------------
       RESULTS OF FRICTIONAL AND HEAT PULSE DECAYS REDUCTION - TRIAL # 1
       -----------------------------------------------------------------


Frictional Decay - Iteration 01
===============================

Sensor  Data Points  Eq. temp.   Error   Gradient  Delay   Slope
        Tot. / Used    (deg)     (95%)   (mdeg/m)  (sec)   (/deg)
------  -----------  ---------  -------  --------  ------  ------

   1      31 / 19      0.334    1.3e-03    77.220    -32    0.214
   2      31 / 19      0.310    1.1e-03    64.546    -24    0.440
   3      31 / 19      0.291    8.8e-04    76.741    -32    0.423
   4      31 / 19      0.268    8.6e-04    82.127    -32    0.287
   5      31 / 19      0.243    6.7e-04    91.780     -8    0.307
   6      31 / 19      0.216    7.2e-04    63.426     16    0.374
   7      31 / 19      0.197    7.0e-04    66.280     -8    0.221
   8      31 / 19      0.177    7.2e-04    80.769   -112   -0.004
   9      31 / 19      0.153    5.7e-04    70.485     16    0.107
  10      31 / 19      0.132    6.6e-04    55.843    192    0.072
  11      31 / 19      0.115    8.2e-04     0.000   -112   -0.002
