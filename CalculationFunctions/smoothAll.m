function [smoothImg, loadNum, totLoad] = smoothAll(img, M, N, loadNum, totLoad)
%function [smoothImg, loadNum, totLoad] = smoothAll(img, M, N, loadNum, totLoad)
%   Inputs:
%       img: matrix of uint8 image data to be corrected
%       M: x/row size dimension of box surrounding a pixel that is included 
%       in the median filtering.
%       N: y/column sized dimension of box surrounding a pixel that is 
%       included in the median filtering.
%       loadNum: current number of times the waitbar has updated
%       totLoad: total number of times waitbar will update 
%   Output:
%       smoothImg: matrix of uint8 corrected image data
%       loadNum: updated counter value
%
% Andrew Sack
% Lab LA
% 5/10/17

iDub = im2double(img); % converts uint8 to double
[numRows, numCols, numChan] = size(img);

smoothImg = img;

m = round((M-1)/2);
n = round((N-1)/2);

for curChan = 1:numChan
    for row = 1:numRows
        for col = 1:numCols                                                                              
                tempVal = [];
                for curRow = row-m : row+m
                    for curCol = col-n : col+n 
                        if (curRow >= 1) && (curRow <= numRows) && (curCol >= 1) && (curCol <= numCols)
                            tempVal = [tempVal img(curRow, curCol, curChan)];
                        end
                    end
                end
            smoothImg(row, col, curChan) = median(tempVal);
        end
        loadNum = loadNum + 1;
        waitbar(loadNum/totLoad);
    end
end

smoothImg = uint8(smoothImg);

end