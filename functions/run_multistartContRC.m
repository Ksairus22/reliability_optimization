function [best_params,fval,tElapsed] = run_multistartContRC(DataSystem, VarSystem, x0, lb, ub, numStarts) 
% Оптимизация lambda
sse_func = @(x) getFunctionSystemUnoCont(x, DataSystem, VarSystem);

% Настройка объекта MultiStart для оптимизации
ms = MultiStart;
ms.PlotFcn=@gsplotbestf;
opts = optimoptions(@fmincon);
opts.MaxIterations=numStarts;
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