function [VarSystem] = getVarSystem()
    VarSystem.IteratorCapacitor   = 1;
    VarSystem.IteratorDiod        = 1;
    VarSystem.IteratorResistor_B  = 30;
    VarSystem.IteratorResistor_BE = 30;
    VarSystem.IteratorResistor_E  = 30;
    VarSystem.IteratorTransistor  = 41;
    VarSystem.t   = 30;

    VarSystem.capacity    = 1e-6;
    VarSystem.resistance_B = 10e3;
    VarSystem.resistance_BE = 20e3;
    VarSystem.resistance_E = 10e3;

    VarSystem.goalfreq  = 1000;
end