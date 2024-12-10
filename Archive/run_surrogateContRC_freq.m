function [best_params, fval, tElapsed] = run_surrogateContRC_freq(goalfreq, lb, ub) 
error("Не используется, либо исправить getFunctionSystemUnoCont");
% Оптимизация lambda
    sse_func = @(x) abs(goalfreq - 1 ./ (log(2) * (2 * x(1) .* x(2))));

    % Опции для surrogateopt
    opts = optimoptions(@surrogateopt, ... 
                    'MaxFunctionEvaluations', 500,... 
                    'PlotFcn', @surrogateoptplot); 

    % disp("Start optimization at " + datestr(datetime()));
    tStart = tic;

    % Запуск метода суррогатной оптимизации
    [best_params, fval] = surrogateopt(sse_func, lb, ub, opts);
    
    % disp("Finish optimization at " + datestr(datetime())); 
    tElapsed = toc(tStart); 
    % disp("Elapsed time: " + num2str(tElapsed) + " sec"); 
end
