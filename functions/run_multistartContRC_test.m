function [best_params,fval,tElapsed] = run_multistartContRC_test(DataSystem, VarSystem, x0, lb, ub, numStarts) 
% Оптимизация lambda
% sse_func = @(x) getFunctionSystemUnoCont(x, DataSystem, VarSystem);

%% Настройка объекта MultiStart для оптимизации
% ms = MultiStart;

% Создание оптимизационной проблемы
% problem = createOptimProblem(...);

tStart = tic;
%% Запуск MultiStart
% [best_params,fval] = run(...);
tElapsed = toc(tStart); 

end