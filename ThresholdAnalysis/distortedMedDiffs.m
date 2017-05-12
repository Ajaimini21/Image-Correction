function medDiffs = distortedMedDiffs(img, cLoc)
%function medDiffs = distortedMedDiffs(img, cLoc)
%   Detailed explanation goes here
%
% Andrew Sack
% Lab LA
% 5/10/17

[numRows, numCols, numChan] = size(img);


iDub = im2double(img);

m = 1;
n = 1;

[x, ~] = size(cLoc);
iMag= zeros(x, numChan);

for curChan = 1:numChan
    for k = 1:x
        row = cLoc(k,1);
        col = cLoc(k,2);
        tempDiffs = [];
            for curRow = row-m : row+m
                for curCol = col-n : col+n 
                    if (curRow >= 1) && (curRow <= numRows) && (curCol >= 1) && (curCol <= numCols)&& (~((curCol == col)&&(curRow == row)))
                        tempDiffs = [tempDiffs abs(iDub(curRow, curCol, curChan)-iDub(row,col,curChan))];
                    end
                end
            end
        iMag(k, curChan) = median(tempDiffs);
    end
end

medDiffs = iMag(:);

end

