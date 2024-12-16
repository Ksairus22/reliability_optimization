function [lambda] = getReliabilityCapacitorFromData(data, rownum,capacity, U, t)

    
    capacitor_struct = getTableCapacitor(data, rownum);
    U_ratio = U/capacitor_struct.unom; 
    % get coef ->
    [K_c, K_r] = getCoefCapacitor(data, rownum, capacity, U_ratio, t, capacitor_struct);
    % 
    % get lambda ->
    lambda = getReliabilityCapacitor(capacitor_struct, K_c, K_r);
end
