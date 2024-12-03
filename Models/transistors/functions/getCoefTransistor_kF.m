function [kF] = getCoefTransistor_kF(fGroup)
    kFVec = [1.5, 0.7, 0.7, 15.0, 1.5];
    kF = kFVec(fGroup);
end