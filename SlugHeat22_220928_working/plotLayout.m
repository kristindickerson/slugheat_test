%%% ==============================================================================
%   Purpose: 
%     This function turns visibility of children of plots on and off depending on if
%     their axes are turned off or on with the use of checkboxes, etc.
%     There are two smaller functions nested within:
%           1. axesChildrenOFF - turns OFF an visibility of axes' children
%           2. axesChildrenON - turns ON the visibility of axes' children
%%% ==============================================================================


% ---------------------------------------------------------
% Main function
% ---------------------------------------------------------

function plotLayout(grid, Plot1, Axes1, Plot2, Axes2, ...
    Plot3, Axes3, Plot4, Axes4)

if length(grid.RowHeight) == 5
    % Turn all values of plot checkboxes to strings
    % ---------------------------------------------
    ap = num2str(Plot2);
    bp = num2str(Plot1);
    cp = num2str(Plot3);
    dp = '5';
    
    % Concatenate strings of values with the letter x so that this
    % string can be used in the grid layout function
    % ---------------------------------------------
    apx = strcat(ap, 'x');
    bpx = strcat(bp, 'x');
    cpx = strcat(cp, 'x');
    dpx = strcat(dp, 'x');

    % Update grid layout. 
    % Keep temperature plot at a constant weight 5x all other plots
    % ---------------------------------------------
    grid.RowHeight = {dpx, apx, bpx, cpx, 'fit'};

    % Update children visibility based on axes visibility
    % ---------------------------------------------
    AC = Axes1.Children;
    BC = Axes2.Children;
    CC = Axes3.Children;
    DC = Axes4.Children;
            
    if Plot1 == 0 && Plot2 == 0 && Plot3 == 0 && Plot4 == 0
            Axes1.Visible = 'off';
            C = AC;
            axesChildrenOFF(C)
    
            Axes2.Visible = 'off';
            C = BC;
            axesChildrenOFF(C)
    
            Axes3.Visible = 'off';
            C = CC;
            axesChildrenOFF(C)
    
            Axes4.Visible = 'off';
            C = DC;
            axesChildrenOFF(C)
    
    elseif Plot1 == 1 && Plot2 == 0 && Plot3 == 0 && Plot4 == 0
            Axes1.Visible = 'on';
            C = AC;
            axesChildrenON(C)
    
            Axes2.Visible = 'off';
            C = BC;
            axesChildrenOFF(C)
    
            Axes3.Visible = 'off';
            C = CC;
            axesChildrenOFF(C)
    
            Axes4.Visible = 'off';
            C = DC;
            axesChildrenOFF(C)
    
    elseif Plot1 == 0 && Plot2 == 1 && Plot3 == 0 && Plot4 == 0
            Axes1.Visible = 'off';
            C = AC;
            axesChildrenOFF(C)
    
            Axes2.Visible = 'on';
            C = BC;
            axesChildrenON(C)
    
            Axes3.Visible = 'off';
            C = CC;
            axesChildrenOFF(C)
    
            Axes4.Visible = 'off';
            C = DC;
            axesChildrenOFF(C)
    
    elseif Plot1 == 0 && Plot2 == 0 && Plot3 == 1 && Plot4 == 0
            Axes1.Visible = 'off';
            C = AC;
            axesChildrenOFF(C)
    
            Axes2.Visible = 'off';
            C = BC;
            axesChildrenOFF(C)
    
            Axes3.Visible = 'on';
            C = CC;
            axesChildrenON(C)
    
            Axes4.Visible = 'off';
            C = DC;
            axesChildrenOFF(C)
    
     elseif Plot1 == 0 && Plot2 == 0 && Plot3 == 0 && Plot4 == 1
            Axes1.Visible = 'off';
            C = AC;
            axesChildrenOFF(C)
    
            Axes2.Visible = 'off';
            C = BC;
            axesChildrenOFF(C)
    
            Axes3.Visible = 'off';
            C = CC;
            axesChildrenOFF(C)
    
            Axes4.Visible = 'on';
            C = DC;
            axesChildrenON(C)
    
    elseif Plot1 == 1 && Plot2 == 1 && Plot3 == 0 && Plot4 == 0
            Axes1.Visible = 'on';
            C = AC;
            axesChildrenON(C)
    
            Axes2.Visible = 'on';
            C = BC;
            axesChildrenON(C)
    
            Axes3.Visible = 'off';
            C = CC;
            axesChildrenOFF(C)
    
            Axes4.Visible = 'off';
            C = DC;
            axesChildrenOFF(C)
    
    elseif Plot1 == 1 && Plot2 == 0 && Plot3 == 1 && Plot4 == 0
            Axes1.Visible = 'on';
            C = AC;
            axesChildrenON(C)
    
            Axes2.Visible = 'off';
            C = BC;
            axesChildrenOFF(C)
    
            Axes3.Visible = 'on';
            C = CC;
            axesChildrenON(C)
    
            Axes4.Visible = 'off';
            C = DC;
            axesChildrenOFF(C)
    
    elseif Plot1 == 1 && Plot2 == 0 && Plot3 == 0 && Plot4 == 1
            Axes1.Visible = 'on';
            C = AC;
            axesChildrenON(C)
    
            Axes2.Visible = 'off';
            C = BC;
            axesChildrenOFF(C)
    
            Axes3.Visible = 'off';
            C = CC;
            axesChildrenOFF(C)
    
            Axes4.Visible = 'on';
            C = DC;
            axesChildrenON(C)
    
    elseif Plot1 == 0 && Plot2 == 1 && Plot3 == 1 && Plot4 == 0
            Axes1.Visible = 'off';
            C = AC;
            axesChildrenOFF(C)
    
            Axes2.Visible = 'on';
            C = BC;
            axesChildrenON(C)
    
            Axes3.Visible = 'on';
            C = CC;
            axesChildrenON(C)
    
            Axes4.Visible = 'off';
            C = DC;
            axesChildrenOFF(C)
    
    elseif Plot1 == 0 && Plot2 == 1 && Plot3 == 0 && Plot4 == 1
            Axes1.Visible = 'off';
            C = AC;
            axesChildrenOFF(C)
    
            Axes2.Visible = 'on';
            C = BC;
            axesChildrenON(C)
    
            Axes3.Visible = 'off';
            C = CC;
            axesChildrenOFF(C)
    
            Axes4.Visible = 'on';
            C = DC;
            axesChildrenON(C)
    
    elseif Plot1 == 0 && Plot2 == 0 && Plot3 == 1 && Plot4 == 1
            Axes1.Visible = 'off';
            C = AC;
            axesChildrenOFF(C)
    
            Axes2.Visible = 'off';
            C = BC;
            axesChildrenOFF(C)
    
            Axes3.Visible = 'on';
            C = CC;
            axesChildrenON(C)
    
            Axes4.Visible = 'on';
            C = DC;
            axesChildrenON(C)
    
    elseif Plot1 == 1 && Plot2 == 1 && Plot3 == 1 && Plot4 == 0
            Axes1.Visible = 'on';
            C = AC;
            axesChildrenON(C)
    
            Axes2.Visible = 'on';
            C = BC;
            axesChildrenON(C)
    
            Axes3.Visible = 'on';
            C = CC;
            axesChildrenON(C)
    
            Axes4.Visible = 'off';
            C = DC;
            axesChildrenOFF(C)
    
     elseif Plot1 == 0 && Plot2 == 1 && Plot3 == 1 && Plot4 == 1
            Axes1.Visible = 'off';
            C = AC;
            axesChildrenOFF(C)
    
            Axes2.Visible = 'on';
            C = BC;
            axesChildrenON(C)
    
            Axes3.Visible = 'on';
            C = CC;
            axesChildrenON(C)
    
            Axes4.Visible = 'on';
            C = DC;
            axesChildrenON(C)
    
     elseif Plot1 == 1 && Plot2 == 0 && Plot3 == 1 && Plot4 == 1
            Axes1.Visible = 'on';
            C = AC;
            axesChildrenON(C)
    
            Axes2.Visible = 'off';
            C = BC;
            axesChildrenOFF(C)
    
            Axes3.Visible = 'on';
            C = CC;
            axesChildrenON(C)
    
            Axes4.Visible = 'on';
            C = DC;
            axesChildrenON(C)
    
    elseif Plot1 == 1 && Plot2 == 1 && Plot3 == 0 && Plot4 == 1
            Axes1.Visible = 'on';
            C = AC;
            axesChildrenON(C)
    
            Axes2.Visible = 'on';
            C = BC;
            axesChildrenON(C)
    
            Axes3.Visible = 'off';
            C = CC;
            axesChildrenOFF(C)
    
            Axes4.Visible = 'on';
            C = DC;
            axesChildrenON(C)
    
    elseif Plot1 == 1 && Plot2 == 1 && Plot3 == 1 && Plot4 == 1
            Axes1.Visible = 'on';
            C = AC;
            axesChildrenON(C)
    
            Axes2.Visible = 'on';
            C = BC;
            axesChildrenON(C)
    
            Axes3.Visible = 'on';
            C = CC;
            axesChildrenON(C)
    
            Axes4.Visible = 'on';
            C = DC;
            axesChildrenON(C)
    end
    
           

