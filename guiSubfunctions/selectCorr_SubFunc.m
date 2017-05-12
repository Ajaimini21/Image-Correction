function selectCorr_SubFunc(handles)
%function selectCorr_SubFunc(handles)
%   handles: GUI structure
%
% Andrew Sack
% Lab LA
% 5/10/17

global imgSelected imgOrig imgDistort thresh M N smoothImg t numIter isSelective;

tic;

if imgSelected ~= 1
    set(handles.errMsg,'string', 'Select an Image First'); % gives error msg
    return;
end

isSelective = 1; % lets code know which method was used for txt file

if ~isnan(imgDistort)
    img = imgDistort;
else 
    img = imgOrig;
end

[numRows, numCols, numChan] = size(img);

% waitbar stuff
loadNum = 0;
totLoad = numRows*numChan*numIter;
h = waitbar(0, 'Image Correction Processing');

for k = 1:numIter % runs correction numIter time
    [smoothImg, loadNum] = combinedSmooth(img, thresh, M, N, loadNum, totLoad);
    img = smoothImg;
end

image(handles.imgWindow, smoothImg); %plot in gui

%adjust aspect ratio
handles.imgWindow.DataAspectRatio = [1 1 1];
set(handles.imgWindow,'visible','off'); % turn off axis

close(h)
t = toc;

end

