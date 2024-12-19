function [best_params, fval, tElapsed] = run_surrogateoptMixed(DataSystem,VarSystem, lb, ub, numVar,numStarts)  
% Оптимизация lambda 
sse_func = @(x) getFunctionSystemUnoMixed(x, DataSystem, VarSystem);

% Опции для surrogateopt
opts = optimoptions(@surrogateopt, ... 
                    'MaxFunctionEvaluations', numStarts,... 
                    'PlotFcn', @surrogateoptplot); 

% Установка начальной точки
% opts.InitialPopulationMatrix = x0;

tStart = tic; 

[best_params, fval] = surrogateopt(sse_func, lb, ub, 1, opts); 
best_params = best_params + 1;  
tElapsed = toc(tStart);  

end
