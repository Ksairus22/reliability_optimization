function [best_params, fval, tElapsed] = run_simulatedAnnealingContRC_test(DataSystem, VarSystem, x0, lb, ub, numStarts)
%% Оптимизация lambda
% sse_func = @(x) getFunctionSystemUnoCont(x, DataSystem, VarSystem);

%% Настройка объекта для оптимизации
% opts = optimoptions(...);

tStart = tic;
%% Запуск
% [best_params,fval] = simulannealbnd(...);
tElapsed = toc(tStart); 

end
