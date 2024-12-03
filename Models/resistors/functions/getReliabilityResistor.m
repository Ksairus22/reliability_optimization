function lambda = getReliabilityResistor(Resistor_struct, K_p, K_R, K_m, K_stab)
    lb = Resistor_struct.lb;
    K_pr = Resistor_struct.kpr;
    K_e = Resistor_struct.ke;

switch Resistor_struct.Group
    case 1
        lambda = 1e-6*lb*K_pr*K_p*K_e*K_R*K_m*K_stab;
    case 2
        lambda = 1e-6*lb*K_pr*K_p*K_e*K_R;
    case 3
        lambda = 1e-6*lb*K_pr*K_p*K_e*K_R;
    otherwise
        lambda = NaN;
end
end