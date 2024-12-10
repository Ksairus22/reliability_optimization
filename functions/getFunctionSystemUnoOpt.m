function F = getFunctionSystemUnoOpt(x, DataSystem, VarSystem)

    VarSystem.IteratorCapacitor   = x(1);
    VarSystem.IteratorDiod        = x(2);
    VarSystem.IteratorResistor_B  = x(3);
    VarSystem.IteratorResistor_K  = x(4);
    VarSystem.IteratorTransistor  = x(5);
    % F = (VarSystem.goalfreq - 1 ./ (log(2) * (2 * x(1) .* x(2)))).^2; 
    % F = VarSystem.goalfreq;
    % F = getReliabilitySystemFromData(DataSystem, VarSystem);  

    %% Multistart
    % [best_params,fval,tElapsed] = run_multistartContRC(DataSystem, VarSystem, x0, lb, ub, numStarts) 
    
    %% Globalsearch
    % [best_params,fval,tElapsed] = run_globalsearchContRC(DataSystem, VarSystem, x0, lb, ub) 
    
    %% Genetic 
    % [best_params,fval,tElapsed] = run_geneticContRC(DataSystem, VarSystem, x0, lb, ub) 
    
    %% PatternSearch
    % [best_params, fval, tElapsed] = run_patternSearchContRC(DataSystem, VarSystem, x0, lb, ub) 
    
    %% Simulated Annealing
    % [best_params, fval, tElapsed] = run_simulatedAnnealingContRC(DataSystem, VarSystem, x0, lb, ub)
    
    %% Surrogate 
    % [best_params,fval,tElapsed] = run_surrogateContRC(DataSystem, VarSystem, lb, ub)

    F = fval;
end
