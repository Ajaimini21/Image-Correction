function genCorr_SubFunc(handles)
%function genCorr_SubFunc(handles)
%   handles: GUI structure
%
% Andrew Sack
% Lab LA
% 5/10/17

global imgSelected imgOrig imgDistort M N smoothImg t numIter isSelective;

tic;

if imgSelected ~= 1
    set(handles.errMsg,'string', 'Select an Image First'); % gives error msg
    return;
end

isSelective = 0; % lets code know which method was used for txt file

if ~isnan(imgDistort)
    img = imgDistort;
else 
    img = imgOrig;
end

[numRows, numCols, numChan] = size(img);

%wait bar stuff
loadNum = 0;
totLoad = numRows*numChan*numIter;
h = waitbar(0, 'Image Correction Processing');

for k = 1:numIter %runs correction numIter times
    [smoothImg, loadNum] = smoothAll(img, M, N, loadNum, totLoad);
    img = smoothImg;
end

image(handles.imgWindow, smoothImg); %plot in gui

%adjust aspect ratio
handles.imgWindow.DataAspectRatio = [1 1 1];
set(handles.imgWindow,'visible','off'); % turn off axis

close(h)
t = toc;

end
