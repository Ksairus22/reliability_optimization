function [best_params,fval,tElapsed] = run_fminimaxContRC_multi(DataSystem, VarSystem, x0, lb, ub, numStarts)

fun = @(x) getFunctionSystemMultiCont(x, DataSystem, VarSystem);
nlcon = @nonlcon;  

% Опции для fminimax с функциями отрисовки
options = optimoptions('fminimax','Display','iter', ...
                       'PlotFcn', {@optimplotfval, @optimplotfunccount, @optimplotx});

% options.MaxIterations=numStarts;
tStart = tic;
% Использование fminimax
[best_params, fval, exit_flag] = fminimax(fun, x0, [], [], [], [], lb, ub, nlcon, options);
% exit_flag
tElapsed = toc(tStart); 

end


function [Cineq,Ceq] = nonlcon(x)  
    Cineq = [];  
    Ceq = [];  
end  
