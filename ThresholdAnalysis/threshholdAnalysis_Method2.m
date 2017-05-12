function [ idealThresh, realPercent ] = threshholdAnalysis_Method2(img)
%function [ idealThresh, realPercent ] = threshholdAnalysis_Method2(img)
%   Detailed explanation goes here
%
% Andrew Sack
% Lab LA
% 5/10/17

n = 1;
[x, y, ~] = size(img);
numPixels = x*y;

for k = 0:10:70
    
    [img2, numDistorted] = distortImg_forThreshCal(img,k);
    medDiffs = calcMedianDiffs(img2);
    realPercent(n) = (numDistorted/numPixels)*100; %calculates actual percent of pixels distorted
    
    % thresh is the numDistorted largest medDifference value
    % this method assumes the distorted pixels are all the most different from
    % their surroundings
    diffsSorted = sort(medDiffs, 'descend'); %arranges the differences from large to small
    idealThresh(n) = diffsSorted((numDistorted*3)+1); 
    
    n = n+1;
  
end



end

