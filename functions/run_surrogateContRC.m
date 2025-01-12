function [best_params,fval,tElapsed] = run_surrogateContRC(DataSystem, VarSystem, lb, ub, numStarts) 
% Оптимизация lambda
sse_func = @(x) getFunctionSystemUnoCont(x, DataSystem, VarSystem);

% Опции для surrogateopt
opts = optimoptions(@surrogateopt, ... 
                    'PlotFcn', @surrogateoptplot,...
                    'MaxFunctionEvaluations', numStarts... 
                    ); 

% Установка начальной точки
% initialPoint = x0;

% disp("Start optimization at " + datestr(datetime()));
tStart = tic;

[best_params, fval] = surrogateopt(sse_func, lb, ub, opts); 
% disp("Finish optimization at " + datestr(datetime())); 
tElapsed = toc(tStart); 
% disp("Elapsed time: " + num2str(tElapsed) + " sec"); 

end