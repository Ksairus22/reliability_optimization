function [best_params,fval,tElapsed] = run_gamultiobjDiscr_multi(DataSystem,VarSystem, lb, ub)


fun = @(x) getFunctionSystemMultiDiscr(x, DataSystem, VarSystem);

% Настройки для gamultiobj
options = optimoptions('gamultiobj', ...
    'PlotFcn', {@gaplotpareto, @gaplotbestf, @gaplotrange, @gaplotspread});
tStart = tic;

[best_params, fval] = gamultiobj(fun,5,[],[],[],[],lb,ub,[],1:5,options);

tElapsed = toc(tStart); 

end
