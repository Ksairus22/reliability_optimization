function [best_params,fval,tElapsed] = run_fgoalattainContRC_multi(DataSystem,goal,weight, VarSystem, x0, lb, ub, numStarts)

fun = @(x) getFunctionSystemMultiCont(x, DataSystem, VarSystem);
nlcon = @nonlcon;  

% Опции для fgoalattain с функциями отрисовки
options = optimoptions('fgoalattain','Display','iter', ...
                       'PlotFcn', {@optimplotfval, @optimplotfunccount, @optimplotx});
options.MaxIterations=numStarts;
tStart = tic;
% Использование fgoalattain
[best_params, fval] = fgoalattain(fun, x0, goal,weight,[], [], [], [], lb, ub, nlcon, options);

tElapsed = toc(tStart); 

end


function [Cineq,Ceq] = nonlcon(x)  
    Cineq = [];  
    Ceq = [];  
end  
