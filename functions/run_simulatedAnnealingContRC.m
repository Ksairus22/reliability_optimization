function [best_params, fval, tElapsed] = run_simulatedAnnealingContRC(DataSystem, IteratorCapacitor, IteratorDiod, IteratorResistor_B, IteratorResistor_K, IteratorTransistor,...
                              t, U_ratio, iRelative, power_b, resistance_b, P_ratio_b, power_k, P_ratio_k,... 
                              pRelative, s1, ... 
                              x0, lb, ub)
    % Оптимизация lambda с использованием Simulated Annealing
    sse_func = @(x) getReliabilitySystemFromData(DataSystem,...
        IteratorCapacitor, IteratorDiod, IteratorResistor_B, IteratorResistor_K, IteratorTransistor,...
        t, x(1), U_ratio, iRelative, power_b, resistance_b, P_ratio_b,...
        power_k, x(2), P_ratio_k, pRelative, s1);

    opts = optimoptions(@simulannealbnd, ...
                        'Display', 'iter', ...  % Отображение прогресса
                        'MaxIter', 1000, ... % Максимальное количество итераций
                        'FunctionTolerance', 1e-8, ... % Допуск по функции
                        'TemperatureFcn', @temperatureexp,... % Функция температуры
                        'PlotFcn', @saplotbestf); 


    % disp("Start optimization at " + datestr(datetime()));
    tStart = tic;

    [best_params, fval] = simulannealbnd(sse_func, x0, lb, ub, opts);
    % disp("Finish optimization at " + datestr(datetime())); 
    tElapsed = toc(tStart); 
    % disp("Elapsed time: " + num2str(tElapsed) + " sec"); 

end
