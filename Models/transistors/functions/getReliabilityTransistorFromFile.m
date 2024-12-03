function [lambda] = getReliabilityTransistorFromFile(filename, rownum, pRelative, t, s1)
[~, ~, ~, ~, ~, tTrMax, tLow, lambdaB] = getTableTransistor(filename, rownum);
[lambdaB, kPr, kR, kF, kS1, kE] = getCoefTransistor(tTrMax, tLow, lambdaB, pRelative, t, s1);
[lambda] = getReliabilityTransistor(lambdaB, kPr, kR, kF, kS1, kE);
end