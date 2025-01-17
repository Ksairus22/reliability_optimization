function F = getFunctionSystemMultiDiscr(x, DataSystem, VarSystem)
    VarSystem.IteratorResistor_B  = x(1);
    VarSystem.IteratorResistor_BE = x(1);
    VarSystem.IteratorResistor_E  = x(1);
    VarSystem.IteratorTransistor  = x(2);

    [lambda, rin] = getReliabilityResInSystemFromData(DataSystem, VarSystem);  

    F = [-rin, lambda]; 

end