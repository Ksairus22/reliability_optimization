function [lambda] = getReliabilityDiod(lambdaB, kPr, kR, kE)
    lambda = lambdaB*kPr*kR*kE;
end