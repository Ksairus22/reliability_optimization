function [best_params, fval, tElapsed] = run_surrogateoptDiscr(DataSystem,...
                                  t, capacity, U_ratio, iRelative, power_b, resistance_b, P_ratio_b,... 
                                  power_k, resistance_k, P_ratio_k, pRelative, s1,... 
                                  x0, lb, ub)  
% Оптимизация lambda 
sse_func = @(x) getReliabilitySystemFromData(DataSystem,... 
    x(1)+1, x(2)+1, x(3)+1, x(4)+1, x(5)+1,... 
    t, capacity, U_ratio, iRelative, power_b, resistance_b, P_ratio_b,... 
    power_k, resistance_k, P_ratio_k, pRelative, s1); 

% Опции для surrogateopt
opts = optimoptions(@surrogateopt, ... 
                    'MaxFunctionEvaluations', 500,... 
                    'PlotFcn', @surrogateoptplot); 

% Установка начальной точки
% opts.InitialPopulationMatrix = x0;

% disp("Start optimization at " + datestr(datetime())); 
tStart = tic; 

[best_params, fval] = surrogateopt(sse_func, lb, ub, 1:5, opts); 
best_params = best_params + 1; 
% disp("Finish optimization at " + datestr(datetime()));  
tElapsed = toc(tStart);  
% disp("Elapsed time: " + num2str(tElapsed) + " sec");  

end
