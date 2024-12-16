function [lambda] = getReliabilitySystemFromData(DataSystem, VarSystem)

    electric_parameters = calculateCircuitParamsStruct(DataSystem,VarSystem);
    % Capacitor
    lambda_Capacitor = getReliabilityCapacitorFromData(...
        DataSystem.Capacitor, VarSystem.IteratorCapacitor,VarSystem.capacity, ...
        electric_parameters.C1.U, VarSystem.t);

    % % Diod
    % lambda_Diod = getReliabilityDiodFromData(...
    %     DataSystem.Diod, VarSystem.IteratorDiod, VarSystem.iRelative, VarSystem.t);

    % Resistor_B
        lambda_Resistor_B = getReliabilityResistorFromData(...
        DataSystem.Resistor, VarSystem.IteratorResistor_B, electric_parameters.Rb.P, ...
        VarSystem.resistance_B, VarSystem.t);

    % Resistor_BE
    lambda_Resistor_BE = getReliabilityResistorFromData(...
        DataSystem.Resistor, VarSystem.IteratorResistor_BE, electric_parameters.Rbe.P , ...
        VarSystem.resistance_BE, VarSystem.t);

    % Resistor_E
    lambda_Resistor_E = getReliabilityResistorFromData(...
        DataSystem.Resistor, VarSystem.IteratorResistor_E, electric_parameters.Re.P, ...
        VarSystem.resistance_E, VarSystem.t);

    % Transistor
    lambda_Transistor = getReliabilityTransistorFromData(...
        DataSystem.Transistor, VarSystem.IteratorTransistor, ...
        electric_parameters.VT);

    % System
    lambda = lambda_Capacitor + lambda_Resistor_B + lambda_Resistor_BE + lambda_Transistor + lambda_Resistor_E;

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
