function [kS1] = getCoefTransistor_kS1(U, Unom)
    s1 = U/Unom;
    s1Vec = [0.0, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
    kS1Vec  = [0.5, 0.7, 0.8, 1.0, 1.5, 2.0, 3.0];
    if(s1 < s1Vec(2))
        kS1 = kS1Vec(1);
    else
        for i=2:length(s1Vec)                
            if((s1 > s1Vec(i-1)) && (s1 <= s1Vec(i)))
                kS1 = kS1Vec(i);
                break;
            end
        end
    end
    
end