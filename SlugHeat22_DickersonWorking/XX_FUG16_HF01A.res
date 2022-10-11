===============================================================================
===============================================================================
===                                                                         ===
===       SlugHeat  -  Version: 22  -  Update: 2022                         ===
===                                                                         ===
===============================================================================
===============================================================================


-----------------------------------------------------------------------------------------------------------------------------------------------
--                                                                                                                                           --
--  RESULTS FILE: /Volumes/GoogleDrive/My Drive/Research/Heat_Flow /SlugHeat/code/SlugHeat22/SlugHeat22_DickersonWorking/XX_FUG16_HF01A.res  --
--                                                                                                                                           --
--                                                      Processed: 27-Sep-2022 14:26:57                                                      --
--                                                                                                                                           --
-----------------------------------------------------------------------------------------------------------------------------------------------



Penetration file:  /Volumes/GoogleDrive/My Drive/Research/Heat_Flow /SlugHeat/code/SlugHeat22/SlugHeat22_DickersonWorking/PenetrationFiles/Old_HFData/XX_FUG16_HF01A.pen

Parameter file (*):  /Volumes/GoogleDrive/My Drive/Research/Heat_Flow /SlugHeat/code/SlugHeat22/SlugHeat22_DickersonWorking/SlugHeat22.par

Log file: /Volumes/GoogleDrive/My Drive/Research/Heat_Flow /SlugHeat/code/SlugHeat22/SlugHeat22_DickersonWorking/XX_FUG16_HF01A.log


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
Mean tilt is now :      2.4 degrees.
Inter-Sensor distance : 0.300 m.

       -----------------------------------------------------------------
       RESULTS OF FRICTIONAL DECAY REDUCTION - NO HEAT PULSE - TRIAL # 1
       -----------------------------------------------------------------


Frictional Decay - Iteration 01
===============================

Sensor  Data Points  Eq. temp.   Error   Gradient  Delay   Slope
        Tot. / Used    (deg)     (95%)   (mdeg/m)  (sec)   (/deg)
------  -----------  ---------  -------  --------  ------  ------

   1      64 / 52      0.195    9.2e-04    48.610      0    0.904
   2      64 / 52      0.180    7.8e-04    49.173     32    0.798
   3      64 / 52      0.166    7.1e-04    56.187      8    0.650
   4      64 / 52      0.149    6.7e-04    53.603      8    0.439
   5      64 / 52      0.133    7.2e-04    65.542     16    0.366
   6      64 / 52      0.113    7.0e-04    68.662     24    0.338
   7      64 / 52      0.092    6.3e-04    59.308     40    0.347
   8      64 / 52      0.075    7.3e-04    70.624     48    0.239
   9      64 / 52      0.053    6.5e-04    80.246     24    0.266
  10      64 / 52      0.029    6.7e-04    76.347     48    0.301
  11      64 / 52      0.006    8.1e-04     0.000     72    0.343

-----------------------------------------------------------------

            -------------------------------------------------------
            RESULTS OF BULLARD ANALYSIS - NO HEAT PULSE - TRIAL # 1
            -------------------------------------------------------


Heat Flow: 60 -  Iteration 01
===============================

Sensor  Depth     Equilibrium          Bottom Water    Equilibrium   Temp. Error   Therm. Con.
                  Temp. Relative to    Temp. (°C)      Temp.(°C)     (95%)         (W/m°C)
                  Bottom Water (°C)                       
------  --------  -------------------  ------------    ------------  -----------   -----------

   1    3.22      0.19                 2.73            2.93          9.22e-04      0.99
   2    2.92      0.18                 2.78            2.96          7.76e-04      0.98
   3    2.62      0.17                 2.73            2.90          7.05e-04      0.97
   4    2.32      0.15                 2.72            2.87          6.73e-04      0.97
   5    2.02      0.13                 2.70            2.83          7.17e-04      0.96
   6    1.72      0.11                 2.74            2.85          6.96e-04      0.95
   7    1.42      0.09                 2.77            2.86          6.33e-04      0.94
   8    1.12      0.07                 2.74            2.81          7.25e-04      0.94
   9    0.82      0.05                 2.75            2.81          6.49e-04      0.93
  10    0.52      0.03                 2.70            2.73          6.71e-04      0.92
  11    0.22      0.01                 2.74            2.75          8.06e-04      0.92

