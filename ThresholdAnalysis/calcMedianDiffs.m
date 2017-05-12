function medDiffs = calcMedianDiffs(img)
%function medDiffs = calcMedianDiffs(img)
%   Detailed explanation goes here
%
% Andrew Sack
% Lab LA
% 5/10/17

[numRows, numCols, numChan] = size(img);
iMag= zeros(numRows, numCols, numChan);

iDub = im2double(img);

m = 1;
n = 1;

for curChan = 1:numChan
    for row = 1:numRows
        for col = 1:numCols
            tempDiffs = [];
            for curRow = row-m : row+m
                for curCol = col-n : col+n 
                    if (curRow >= 1) && (curRow <= numRows) && (curCol >= 1) && (curCol <= numCols)&& (~((curCol == col)&&(curRow == row)))
                        tempDiffs = [tempDiffs abs(iDub(curRow, curCol, curChan)-iDub(row,col,curChan))];
                    end
                end
            end
            iMag(row, col, curChan) = median(tempDiffs);
        end
    end
end

medDiffs = iMag(:);



end

