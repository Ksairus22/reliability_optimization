function K_p = getCoefResistor_kp(t, P_ratio, Resistor_struct)
    A = Resistor_struct.A;
    B = Resistor_struct.B;
    Nt = Resistor_struct.Nt;
    G = Resistor_struct.G;
    Ns = Resistor_struct.Ns;
    J = Resistor_struct.J;
    H = Resistor_struct.H;

    K_p = A*exp(B*((t+273)/Nt).^G).*exp((P_ratio/Ns*((t+273)/273).^J).^H);
end