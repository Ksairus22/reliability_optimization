function lambda = getReliabilityResistorFromData(data, rownum, power, resistance, P_ratio, t)
    Resistor_struct = getTableResistor(data, rownum);
    % get coef ->
    [K_p, K_R, K_m, K_stab] = getCoefResistor(power, resistance, P_ratio, t, Resistor_struct);
    % get lambda ->
    lambda = getReliabilityResistor(Resistor_struct, K_p, K_R, K_m, K_stab);
end