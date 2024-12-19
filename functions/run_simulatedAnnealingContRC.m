function [best_params, fval, tElapsed] = run_simulatedAnnealingContRC(DataSystem, VarSystem, x0, lb, ub, numStarts)
    % Оптимизация lambda с использованием Simulated Annealing
    sse_func = @(x) getFunctionSystemUnoCont(x, DataSystem, VarSystem);

    opts = optimoptions(@simulannealbnd, ...
                        'Display', 'iter', ...  % Отображение прогресса
                        'MaxIter', numStarts, ... % Максимальное количество итераций
                        'FunctionTolerance', 1e-8, ... % Допуск по функции
                        'TemperatureFcn', @temperatureexp,... % Функция температуры
                        'PlotFcn', @saplotbestf); 

    tStart = tic;

    [best_params, fval] = simulannealbnd(sse_func, x0, lb, ub, opts);
    
    tElapsed = toc(tStart); 

end
