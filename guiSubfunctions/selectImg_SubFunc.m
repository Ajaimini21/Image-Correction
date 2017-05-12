function selectImg_SubFunc(handles)
%function selectImg_SubFunc(handles)
%   handles: GUI structure
%
% Andrew Sack
% Lab LA
% 5/10/17

global imgSelected imgOrig imgDistort;

filename = uigetfile('Data/*.jpg'); % launches file browser
set(handles.imgPath,'string', filename);
imgSelected = 1; % for error prevention, lets code know a image is loaded
set(handles.errMsg,'string', '');
imgOrig = imread(filename);
image(handles.imgWindow, imgOrig); %plots image in GUI window

%adjust aspect ratio
handles.imgWindow.DataAspectRatio = [1 1 1];
set(handles.imgWindow,'visible','off'); % turn off axis

imgDistort = NaN;

end
