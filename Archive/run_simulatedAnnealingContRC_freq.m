function [best_params, fval, tElapsed] = run_simulatedAnnealingContRC_freq(goalfreq, x0, lb, ub) 
error("Не используется, либо исправить getFunctionSystemUnoCont");
    % Оптимизация lambda
    sse_func = @(x) abs(goalfreq - 1 ./ (log(2) * (2 * x(1) .* x(2))));

    % Настройка опций для метода имитации отжига
    options = optimoptions('simulannealbnd', 'Display', 'off');

    % disp("Start optimization at " + datestr(datetime()));
    tStart = tic;

    % Запуск метода имитации отжига
    [best_params, fval] = simulannealbnd(sse_func, x0, lb, ub, options);
    
    % disp("Finish optimization at " + datestr(datetime())); 
    tElapsed = toc(tStart); 
    % disp("Elapsed time: " + num2str(tElapsed) + " sec"); 
end
