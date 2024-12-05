function [best_params,fval,tElapsed] = run_multistartContRC(DataSystem, IteratorCapacitor, IteratorDiod, IteratorResistor_B, IteratorResistor_K, IteratorTransistor,... 
                              t, U_ratio, iRelative, power_b, resistance_b, P_ratio_b, power_k, P_ratio_k,... 
                              pRelative, s1, ... 
                              x0, lb, ub, numStarts) 
% Оптимизация lambda
sse_func = @(x) getReliabilitySystemFromData(DataSystem,...
    IteratorCapacitor, IteratorDiod, IteratorResistor_B, IteratorResistor_K, IteratorTransistor,...
    t, x(1), U_ratio, iRelative, power_b, resistance_b, P_ratio_b,...
    power_k, x(2), P_ratio_k, pRelative, s1);


% Настройка объекта MultiStart для оптимизации
ms = MultiStart;

% Создание оптимизационной проблемы
problem = createOptimProblem('fmincon', ...
    'x0', x0, ... % Начальные значения A и lambda
    'objective', sse_func, ...    % Целевая функция
    'lb', lb, ... % Нижние границы для A и lambda
    'ub', ub); % Верхние границы для A и lambda

% disp("Start optimization at " + datestr(datetime()));
tStart = tic;

% Запуск MultiStart
% numStarts = 100;
[best_params,fval] = run(ms, problem, numStarts);
% disp("Finish optimization at " + datestr(datetime())); 
tElapsed = toc(tStart); 
% disp("Elapsed time: " + num2str(tElapsed) + " sec"); 

end