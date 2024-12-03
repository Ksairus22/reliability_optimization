function [lambda] = getReliabilityCapacitorFromData(data, rownum,capacity, U_ratio, t)
    capacitor_struct = getTableCapacitor(data, rownum);
    % get coef ->
    [K_c, K_r] = getCoefCapacitor(data, rownum, capacity, U_ratio, t, capacitor_struct);
    % 
    % get lambda ->
    lambda = getReliabilityCapacitor(capacitor_struct, K_c, K_r);
end
