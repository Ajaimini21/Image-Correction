function saveCurr_SubFunc(handles)
%function saveCurr_SubFunc(handles)
%   handles: GUI structure
%
% Andrew Sack
% Lab LA
% 5/10/17

global imgSelected 

if imgSelected == 0 %if no img  
    set(handles.errMsg,'string', 'Select an Image First'); % gives error msg
    return;
else
    set(handles.errMsg,'string', '');    
end

saveName = inputdlg('Desired File Name (No extension)'); % user prompt for file name

f = figure;
image(handles.imgWindow.Children.CData); %replots data in gui plot window for capturing

saveas(f, ['Results/' saveName{:}]); % saves plot currently in GUI window
    
close(f);


end