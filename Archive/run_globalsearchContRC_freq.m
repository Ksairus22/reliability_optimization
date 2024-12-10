function [best_params, fval, tElapsed] = run_globalsearchContRC_freq(goalfreq, x0, lb, ub) 
error("Не используется, либо исправить getFunctionSystemUnoCont");
    % Оптимизация lambda
    sse_func = @(x) (goalfreq - 1 ./ (log(2) * (2 * x(1) .* x(2)))).^2;

    % Создание оптимизационной проблемы
    problem = createOptimProblem('fmincon', ...
        'x0', x0, ... % Начальные значения A и lambda
        'objective', sse_func, ... % Целевая функция
        'lb', lb, ... % Нижние границы для A и lambda
        'ub', ub); % Верхние границы для A и lambda

    % Создание объекта GlobalSearch
    gs = GlobalSearch;

    % disp("Start optimization at " + datestr(datetime()));
    tStart = tic;

    % Запуск GlobalSearch
    [best_params, fval] = run(gs, problem);
    % disp("Finish optimization at " + datestr(datetime())); 
    tElapsed = toc(tStart); 
    % disp("Elapsed time: " + num2str(tElapsed) + " sec"); 
end
