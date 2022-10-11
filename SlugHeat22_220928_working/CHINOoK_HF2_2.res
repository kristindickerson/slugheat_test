===============================================================================
===============================================================================
===                                                                         ===
===       SlugHeat  -  Version: 22  -  Update: 2022                         ===
===                                                                         ===
===============================================================================
===============================================================================


----------------------------------------------------------------------------------------------------------------------------------------------
--                                                                                                                                          --
--  RESULTS FILE: /Volumes/GoogleDrive/My Drive/Research/Heat_Flow /SlugHeat/code/SlugHeat22/SlugHeat22_DickersonWorking/CHINOoK_HF2_2.res  --
--                                                                                                                                          --
--                                                     Processed: 27-Sep-2022 14:55:58                                                      --
--                                                                                                                                          --
----------------------------------------------------------------------------------------------------------------------------------------------



Penetration file:  /Volumes/GoogleDrive/My Drive/Research/Heat_Flow /SlugHeat/code/SlugHeat22/SlugHeat22_DickersonWorking/PenetrationFiles/CHINOoK/HF2/CHINOoK_HF2_2.pen

Parameter file (*):  /Volumes/GoogleDrive/My Drive/Research/Heat_Flow /SlugHeat/code/SlugHeat22/SlugHeat22_DickersonWorking/SlugHeat22.par

Log file: /Volumes/GoogleDrive/My Drive/Research/Heat_Flow /SlugHeat/code/SlugHeat22/SlugHeat22_DickersonWorking/CHINOoK_HF2_2.log


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
Heat Pulse Power (J/m):  	600.0
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
Mean tilt is now :      3.4 degrees.
Inter-Sensor distance : 0.299 m.

       -----------------------------------------------------------------
       RESULTS OF FRICTIONAL AND HEAT PULSE DECAYS REDUCTION - TRIAL # 1
       -----------------------------------------------------------------


Frictional Decay - Iteration 01
===============================

Sensor  Data Points  Eq. temp.   Error   Gradient  Delay   Slope
        Tot. / Used    (deg)     (95%)   (mdeg/m)  (sec)   (/deg)
------  -----------  ---------  -------  --------  ------  ------

   1      19 /  7      2.785    4.4e-04   862.083     -8   -0.234
   2      19 /  7      2.527    7.2e-04   995.773     96   -1.391
   3      19 /  7      2.228    7.0e-04   828.739    192    1.292
   4      19 /  7      1.980    9.1e-04   789.272     -8   -1.281
   5      19 /  7      1.743    9.1e-04  1029.987     24   -1.731
   6      19 /  7      1.434    7.1e-04   910.959      0   -1.269
   7      19 /  7      1.160    7.0e-04  1047.034     -8   -0.876
   8      19 /  7      0.846    9.4e-04  1001.960    -32   -0.558
   9      19 /  7      0.546    1.5e-03   971.734    -32   -0.366
  10      19 /  7      0.254    1.7e-04     0.000    -56   -0.110
       -----------------------------------------------------------------
       RESULTS OF FRICTIONAL AND HEAT PULSE DECAYS REDUCTION - TRIAL # 1
       -----------------------------------------------------------------


Frictional Decay - Iteration 02
===============================

Sensor  Data Points  Eq. temp.   Error   Gradient  Delay   Slope
        Tot. / Used    (deg)     (95%)   (mdeg/m)  (sec)   (/deg)
------  -----------  ---------  -------  --------  ------  ------

   1      19 / 19        NaN        NaN       NaN    192      NaN
   2      19 / 19        NaN        NaN       NaN    192      NaN
   3      19 / 19        NaN        NaN       NaN    192      NaN
   4      19 / 19        NaN        NaN       NaN    192      NaN
   5      19 / 19        NaN        NaN       NaN    192      NaN
   6      19 / 19        NaN        NaN       NaN    192      NaN
   7      19 / 19        NaN        NaN       NaN    192      NaN
   8      19 / 19        NaN        NaN       NaN    192      NaN
   9      19 / 19        NaN        NaN       NaN    192      NaN
  10      19 / 19        NaN        NaN     0.000    192      NaN
