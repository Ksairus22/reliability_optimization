function [CoefStruct] = getCoefTransistor(ParamStruct, TransistorStruct)
    T_tr_max= ParamStruct.T_tr_max;
    T_low   = ParamStruct.T_low;
    Pnom    = ParamStruct.P_max;
    Unom    = ParamStruct.U_max_ke_1;
    P       = TransistorStruct.P;
    U       = TransistorStruct.U;
    t       = TransistorStruct.t;

    CoefStruct.kPr = getCoefTransistor_kPr(1);         
    CoefStruct.kR  = getCoefTransistor_kR(T_tr_max, T_low, P, Pnom, t);
    CoefStruct.kF  = getCoefTransistor_kF(1);
    CoefStruct.kS1 = getCoefTransistor_kS1(U, Unom);
    CoefStruct.kE  = getCoefTransistor_kE(1);
    CoefStruct.Lambda_b = ParamStruct.Lambda_b;

end
