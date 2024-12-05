function [best_params,fval,tElapsed] = run_surrogateContRC(DataSystem, IteratorCapacitor, IteratorDiod, IteratorResistor_B, IteratorResistor_K, IteratorTransistor,... 
                              t, U_ratio, iRelative, power_b, resistance_b, P_ratio_b, power_k, P_ratio_k,... 
                              pRelative, s1, ... 
                              x0, lb, ub) 
% Оптимизация lambda
sse_func = @(x) getReliabilitySystemFromData(DataSystem,...
    IteratorCapacitor, IteratorDiod, IteratorResistor_B, IteratorResistor_K, IteratorTransistor,...
    t, x(1), U_ratio, iRelative, power_b, resistance_b, P_ratio_b,...
    power_k, x(2), P_ratio_k, pRelative, s1);

% Опции для surrogateopt
opts = optimoptions(@surrogateopt, ... 
                    'MaxFunctionEvaluations', 500,... 
                    'PlotFcn', @surrogateoptplot); 

% Установка начальной точки
% initialPoint = x0;

% disp("Start optimization at " + datestr(datetime()));
tStart = tic;

[best_params, fval] = surrogateopt(sse_func, lb, ub, opts); 
% disp("Finish optimization at " + datestr(datetime())); 
tElapsed = toc(tStart); 
% disp("Elapsed time: " + num2str(tElapsed) + " sec"); 

end