function [VarSystem] = getVarSystemVariable(IteratorCapacitor, IteratorDiod, IteratorResistor_B, IteratorResistor_BE,...
    IteratorResistor_E, IteratorTransistor, t, capacity, resistance_B, resistance_BE, resistance_E, goalfreq)
    VarSystem.IteratorCapacitor   = IteratorCapacitor;
    VarSystem.IteratorDiod        = IteratorDiod;
    VarSystem.IteratorResistor_B  = IteratorResistor_B;
    VarSystem.IteratorResistor_BE = IteratorResistor_BE;
    VarSystem.IteratorResistor_E  = IteratorResistor_E;
    VarSystem.IteratorTransistor  = IteratorTransistor;
    VarSystem.t   = t;

    VarSystem.capacity    = capacity;
    VarSystem.resistance_B= resistance_B;
    VarSystem.resistance_BE= resistance_BE;
    VarSystem.resistance_E= resistance_E;

    VarSystem.goalfreq  = goalfreq;
end
