function [lambda] = getReliabilityDiodFromData(Data, rownum, iRelative, t)
    [lambdaB, kPr, kR, kE] = getCoefDiodFromData(Data, rownum, iRelative, t);
    [lambda] = getReliabilityDiod(lambdaB, kPr, kR, kE);
end