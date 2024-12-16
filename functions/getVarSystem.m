function [VarSystem] = getVarSystem()
    VarSystem.IteratorCapacitor   = 1;
    VarSystem.IteratorDiod        = 1;
    VarSystem.IteratorResistor_B  = 1;
    VarSystem.IteratorResistor_BE = 1;
    VarSystem.IteratorResistor_E  = 1;
    VarSystem.IteratorTransistor  = 1;
    VarSystem.t   = 30;

    VarSystem.capacity    = 1000e-12;
    VarSystem.resistance_B= 200;
    VarSystem.resistance_BE= 200;
    VarSystem.resistance_E= 200;

    VarSystem.goalfreq  = 1000;
end