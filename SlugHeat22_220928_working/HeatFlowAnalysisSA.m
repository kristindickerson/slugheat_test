%%% ======================================================================
%   Purpose: 
%   This function ...
%%% ======================================================================

function   [ ...
             SensorsUsedForBullardFit, ...
             GoodkIndex, ...
             ShiftedCTRSA, ...
             ShiftedRelativeDepthsSA, ...
             SigmaR, ...
             PenetrationLag, ...
             SlopeSA, ...
             Shift, ...
             S_BullPlots, ...
             HeatFlow, ...
             Averagek, ...
             Gradient] = HeatFlowAnalysisSA(NumberOfSensors, ...
             RelativeDepths, ...
             Currentk, ...
             MinimumFricEqTemp, ...
             Badk, ...
             BadT, ...
             SensorsToUse)

             
S_BullPlots = [];
HeatFlow = [];
Gradient = [];
Averagek = [];


% ====================================== %
%               COMPUTE                  %
% ====================================== %

    % Define what sensors to use
    % --------------------------
    
    GoodT = setxor(1:NumberOfSensors,BadT);
    Goodk = setxor(1:NumberOfSensors,Badk);
    
    TToUse = intersect(GoodT,SensorsToUse);    % SensorsToUse for temperature calculations (T)
    kToUse = intersect(Goodk,SensorsToUse);    % SensorsToUse for thermal conductivity calculations (k)


    % Relative Depths
    % ---------------
    
    % Here we do a least-squares fit of the Temperatures other than 
    % those ignored (SensorsToUse) and those discarded (BadT).

     MinimumFricEqTemp = MinimumFricEqTemp';
    
    [pz,Sz] = polyfit(MinimumFricEqTemp(TToUse),RelativeDepths(TToUse),1);
    Shift(1) = -pz(2);
    SlopeSA(1) = pz(1);
    
    ShiftedRelativeDepthsSA = RelativeDepths + Shift(1);	
    PenetrationLag(1) = ShiftedRelativeDepthsSA(max(TToUse));  % With respect to top
                                                               % sensor not ignored
                                                               % or discarded
    z1min = min([RelativeDepths ShiftedRelativeDepthsSA]);
    z1max = max([RelativeDepths ShiftedRelativeDepthsSA]);


%
    % Cumulative thermal resistance
    % --------------
    
    % Here we compute Bullard Depths using all conductivities not ignored or discarded
    % (even if the Temperature was discarded)
    
    CTRSA = ShiftedRelativeDepthsSA(max(kToUse))/Currentk(max(kToUse)) ...
        + fliplr(cumtrapz(fliplr(ShiftedRelativeDepthsSA(kToUse)),1./fliplr(Currentk(kToUse))));
    
    % Now we need to determine the indices of the CTRSA vector that correspond to
    % to the valid Temperatures (i.e., those not discarded - we can forget about the Sensors
    % originally ignored since they are already ignored in the Bullard Depths calculation.
    
    [GoodCTRSA,GoodTIndex,GoodkIndex] = intersect(TToUse,kToUse);
    SensorsUsedForBullardFit = GoodCTRSA;
    [pR,SR] = polyfit(MinimumFricEqTemp(GoodCTRSA),CTRSA(GoodkIndex),1);
    [dummy,SigmaR] = polyval(pR,MinimumFricEqTemp(GoodCTRSA),SR);
    
    [rcoef,pcoef,rlo,rup]=corrcoef(MinimumFricEqTemp(GoodCTRSA),CTRSA(GoodkIndex));
    %disp([' R    = ',num2str(rcoef(2,1))])
    %disp([' Rlow = ',num2str(rlo(2,1))])
    
    Shift(2) = -pR(2);
    SlopeSA(2) = pR(1);

    [pGradient,sGradient]=polyfit(CTRSA(GoodkIndex),MinimumFricEqTemp(GoodCTRSA),1);
    [dummyGradient,SigmaRGradient]=polyval(pGradient,CTRSA(GoodkIndex),sGradient);
    MeanSigmaRGradient = mean(SigmaRGradient)/2;

    ShiftedCTRSA = CTRSA + Shift(2);

    z2min = min([CTRSA ShiftedCTRSA]);
    z2max = max([CTRSA ShiftedCTRSA]);

         %% Average Thermal Conductivity +/- 1 std
%        % --------------------------------------
         x = Currentk(kToUse);
         x = [x(1) x];
% 
         kmean = mean(x);
         kstd  = std(x); 
         Gradient = 1/SlopeSA(1);
         DepthToTopSens = PenetrationLag(1);
%
%        % Convert to mW
%        % ------------
         Averagek = kmean;
         HeatFlow = round((1/SlopeSA(2))*1000);
         
         HFShift = Shift(2);






