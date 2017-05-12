function distortGo_SubFunc(handles)
%function distortGo_SubFunc(handles)
%   handles: GUI structure
%
% Andrew Sack
% Lab LA
% 5/10/17

global imgSelected imgOrig imgDistort distortPercent;

distortPercent = str2double(get(handles.distortPercent,'string')); %inputs # from GUI and converts from string
if imgSelected == 1 % check an img has been loaded
    imgDistort = distortImg(imgOrig, distortPercent); % calls img distortion fcn
    image(handles.imgWindow, imgDistort); %plot in gui

    %adjust aspect ratio
    handles.imgWindow.DataAspectRatio = [1 1 1];
    set(handles.imgWindow,'visible','off'); % turn off axis

else
    set(handles.errMsg,'string', 'Select an Image First'); % gives error msg
end

end

