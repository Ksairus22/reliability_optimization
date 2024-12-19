function [best_params,fval,tElapsed] = run_globalsearchContRC_test(DataSystem, VarSystem, x0, lb, ub, numStarts) 
%% Оптимизация lambda
% sse_func = @(x) getFunctionSystemUnoCont(x, DataSystem, VarSystem);

%% Настройка объекта для оптимизации
% gs = GlobalSearch;

% Создание оптимизационной проблемы
% problem = createOptimProblem(...);

tStart = tic;
%% Запуск
% [best_params,fval] = run(...);
tElapsed = toc(tStart); 

end