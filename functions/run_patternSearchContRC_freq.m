function [best_params, fval, tElapsed] = run_patternSearchContRC_freq(goalfreq, x0, lb, ub) 
    % Оптимизация lambda
    sse_func = @(x) abs(goalfreq - 1 ./ (log(2) * (2 * x(1) .* x(2))));
    
    % Настройка опций для метода поиска по паттернам
    options = optimoptions('patternsearch', 'Display', 'off');

    % disp("Start optimization at " + datestr(datetime()));
    tStart = tic;

    % Запуск метода поиска по паттернам
    [best_params, fval] = patternsearch(sse_func, x0, [], [], [], [], lb, ub, options);
    
    % disp("Finish optimization at " + datestr(datetime())); 
    tElapsed = toc(tStart); 
    % disp("Elapsed time: " + num2str(tElapsed) + " sec"); 
end
