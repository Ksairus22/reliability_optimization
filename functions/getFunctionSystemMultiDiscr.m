function F = getFunctionSystemMultiDiscr(x, DataSystem, VarSystem)

    VarSystem.IteratorCapacitor   = x(1);
    VarSystem.IteratorDiod        = x(2);
    VarSystem.IteratorResistor_B  = x(3);
    VarSystem.IteratorResistor_K  = x(4);
    VarSystem.IteratorTransistor  = x(5);
    % f1 = (VarSystem.goalfreq - 1 ./ (log(2) * (2 * x(1) .* x(2)))).^2; 
    f1 = VarSystem.goalfreq;
    f2 = getReliabilitySystemFromData(DataSystem, VarSystem);  

    F = [f1, f2]; 

end