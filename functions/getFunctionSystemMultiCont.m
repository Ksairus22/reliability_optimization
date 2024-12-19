function F = getFunctionSystemMultiCont(x, DataSystem, VarSystem)

    VarSystem.resistance_BE = x(1);
    VarSystem.resistance_B = x(1);
    VarSystem.resistance_E = x(2);
    % x;
    
    [f1,f2] = getReliabilityResInSystemFromData(DataSystem, VarSystem);  

    F = [f1, -f2];  

end
