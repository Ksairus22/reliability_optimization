function [best_params, fval, tElapsed] = run_patternSearchContRC(DataSystem, VarSystem, x0, lb, ub, numStarts)
    % Оптимизация lambda с использованием patternsearch
    sse_func = @(x) getFunctionSystemUnoCont(x, DataSystem, VarSystem);

    % opts = optimoptions(@patternsearch, ...
    %                     'Display', 'iter', ...  % Отображение прогресса
    %                     'MaxIterations', numStarts, ... % Максимальное количество итераций
    %                     'PlotFcn', @psplotbestf, ...
    %                     'UseParallel', false); % Использование параллельных вычислений

    opts = optimoptions(@patternsearch, ...
                        'Display', 'iter', ...  % Отображение прогресса
                        'PlotFcn', @psplotbestf, ...
                        'UseParallel', false); % Использование параллельных вычислений

    tStart = tic;

    [best_params, fval] = patternsearch(sse_func, x0, [], [], [], [], lb, ub, [], opts);

    tElapsed = toc(tStart); 

end
