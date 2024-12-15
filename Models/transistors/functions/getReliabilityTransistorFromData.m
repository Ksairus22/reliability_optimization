function [lambda] = getReliabilityTransistorFromData(Data, rownum, TransistorStruct)
    [CoefStruct] = getCoefTransistorFromData(Data, rownum, TransistorStruct);
    [lambda] = getReliabilityTransistor(CoefStruct);
end
