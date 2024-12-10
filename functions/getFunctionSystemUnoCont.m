function F = getFunctionSystemUnoCont(x, DataSystem, VarSystem)

    VarSystem.capacity = x(1);
    VarSystem.resistance_k = x(2);

    % F = (VarSystem.goalfreq - 1 ./ (log(2) * (2 * x(1) .* x(2)))).^2;
    F = getReliabilitySystemFromData(DataSystem, VarSystem);  

end
