function [lambda] = getReliabilityTransistorFromVariables(tTrMax, tLow, lambdaB, pRelative, t, s1)
    [lambdaB, kPr, kR, kF, kS1, kE] = getCoefTransistor(tTrMax, tLow, lambdaB, pRelative, t, s1);
    [lambda] = getReliabilityTransistor(lambdaB, kPr, kR, kF, kS1, kE);
end