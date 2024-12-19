function F = getFunctionSystemUnoMixed(x, DataSystem, VarSystem)

    VarSystem.IteratorTransistor  = x(1);
    VarSystem.resistance_B = x(2);
    VarSystem.resistance_BE = x(2);
    
    F = getReliabilitySystemFromData(DataSystem, VarSystem);  

end