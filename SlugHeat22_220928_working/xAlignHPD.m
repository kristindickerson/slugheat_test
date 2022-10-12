%%% ==============================================================================
%   Purpose: 
%     This function aligns the X axes of each plot on the heat pulse decay
%     tab. The left edges of the inner position and the plots' widths are
%     aligned. The order of the plots entered is the order of importance.
%     All plots will be aligned according the the first named plot's position. 
%%% ==============================================================================

function xAlignHPD(AllPlots, Axes1, Axes2)

if AllPlots == 1 % If all plots are visible
    Axes2.InnerPosition(1) = Axes1.InnerPosition(1);
    Axes2.InnerPosition(3) = Axes1.InnerPosition(3);
end