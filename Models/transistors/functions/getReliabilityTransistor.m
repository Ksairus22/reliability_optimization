function [lambda] = getReliabilityTransistor(lambdaB, kPr, kR, kF, kS1, kE)
    lambda = lambdaB*kPr*kR*kF*kS1*kE;
end