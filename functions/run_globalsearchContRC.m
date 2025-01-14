function [best_params,fval,tElapsed] = run_globalsearchContRC(DataSystem, VarSystem, x0, lb, ub, numStarts) 
% Оптимизация lambda
sse_func = @(x) getFunctionSystemUnoCont(x, DataSystem, VarSystem);


% Настройка объекта MultiStart для оптимизации
gs = GlobalSearch;
gs.PlotFcn=@gsplotbestf;
% gs.MaxTime=15;
gs.NumStageOnePoints = 1;
gs.NumTrialPoints = numStarts;
opts = optimoptions(@fmincon);
opts.MaxIterations=numStarts;

% Создание оптимизационной проблемы
problem = createOptimProblem('fmincon', ...
    'x0', x0, ... % Начальные значения A и lambda
    'objective', sse_func, ...    % Целевая функция
    'lb', lb, ... % Нижние границы для A и lambda
    'ub', ub, 'options',opts); % Верхние границы для A и lambda

tStart = tic;

[best_params,fval] = run(gs, problem);
tElapsed = toc(tStart); 

end