------------------------------------------------------------------------------------------------

       -----------------------------------------------------------------
       RESULTS OF FRICTIONAL DECAY REDUCTION - NO HEAT PULSE - TRIAL # 1
       -----------------------------------------------------------------


Frictional Decay - Iteration 02
===============================

Sensor  Data Points  Eq. temp.   Error   Gradient  Delay   Slope
        Tot. / Used    (deg)     (95%)   (mdeg/m)  (sec)   (/deg)
------  -----------  ---------  -------  --------  ------  ------

   1      64 / 52      0.195    9.2e-04    48.605      0    0.903
   2      64 / 52      0.180    7.8e-04    49.172     32    0.797
   3      64 / 52      0.166    7.1e-04    56.181      8    0.650
   4      64 / 52      0.149    6.7e-04    53.602      8    0.438
   5      64 / 52      0.133    7.2e-04    65.540     16    0.365
   6      64 / 52      0.113    7.0e-04    68.661     24    0.337
   7      64 / 52      0.092    6.3e-04    59.305     40    0.347
   8      64 / 52      0.075    7.3e-04    70.626     48    0.239
   9      64 / 52      0.053    6.5e-04    80.246     24    0.265
  10      64 / 52      0.029    6.7e-04    76.347     48    0.301
  11      64 / 52      0.006    8.1e-04     0.000     72    0.343

-----------------------------------------------------------------

            -------------------------------------------------------
            RESULTS OF BULLARD ANALYSIS - NO HEAT PULSE - TRIAL # 1
            -------------------------------------------------------


Heat Flow: 60 -  Iteration 02
===============================

Sensor  Depth     Equilibrium          Bottom Water    Equilibrium   Temp. Error   Therm. Con.
                  Temp. Relative to    Temp. (°C)      Temp.(°C)     (95%)         (W/m°C)
                  Bottom Water (°C)                       
------  --------  -------------------  ------------    ------------  -----------   -----------

   1    3.22      0.19                 2.73            2.93          9.23e-04      0.99
   2    2.92      0.18                 2.78            2.96          7.77e-04      0.98
   3    2.62      0.17                 2.73            2.90          7.06e-04      0.97
   4    2.32      0.15                 2.72            2.87          6.73e-04      0.96
   5    2.02      0.13                 2.70            2.83          7.17e-04      0.96
   6    1.72      0.11                 2.74            2.85          6.96e-04      0.95
   7    1.42      0.09                 2.77            2.86          6.33e-04      0.94
   8    1.12      0.07                 2.74            2.81          7.26e-04      0.94
   9    0.82      0.05                 2.75            2.81          6.49e-04      0.93
  10    0.52      0.03                 2.70            2.73          6.71e-04      0.92
  11    0.22      0.01                 2.74            2.75          8.06e-04      0.91

------------------------------------------------------------------------------------------------



       -----------------------------------------------------------------
       RESULTS OF FRICTIONAL DECAY REDUCTION - NO HEAT PULSE - TRIAL # 2
       -----------------------------------------------------------------


Frictional Decay - Iteration 01
===============================

Sensor  Data Points  Eq. temp.   Error   Gradient  Delay   Slope
        Tot. / Used    (deg)     (95%)   (mdeg/m)  (sec)   (/deg)
------  -----------  ---------  -------  --------  ------  ------

   1      64 / 52      0.195    9.2e-04    48.610      0    0.904
   2      64 / 52      0.180    7.8e-04    49.173     32    0.798
   3      64 / 52      0.166    7.1e-04    56.187      8    0.650
   4      64 / 52      0.149    6.7e-04    53.603      8    0.439
   5      64 / 52      0.133    7.2e-04    65.542     16    0.366
   6      64 / 52      0.113    7.0e-04    68.662     24    0.338
   7      64 / 52      0.092    6.3e-04    59.308     40    0.347
   8      64 / 52      0.075    7.3e-04    70.624     48    0.239
   9      64 / 52      0.053    6.5e-04    80.246     24    0.266
  10      64 / 52      0.029    6.7e-04    76.347     48    0.301
  11      64 / 52      0.006    8.1e-04     0.000     72    0.343

