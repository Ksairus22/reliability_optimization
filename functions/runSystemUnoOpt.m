function [best_params,fval,tElapsed] = runSystemUnoOpt(DataSystem,VarSystem, x0, lb, ub)

func = @(x) getFunctionSystemUnoOpt(x, DataSystem, VarSystem);

%% Genetic 
[best_params,fval,tElapsed] = runGeneticFuncUnoOpt(func,DataSystem, VarSystem, x0, lb, ub) 

%% Surrogate 
[best_params, fval, tElapsed] = runSurrogateFuncUnoOpt(func,DataSystem,VarSystem, lb, ub) 

end



