function F = getFunctionSystemMultiCont(x, DataSystem, VarSystem)

    VarSystem.resistance_BE = x(1);
    VarSystem.resistance_B = x(1);
    VarSystem.resistance_E = x(2);
    % x;
    
    [lambda, rin] = getReliabilityResInSystemFromData(DataSystem, VarSystem);  

    F = [-rin, lambda];  

end
