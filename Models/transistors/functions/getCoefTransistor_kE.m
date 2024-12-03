function [kE] = getCoefTransistor_kE(eGroup)
    kEVec = [1, 2, 5, 5, 9, 9, 8, 16, 4, 18, 19, 7, 10, 1];
    kE = kEVec(eGroup);
end