function [best_params,fval,tElapsed] = run_gamultiobjMixed_multi(DataSystem,VarSystem, lb, ub)


fun = @(x) getFunctionSystemMultiMixedFull(x, DataSystem, VarSystem);

% Настройки для gamultiobj
options = optimoptions('gamultiobj', ...
    'PlotFcn', {@gaplotpareto, @gaplotbestf, @gaplotrange, @gaplotspread});
tStart = tic;
numVars = 7;
[best_params, fval] = gamultiobj(fun,numVars,[],[],[],[],lb,ub,[],1:3,options);

tElapsed = toc(tStart); 

end
