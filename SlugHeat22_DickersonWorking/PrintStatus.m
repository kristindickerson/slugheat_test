%%% ==============================================================================
% 	Purpose: 
%	This function is used to print out the current status of of the program onto an
%	output file, generally either the Log file or Res file
% 
%	FileID = file to be written on
%	Message = message to be written
%	LineFeed = how many lines to move cursor to after message (i.e if LineFeed = 1,
%	the next message will be written on the line directly under the current message.
%	If LineFeed = 2, there cursor will skip a line and there will be a space between
%	the current message and next message)
%%% ==============================================================================

function PrintStatus(FileID, Message,LineFeed)

if nargin<3
	fprintf(FileID,'%s', Message);
else
	Format = ['%s', repmat('\n',1,LineFeed)];
	fprintf(FileID,Format,Message);
end

end