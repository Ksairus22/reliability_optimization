function [kR] = getCoefTransistor_kR(tTrMax, tLow, pRelative, t)
    kEl = pRelative;
    % kEl = getCoefTransistor_kEl(pRelative);

    a = 5.2;
    nT = -1162;
    tM = 448;
    l = 13.8;
    dt = 150;            
    kR = a*exp(nT/(273+t+(175-tTrMax)+dt*kEl*((tTrMax-tLow)/150)))*...
        exp(((273+t+(175-tTrMax)+dt*kEl*((tTrMax-tLow)/150))/tM)^l);
end