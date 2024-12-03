function [lambdaB, kPr, kR, kE] = getCoefDiodFromFile(filename, rownum, iRelative, t)
    [~, ~, ~, ~, ~, lambdaB] = getTableDiod(filename, rownum);
    [lambdaB, kPr, kR, kE] = getCoefDiod(lambdaB, iRelative, t);
end