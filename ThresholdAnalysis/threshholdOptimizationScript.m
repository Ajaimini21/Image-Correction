% Andrew Sack
% Lab LA
% 5/10/17
% main script for testing optimal threshold

clear all;
close all;

tic;

addpath('Data');

allFiles = {'bw_cubes','bw_plain', 'cake','puppy',...
    'purple','rubixCube','sunset','tree', 'wheat', 'monaLisa'} ;

for k = 1:length(allFiles)
    fieldName = allFiles{k};
    filename = [allFiles{k} '.jpg'];
    
    img = imread(filename);
    n = (k-1)*5;
    
    [idealThresh(n+1, :),~] = threshholdAnalysis_Method2(img);
    [idealThresh(n+2, :),~] = threshholdAnalysis_Method3(img, 1);
    [idealThresh(n+3, :),~] = threshholdAnalysis_Method3(img, 5);
    [idealThresh(n+4, :),~] = threshholdAnalysis_Method3(img, 10);
    [idealThresh(n+5, :),~] = threshholdAnalysis_Method3(img, 20);
end

time = toc;

save threshFile.mat;