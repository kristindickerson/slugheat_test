%%% ==============================================================================
%   Purpose: 
%     This function aligns the X axes of each plot on the penetration data
%     tab. The left edges of the inner position and the plots' widths are
%     aligned. The order of the plots entered is the order of importance.
%     All plots will be aligned according the the first named plot's position. 
%%% ==============================================================================

function xAlign(Plot1, Axes1, Plot2, Axes2, Plot3, Axes3, Plot4, Axes4)

pause(1.5) % pause for 1 second required 

if  Plot1==1 % If the first plot is visible
    if Plot2==1
        Axes2.InnerPosition(1) = Axes1.InnerPosition(1);
        Axes2.InnerPosition(3) = Axes1.InnerPosition(3);
    end
    if Plot3==1
        Axes3.InnerPosition(1) = Axes1.InnerPosition(1);
        Axes3.InnerPosition(3) = Axes1.InnerPosition(3);
    end
    if Plot4==1
        Axes4.InnerPosition(1) = Axes1.InnerPosition(1);
        Axes4.InnerPosition(3) = Axes1.InnerPosition(3);
    end
    pause(1) % pause for 1 second required 
    drawnow;
elseif Plot1~=1
    Axes2.InnerPosition(1) = Axes4.InnerPosition(1);
    Axes2.InnerPosition(3) = Axes4.InnerPosition(3);
    Axes3.InnerPosition(1) = Axes4.InnerPosition(1);
    Axes3.InnerPosition(3) = Axes4.InnerPosition(3);
    pause(1) % pause for 1 second required 
    drawnow;
end
pause(1.5)