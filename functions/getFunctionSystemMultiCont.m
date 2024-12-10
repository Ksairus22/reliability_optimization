function F = getFunctionSystemMultiCont(x, DataSystem, VarSystem)

    VarSystem.capacity = x(1);
    VarSystem.resistance_k = x(2);

    f1 = (VarSystem.goalfreq - 1 ./ (log(2) * (2 * x(1) .* x(2)))).^2;
    f2 = getReliabilitySystemFromData(DataSystem, VarSystem);  

    F = [f1, f2];  

end
