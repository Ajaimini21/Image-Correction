function genTxt_SubFunc(handles)
%function genTxt_SubFunc(handles)
%   handles: GUI structure
%
% Andrew Sack
% Lab LA
% 5/10/17

global imgSelected imgOrig imgDistort smoothImg; 
global thresh M N numIter t distortPercent isSelective; 

if imgSelected == 0 %if no img  
    set(handles.errMsg,'string', 'Select an Image First'); % gives error msg
    return;
elseif size(smoothImg) == 0 % if no corrected img
    set(handles.errMsg,'string', 'Run Image Correction First'); % gives error msg
    return;
else
    set(handles.errMsg,'string', '');
end

saveName = inputdlg('Desired File Name (No extension)'); % user prompt for file name

fid = fopen(['Results/' saveName{:} '.txt'], 'wt'); % open writeable text file

%% text writing
fprintf(fid, 'Image Correction Details \n------------------------------------------------\n\n'); %top header

%% Original Image

fprintf(fid, 'Original Image: \n---------------\n');
[col, row, ~] = size(imgOrig);
fprintf(fid, 'size: %d x %d pixels \n\n', col, row);

%% Distorted img

if ~isnan(imgDistort) % if img was disorted
    fprintf(fid, 'Image Distortion: \n-----------------\n');
    fprintf(fid, 'distortion percent: %0.1f%% \n\n', distortPercent);
else
    fprintf(fid, '*image was not distorted*\n\n');
end

%% Corrected Image
fprintf(fid, 'Image Correction: \n-----------------\n');
fprintf(fid, 'parameters: \n');
if isSelective
    fprintf(fid, '\tcorrection method: selective \n');
    fprintf(fid, '\tthreshold: %0.2f \n',thresh); 
else
    fprintf(fid, '\tcorrection method: non-selective \n');
end
fprintf(fid, '\tM: %d \n',M); 
fprintf(fid, '\tN: %d \n',N); 
fprintf(fid, 'number of iterations: %d \n', numIter);
fprintf(fid, 'proccessing time: %0.1f seconds \n', t);

%% time stamp
fprintf(fid, '\n------------------------------------------------\n\n');
date = datetime('now','TimeZone','local','Format','d-MMM-y HH:mm:ss Z');
fprintf(fid, 'created: %s\n',date);
fprintf(fid, 'Andrew Sack');

fclose(fid);

end