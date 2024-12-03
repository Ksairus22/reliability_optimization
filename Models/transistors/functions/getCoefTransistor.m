function [lambdaB, kPr, kR, kF, kS1, kE] = getCoefTransistor(tTrMax, tLow, lambdaB, pRelative, t, s1)

    kPr = getCoefTransistor_kPr(1);         
    kR = getCoefTransistor_kR(tTrMax, tLow, pRelative, t);
    kF = getCoefTransistor_kF(3);
    kS1 = getCoefTransistor_kS1(s1);
    kE = getCoefTransistor_kE(1);

end
