function F = getFunctionSystemMultiMixedFull(x, DataSystem, VarSystem)
    VarSystem.IteratorCapacitor   = x(1);
    VarSystem.IteratorResistor_B  = x(2);
    VarSystem.IteratorResistor_BE = x(2);
    VarSystem.IteratorResistor_E  = x(2);
    VarSystem.IteratorTransistor  = x(3);

    VarSystem.capacity      = x(4);
    VarSystem.resistance_B  = x(5);
    VarSystem.resistance_BE = x(6);
    VarSystem.resistance_E  = x(7);

    [lambda, rin] = getReliabilityResInSystemFromData(DataSystem, VarSystem);  

    F = [-abs(rin), abs(lambda)]; 

end