function [best_params,fval,tElapsed] = run_gamultiobjDiscr_multi(DataSystem,VarSystem, lb, ub)


fun = @(x) getFunctionSystemMultiDiscr(x, DataSystem, VarSystem);

% Настройки для gamultiobj
options = optimoptions('gamultiobj', ...
    'PlotFcn', {@gaplotpareto, @gaplotbestf, @gaplotrange, @gaplotspread});
tStart = tic;
numVars = 2;
[best_params, fval] = gamultiobj(fun,numVars,[],[],[],[],lb,ub,[],1:numVars,options);

tElapsed = toc(tStart); 

end
