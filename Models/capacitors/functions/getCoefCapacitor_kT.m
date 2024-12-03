function [K_t] = getCoefCapacitor_kT(capacitor_struct, t)
        dT = capacitor_struct.dT;
        A = capacitor_struct.A;
        % Ns = capacitor_struct.Ns;
        % H = capacitor_struct.H;
        B = capacitor_struct.B;
        Nt = capacitor_struct.Nt;
        G = capacitor_struct.G;

        if t >= dT(1, 1) && t <= dT(1, 2)
            % Если температура попадает в первый диапазон
            K_t = A(1)  * exp(B(1) * ((t + 273) / Nt(1))^G(1));
        else
            % Если температура попадает во второй диапазон
            K_t = A(2) * exp(B(2) * ((t + 273) / Nt(2))^G(2));
        end
end