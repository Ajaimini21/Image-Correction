function saveJPG_SubFunc(handles)
%function saveJPG_SubFunc(handles)
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

imwrite(handles.imgWindow.Children.CData, ['Results/' saveName{:} '.jpg']); % saves img currently in GUI window as jpg

end