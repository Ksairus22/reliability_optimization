function [best_params, fval, tElapsed] = run_patternSearchContRC(DataSystem, VarSystem, x0, lb, ub) 
    % Оптимизация lambda с использованием patternsearch
    sse_func = @(x) getFunctionSystemUnoCont(x, DataSystem, VarSystem);

    opts = optimoptions(@patternsearch, ...
                        'Display', 'iter', ...  % Отображение прогресса
                        'MaxIterations', 100, ... % Максимальное количество итераций
                        'MaxFunctionEvaluations', 1000, ... % Ограничение на количество оценок функции
                        'UseParallel', true); % Использование параллельных вычислений

    tStart = tic;

    [best_params, fval] = patternsearch(sse_func, x0, [], [], [], [], lb, ub, [], opts);

    tElapsed = toc(tStart); 

end
