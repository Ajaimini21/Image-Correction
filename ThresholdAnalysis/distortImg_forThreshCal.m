function [newImg, numDistorted, distortIndex] = distortImg_forThreshCal(img, distortPercent)
%function newImg = distortImg(img, distortPercent)
%   Inputs:
%       img: input image of any number of channels
%       distortPercent: Percentage (0-100) # of pixel distortions/# of
%       pixels in image (The actual percentage of distorted pixels will be
%       lower due to repeated pixels)
%   Output:
%       newImg: distorted image
%       numDistorted: returns the number of unique pixels actually
%       distorted
%
% Andrew Sack
% Lab LA
% 5/10/17

% This function will randomly select the desired number of pixels and then
% replace their values with random color values across all channels

[rows, columns, ~] = size(img);

distortAmount = distortPercent/100;
pixels = rows * columns;
distortNum = round(pixels * distortAmount); % # of pixels to distort

distortIndex = zeros(distortNum, 2); % matrix of distorted pixel locations


distortIndex(:, 1) = randi(rows, distortNum, 1); % x values of distorted pixels
distortIndex(:, 2) = randi(columns, distortNum, 1); % y values of distorted pixels

distortValue = randi(255, distortNum, 3);% separate matrix of distorted pixel values

newImg = img; 

for k = 1:distortNum
    newImg(distortIndex(k,1),distortIndex(k,2),:) = distortValue(k, :);
end

newImg = uint8(newImg);

if isempty(distortIndex) % need special case for distortPercent of 0
    numDistorted = 0;
else
    [numDistorted, ~] = size(unique(distortIndex,'rows'));%calc number of unique pixels
end

end

