function [best_params, fval, tElapsed] = runSurrogateFuncUnoOpt(func,DataSystem,VarSystem, lb, ub)  

% Опции для surrogateopt
opts = optimoptions(@surrogateopt, ... 
                    'MaxFunctionEvaluations', 500,... 
                    'PlotFcn', @surrogateoptplot); 

% Установка начальной точки
% opts.InitialPopulationMatrix = x0;

tStart = tic; 

[best_params, fval] = surrogateopt(func, lb, ub, 1:5, opts); 
best_params = best_params + 1;  
tElapsed = toc(tStart);  

end