-----------------------------------------------------------------

            -------------------------------------------------------
            RESULTS OF BULLARD ANALYSIS - NO HEAT PULSE - TRIAL # 2
            -------------------------------------------------------


Heat Flow: 60 -  Iteration 01
===============================

Sensor  Depth     Equilibrium          Bottom Water    Equilibrium   Temp. Error   Therm. Con.
                  Temp. Relative to    Temp. (°C)      Temp.(°C)     (95%)         (W/m°C)
                  Bottom Water (°C)                       
------  --------  -------------------  ------------    ------------  -----------   -----------

   1    3.22      0.19                 2.73            2.93          9.22e-04      0.99
   2    2.92      0.18                 2.78            2.96          7.76e-04      0.98
   3    2.62      0.17                 2.73            2.90          7.05e-04      0.97
   4    2.32      0.15                 2.72            2.87          6.73e-04      0.97
   5    2.02      0.13                 2.70            2.83          7.17e-04      0.96
   6    1.72      0.11                 2.74            2.85          6.96e-04      0.95
   7    1.42      0.09                 2.77            2.86          6.33e-04      0.94
   8    1.12      0.07                 2.74            2.81          7.25e-04      0.94
   9    0.82      0.05                 2.75            2.81          6.49e-04      0.93
  10    0.52      0.03                 2.70            2.73          6.71e-04      0.92
  11    0.22      0.01                 2.74            2.75          8.06e-04      0.92

------------------------------------------------------------------------------------------------

       -----------------------------------------------------------------
       RESULTS OF FRICTIONAL DECAY REDUCTION - NO HEAT PULSE - TRIAL # 2
       -----------------------------------------------------------------


Frictional Decay - Iteration 02
===============================

Sensor  Data Points  Eq. temp.   Error   Gradient  Delay   Slope
        Tot. / Used    (deg)     (95%)   (mdeg/m)  (sec)   (/deg)
------  -----------  ---------  -------  --------  ------  ------

   1      64 / 52      0.195    9.2e-04    48.605      0    0.903
   2      64 / 52      0.180    7.8e-04    49.172     32    0.797
   3      64 / 52      0.166    7.1e-04    56.181      8    0.650
   4      64 / 52      0.149    6.7e-04    53.602      8    0.438
   5      64 / 52      0.133    7.2e-04    65.540     16    0.365
   6      64 / 52      0.113    7.0e-04    68.661     24    0.337
   7      64 / 52      0.092    6.3e-04    59.305     40    0.347
   8      64 / 52      0.075    7.3e-04    70.626     48    0.239
   9      64 / 52      0.053    6.5e-04    80.246     24    0.265
  10      64 / 52      0.029    6.7e-04    76.347     48    0.301
  11      64 / 52      0.006    8.1e-04     0.000     72    0.343

-----------------------------------------------------------------

            -------------------------------------------------------
            RESULTS OF BULLARD ANALYSIS - NO HEAT PULSE - TRIAL # 2
            -------------------------------------------------------


Heat Flow: 60 -  Iteration 02
===============================

Sensor  Depth     Equilibrium          Bottom Water    Equilibrium   Temp. Error   Therm. Con.
                  Temp. Relative to    Temp. (°C)      Temp.(°C)     (95%)         (W/m°C)
                  Bottom Water (°C)                       
------  --------  -------------------  ------------    ------------  -----------   -----------

   1    3.22      0.19                 2.73            2.93          9.23e-04      0.99
   2    2.92      0.18                 2.78            2.96          7.77e-04      0.98
   3    2.62      0.17                 2.73            2.90          7.06e-04      0.97
   4    2.32      0.15                 2.72            2.87          6.73e-04      0.96
   5    2.02      0.13                 2.70            2.83          7.17e-04      0.96
   6    1.72      0.11                 2.74            2.85          6.96e-04      0.95
   7    1.42      0.09                 2.77            2.86          6.33e-04      0.94
   8    1.12      0.07                 2.74            2.81          7.26e-04      0.94
   9    0.82      0.05                 2.75            2.81          6.49e-04      0.93
  10    0.52      0.03                 2.70            2.73          6.71e-04      0.92
  11    0.22      0.01                 2.74            2.75          8.06e-04      0.91

------------------------------------------------------------------------------------------------


