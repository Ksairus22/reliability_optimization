function [best_params, fval, tElapsed] = run_geneticContRC_freq(goalfreq, x0, lb, ub) 
    % Оптимизация lambda
    sse_func = @(x) abs(goalfreq- 1 ./ (log(2) * (2 * x(1) .* x(2))));

    % Настройка опций для генетического алгоритма
    options = optimoptions('ga', 'Display', 'off',...
                           'PlotFcn', @gaplotbestfun);
                        

    % disp("Start optimization at " + datestr(datetime()));
    tStart = tic;

    % Запуск генетического алгоритма
    [best_params, fval] = ga(sse_func, length(x0), [], [], [], [], lb, ub, [], options);
    
    % disp("Finish optimization at " + datestr(datetime())); 
    tElapsed = toc(tStart); 
    % disp("Elapsed time: " + num2str(tElapsed) + " sec"); 
end
