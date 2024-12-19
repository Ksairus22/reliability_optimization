function [best_params,fval,tElapsed] = run_geneticContRC_test(DataSystem, VarSystem, x0, lb, ub, numStarts) 
%% Оптимизация lambda
% sse_func = @(x) getFunctionSystemUnoCont(x, DataSystem, VarSystem);

%% Настройка объекта для оптимизации
% opts = optimoptions(...); % Если возможно, используйте параллельные вычисления

% Создание оптимизационной проблемы
% problem = createOptimProblem(...);

tStart = tic;
%% Запуск
% [best_params, fval] = ga(...);
tElapsed = toc(tStart); 

end