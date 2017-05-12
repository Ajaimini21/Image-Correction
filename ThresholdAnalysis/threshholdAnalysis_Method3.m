function [ idealThresh, realPercent ] = threshholdAnalysis_Method3(img, percentExclude)
%function [ idealThresh, realPercent ] = threshholdAnalysis_Method3(img, percentExclude)
%   Detailed explanation goes here
%
% Andrew Sack
% Lab LA
% 5/10/17


[x, y, ~] = size(img);
numPixels = x*y;

decExclude = percentExclude/100; %finds the 10th percentile smallest value

realPercent(1) = 0;
idealThresh(1) = 1;
n = 2;

for k = 10:10:70
    
    [img2, numDistorted, cLoc] = distortImg_forThreshCal(img,k);
    locUnique = unique(cLoc,'rows');
    medDiffs = distortedMedDiffs(img2,locUnique);
    realPercent(n) = (numDistorted/numPixels)*100; %calculates actual percent of pixels distorted
    
    % thresh is the numDistorted largest medDifference value
    % this method assumes the distorted pixels are all the most different from
    % their surroundings
    diffsSorted = sort(medDiffs, 'ascend'); %arranges the differences from small to large
    location = round(length(diffsSorted)*decExclude);
    idealThresh(n) = diffsSorted(location); 
    
    n = n+1;
  
end



end