elseif length(grid.RowHeight) == 2 && length(grid.ColumnWidth) == 2

    if Plot1==0 && Plot2==0 && Plot3==0 && Plot4==0
        grid.RowHeight = {'1x', '1x'};
        grid.ColumnWidth = {'1x', '1x'};
        Axes1.Visible = 'on';
        Axes2.Visible = 'on';
        Axes3.Visible = 'on';
        Axes4.Visible = 'on';
        axesChildrenON(Axes1.Children)
        axesChildrenON(Axes2.Children)
        axesChildrenON(Axes3.Children)
        axesChildrenON(Axes4.Children)
    elseif Plot1==1
        grid.RowHeight = {'1x', '0x'};
        grid.ColumnWidth = {'1x', '0x'};
        Axes1.Visible = 'on';
        Axes2.Visible = 'off';
        Axes3.Visible = 'off';
        Axes4.Visible = 'off';
        axesChildrenON(Axes1.Children)
        axesChildrenOFF(Axes2.Children)
        axesChildrenOFF(Axes3.Children)
        axesChildrenOFF(Axes4.Children)
    elseif Plot2==1
        grid.RowHeight = {'1x', '0x'};
        grid.ColumnWidth = {'0x', '1x'};
        Axes1.Visible = 'off';
        Axes2.Visible = 'on';
        Axes3.Visible = 'off';
        Axes4.Visible = 'off';
        axesChildrenOFF(Axes1.Children)
        axesChildrenON(Axes2.Children)
        axesChildrenOFF(Axes3.Children)
        axesChildrenOFF(Axes4.Children)
    elseif Plot3==1
        grid.RowHeight = {'0x', '1x'};
        grid.ColumnWidth = {'1x', '0x'};
        Axes1.Visible = 'off';
        Axes2.Visible = 'off';
        Axes3.Visible = 'on';
        Axes4.Visible = 'off';
        axesChildrenOFF(Axes1.Children)
        axesChildrenOFF(Axes2.Children)
        axesChildrenON(Axes3.Children)
        axesChildrenOFF(Axes4.Children)
    elseif Plot4==1
        grid.RowHeight = {'0x', '1x'};
        grid.ColumnWidth = {'0x', '1x'};
        Axes1.Visible = 'off';
        Axes2.Visible = 'off';
        Axes3.Visible = 'off';
        Axes4.Visible = 'on';
        axesChildrenOFF(Axes1.Children)
        axesChildrenOFF(Axes2.Children)
        axesChildrenOFF(Axes3.Children)
        axesChildrenON(Axes4.Children)
    end

