function [lambda] = getReliabilityDiodFromFile(filename, rownum, iRelative, t)
    [~, ~, ~, ~, ~, lambdaB] = getTableDiod(filename, rownum);
    [lambdaB, kPr, kR, kE] = getCoefDiod(lambdaB, iRelative, t);
    [lambda] = getReliabilityDiod(lambdaB, kPr, kR, kE);
end