function F = getFunctionSystemUnoCont(x, DataSystem, VarSystem)

    VarSystem.resistance_BE = x(1);
    VarSystem.resistance_B = x(2);

    % F = (VarSystem.goalfreq - 1 ./ (log(2) * (2 * x(1) .* x(2)))).^2;
    F = getReliabilitySystemFromData(DataSystem, VarSystem);  

end
