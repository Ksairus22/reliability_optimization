function [best_params,fval,tElapsed] = run_multistartContRC_freq(goalfreq, x0, lb, ub, numStarts) 

error("Не используется, либо исправить getFunctionSystemUnoCont");
% Оптимизация lambda
sse_func = @(x) abs(goalfreq-1./(log(2)*(2*x(1).*x(2))));


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