function [best_params,fval,tElapsed] = run_surrogateContRC_test(DataSystem, VarSystem, lb, ub, numStarts) 
%% Оптимизация lambda
% sse_func = @(x) getFunctionSystemUnoCont(x, DataSystem, VarSystem);

%% Настройка объекта для оптимизации
% opts = optimoptions(...);

tStart = tic;
%% Запуск
% [best_params,fval] = surrogateopt(...);
tElapsed = toc(tStart); 

end