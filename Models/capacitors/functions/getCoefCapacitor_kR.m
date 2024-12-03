function [K_r] = getCoefCapacitor_kR(capacitor_struct, t, U_ratio)
        dT = capacitor_struct.dT;
        A = capacitor_struct.A;
        Ns = capacitor_struct.Ns;
        H = capacitor_struct.H;
        B = capacitor_struct.B;
        Nt = capacitor_struct.Nt;
        G = capacitor_struct.G;

        if t >= dT(1, 1) && t <= dT(1, 2)+5
            % Если температура попадает в первый диапазон
            K_r = A(1) * ((U_ratio / Ns(1))^H(1) + 1) * exp(B(1) * ((t + 273) / Nt(1))^G(1));
        elseif t>dT(1, 2)+5
            % Если температура попадает во второй диапазон
            K_r = A(2) * ((U_ratio / Ns(2))^H(2) + 1) * exp(B(2) * ((t + 273) / Nt(2))^G(2));
        else
            K_r = NaN;
        end
end