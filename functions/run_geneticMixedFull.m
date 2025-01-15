function [best_params,fval,tElapsed] = run_geneticMixedFull(DataSystem, VarSystem, x0, lb, ub, numVar, numStarts) 
% Оптимизация lambda
sse_func  = @(x) getFunctionSystemUnoMixedFull(x, DataSystem, VarSystem);

    opts = optimoptions(@ga, ...
                        'PlotFcn', @gaplotbestfun);
    opts.InitialPopulationMatrix = x0;
    % opts = [];

tStart = tic;

intcon = 3;

[best_params, fval, exitflag] = ga(sse_func, numVar, [], [], [], [], ...
    lb, ub, [], 1:intcon, opts);
exitflag
best_params=best_params+1;

tElapsed = toc(tStart); 

end