elseif length(grid.RowHeight) == 2 && length(grid.ColumnWidth) == 3
    %...
elseif length(grid.RowHeight) == 2 && length(grid.ColumnWidth) == 1
    if Plot1==1 && Plot2==1
        Axes1.Visible = 'on';
        Axes2.Visible = 'on';
        axesChildrenON(Axes1.Children)
        axesChildrenON(Axes2.Children)
    elseif Plot1==1 && Plot2==0
        Axes1.Visible = 'on';
        Axes2.Visible = 'off';
        axesChildrenON(Axes1.Children)
        axesChildrenOFF(Axes2.Children)
    elseif Plot1==0 && Plot2==1
        Axes1.Visible = 'off';
        Axes2.Visible = 'on';
        axesChildrenOFF(Axes1.Children)
        axesChildrenON(Axes2.Children)
    elseif Plot1==0 && Plot2==0
        Axes1.Visible = 'off';
        Axes2.Visible = 'off';
        axesChildrenOFF(Axes1.Children)
        axesChildrenOFF(Axes2.Children)
    end
end
end
            % Nested function to turn visibility of axes' children OFF
            % ---------------------------------------------------------
             function axesChildrenOFF(C)
                    for k = 1:numel(C)
                        S(1).type = '()';
                        S(1).subs = {k};
                        S(2).type = '.';
                        S(2).subs = 'Visible';
                        C = subsasgn(C, S, 'off');
                    end
             end
    
    
            % Nested function to turn visibility of axes' children ON
            % ---------------------------------------------------------
            function axesChildrenON(C)
                    for k = 1:numel(C)
                        S(1).type = '()';
                        S(1).subs = {k};
                        S(2).type = '.';
                        S(2).subs = 'Visible';
                        C = subsasgn(C, S, 'on');
                    end
                
            end