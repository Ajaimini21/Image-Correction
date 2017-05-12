function saveCombo_SubFunc(handles)
%function saveCombo_SubFunc(handles)
%   handles: GUI structure
%
% Andrew Sack
% Lab LA
% 5/10/17

global imgSelected imgOrig imgDistort smoothImg; 

if imgSelected == 0 %if no img  
    set(handles.errMsg,'string', 'Select an Image First'); % gives error msg
    return;
elseif size(smoothImg) == 0 % if no corrected img
    set(handles.errMsg,'string', 'Run Image Correction First'); % gives error msg
    return;
end

saveName = inputdlg('Desired File Name (No extension)'); % user prompt for file name

numPlots = 3;
if isnan(imgDistort) % handles 2 or 3 plots
    numPlots = 2;
end

f = figure;
subplot(1,numPlots, 1);
image(imgOrig);
title('Original Image');

if numPlots == 3 %% only plots if imgDistort exists
    subplot(1,numPlots, 2);
    image(imgDistort);
    title('Distorted Image');
end

subplot(1,numPlots, numPlots);
image(smoothImg);
title('Corrected Image');
    
saveas(f, ['Results/' saveName{:}]); % save plot
    
close(f); % close plot


end