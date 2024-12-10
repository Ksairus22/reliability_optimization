function [lambda] = getReliabilitySystemFromData(DataSystem, VarSystem)

    % Capacitor
    lambda_Capacitor = getReliabilityCapacitorFromData(...
        DataSystem.Capacitor, VarSystem.IteratorCapacitor,VarSystem.capacity, ...
        VarSystem.U_ratio, VarSystem.t);

    % Diod
    lambda_Diod = getReliabilityDiodFromData(...
        DataSystem.Diod, VarSystem.IteratorDiod, VarSystem.iRelative, VarSystem.t);

    % Resistor_B
    lambda_Resistor_B = getReliabilityResistorFromData(...
        DataSystem.Resistor, VarSystem.IteratorResistor_B, VarSystem.power_b, ...
        VarSystem.resistance_b, VarSystem.P_ratio_b, VarSystem.t);

    % Resistor_K
    lambda_Resistor_K = getReliabilityResistorFromData(...
        DataSystem.Resistor, VarSystem.IteratorResistor_K, VarSystem.power_k, ...
        VarSystem.resistance_k, VarSystem.P_ratio_k, VarSystem.t);

    % Transistor
    lambda_Transistor = getReliabilityTransistorFromData(...
        DataSystem.Transistor, VarSystem.IteratorTransistor, ...
        VarSystem.pRelative, VarSystem.t, VarSystem.s1);
    
    % System
    lambda = lambda_Capacitor*2 + lambda_Diod*2 + lambda_Resistor_B*2 + lambda_Resistor_K*2 + lambda_Transistor*2;

%% Var and Param
    % % Capacitor
    % capacity  % In picoPharad
    % U_ratio   % 0 to 1
    % t         % In degC
    
    % % Diod
    % iRelative % 0 to 1
    
    % % Resistor B 
    % power_b   % Whatt
    % resistance_b % In Ohm
    % P_ratio_b % 0 to 1
    
    % % Resistor K
    % power_k   % Whatt
    % resistance_k  % In Ohm
    % P_ratio_k % 0 to 1
    
    % % Transistor
    % pRelative % 0 to 1
    % s1        % 0 to 1

end