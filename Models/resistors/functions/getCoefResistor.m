function [K_p K_R K_m K_stab] = getCoefResistor(power, resistance, P_ratio, t, Resistor_struct)
    K_p = getCoefResistor_kp(t, P_ratio, Resistor_struct);
    K_R = getCoefResistor_kR(resistance, Resistor_struct);
    K_m = getCoefResistor_kM(power);
    K_stab = 1;
end