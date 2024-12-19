function F = getFunctionSystemUnoDiscr(x, DataSystem, VarSystem)

    % VarSystem.IteratorCapacitor   = x(1);
    % VarSystem.IteratorDiod        = x(2);
    VarSystem.IteratorResistor_B  = x(1);
    VarSystem.IteratorResistor_BE  = x(1);
    VarSystem.IteratorResistor_E  = x(1);
    VarSystem.IteratorTransistor  = x(2);
    % F = (VarSystem.goalfreq - 1 ./ (log(2) * (2 * x(1) .* x(2)))).^2; 
    % F = VarSystem.goalfreq;
    F = getReliabilitySystemFromData(DataSystem, VarSystem);  

end