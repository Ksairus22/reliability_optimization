function [best_params,fval,tElapsed] = run_globalsearchContRC(DataSystem, VarSystem, x0, lb, ub) 
% Оптимизация lambda
sse_func = @(x) getFunctionSystemUnoCont(x, DataSystem, VarSystem);


% Настройка объекта MultiStart для оптимизации
gs = GlobalSearch;

% Создание оптимизационной проблемы
problem = createOptimProblem('fmincon', ...
    'x0', x0, ... % Начальные значения A и lambda
    'objective', sse_func, ...    % Целевая функция
    'lb', lb, ... % Нижние границы для A и lambda
    'ub', ub); % Верхние границы для A и lambda

tStart = tic;

[best_params,fval] = run(gs, problem);
tElapsed = toc(tStart); 

end