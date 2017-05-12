function updateParam_SubFunc(handles)
%function updateParam_SubFunc(handles)
%   handles: GUI structure
%
% Andrew Sack
% Lab LA
% 5/10/17
% reads in image correction parameters

global thresh M N numIter;

%inputs # from GUI and converts from string to number
thresh = str2double(get(handles.editThresh,'string')); 
M = str2double(get(handles.editM,'string')); 
N = str2double(get(handles.editN,'string')); 
numIter = str2double(get(handles.editNumIt,'string')); 

end