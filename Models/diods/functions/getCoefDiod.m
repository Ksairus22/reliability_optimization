function [lambdaB, kPr, kR, kE] = getCoefDiod(lambdaB, iRelative, t)

    kPr = getCoefDiod_kPr(1);         
    kR = getCoefDiod_kR(iRelative, t);
    kE = getCoefDiod_kE(1);

end
