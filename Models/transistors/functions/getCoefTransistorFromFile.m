function [lambdaB, kPr, kR, kF, kS1, kE] = getCoefTransistorFromFile(filename, rownum, pRelative, t, s1)
[~, ~, ~, ~, ~, tTrMax, tLow, lambdaB] = getTableTransistor(filename, rownum);
[lambdaB, kPr, kR, kF, kS1, kE] = getCoefTransistor(tTrMax, tLow, lambdaB*1e-6, pRelative, t, s1);

end