function [lambda] = getReliabilityTransistorFromData(Data, rownum, pRelative, t, s1)
    [lambdaB, kPr, kR, kF, kS1, kE] = getCoefTransistorFromData(Data, rownum, pRelative, t, s1);
    [lambda] = getReliabilityTransistor(lambdaB, kPr, kR, kF, kS1, kE);
end
