function [best_params,fval,tElapsed] = run_geneticMixed(DataSystem, VarSystem, x0, lb, ub, numVar, numStarts) 
% Оптимизация lambda
sse_func  = @(x) getFunctionSystemUnoMixed(x, DataSystem, VarSystem);

    opts = optimoptions(@ga, ...
                        'PopulationSize', 20, ...
                        'MaxGenerations', numStarts, ...
                        'EliteCount', 10, ...
                        'FunctionTolerance', 1e-8, ...
                        'PlotFcn', @gaplotbestfun);
    opts.InitialPopulationMatrix = x0;

tStart = tic;

[best_params, fval, exitflag] = ga(sse_func, numVar, [], [], [], [], ...
    lb, ub, [], 1, opts);

best_params=best_params+1;

tElapsed = toc(tStart); 

end