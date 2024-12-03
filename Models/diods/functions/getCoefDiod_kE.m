function [kE] = getCoefDiod_kE(eGroup)
    kEVec = [1, 1.5, 2.5, 2.5, 3.5, 4.5, 5, 9, 6, 12, 18, 7, 10, 1];
    kE = kEVec(eGroup);
end