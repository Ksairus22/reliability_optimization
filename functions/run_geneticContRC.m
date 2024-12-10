function [best_params,fval,tElapsed] = run_geneticContRC(DataSystem, VarSystem, x0, lb, ub) 
% Оптимизация lambda
sse_func = @(x) getFunctionSystemUnoCont(x, DataSystem, VarSystem);

opts = optimoptions(@ga, ... 
                    'PopulationSize', 20, ... 
                    'MaxGenerations', 20, ... % Увеличение для лучшего поиска
                    'EliteCount', 10, ... 
                    'FunctionTolerance', 1e-8, ... 
                    'CrossoverFraction', 0.1, ... % Увеличиваем кроссовер
                    'MutationFcn', @mutationadaptfeasible, ... % Используем адаптивную мутацию
                    'PlotFcn', @gaplotbestf, ...
                    'SelectionFcn', @selectiontournament, ...
                    'UseParallel', true); % Если возможно, используйте параллельные вычисления
opts.InitialPopulationMatrix = x0;

% disp("Start optimization at " + datestr(datetime()));
tStart = tic;

[best_params, fval, exitflag] = ga(sse_func, 2, [], [], [], [], ...
    lb, ub, [], [], opts);

tElapsed = toc(tStart); 

end