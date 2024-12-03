function [lambda] = getReliabilityDiodFromVariables(lambdaB, iRelative, t)
    [lambdaB, kPr, kR, kE] = getCoefDiod(lambdaB, iRelative, t);
    [lambda] = getReliabilityDiod(lambdaB, kPr, kR, kE);
end