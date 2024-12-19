function [best_params,fval,tElapsed] = run_gamultiobjContRC_multi(DataSystem, VarSystem, lb, ub, numStarts)

fun = @(x) getFunctionSystemMultiCont(x, DataSystem, VarSystem);
nlcon = @nonlcon;  

% Настройки для gamultiobj
options = optimoptions('gamultiobj', ...
    'Display', 'iter', ...
    'PlotFcn', {@gaplotpareto, @gaplotbestf, @gaplotrange, @gaplotspread});
options.MaxGenerations=numStarts;
tStart = tic;
[best_params, fval] = gamultiobj(fun, 2, [], [], [], [], lb, ub, nlcon, options); 
tElapsed = toc(tStart); 

end


function [Cineq,Ceq] = nonlcon(x)  
    Cineq = [];  
    Ceq = [];  
end  
