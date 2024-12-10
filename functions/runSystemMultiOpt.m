function [best_params,fval,tElapsed] = runSystemMultiOpt(DataSystem,VarSystem, x0, lb, ub)

[best_params,fval,tElapsed] = run_gamultiobjDiscr_multi(DataSystem,VarSystem, lb, ub);

fun = @(x) objfun(x, DataSystem, VarSystem);
% getFunctionSystemMultiDiscr
% Настройки для gamultiobj
options = optimoptions('gamultiobj', ...
    'PlotFcn', {@gaplotpareto, @gaplotbestf, @gaplotrange, @gaplotspread});
tStart = tic;

[best_params, fval] = gamultiobj(fun,5,[],[],[],[],lb,ub,[],1:5,options);

tElapsed = toc(tStart); 

end

function y = objfun(x, DataSystem, VarSystem)

    VarSystem.IteratorCapacitor   = x(1);
    VarSystem.IteratorDiod        = x(2);
    VarSystem.IteratorResistor_B  = x(3);
    VarSystem.IteratorResistor_K  = x(4);
    VarSystem.IteratorTransistor  = x(5);
    % f1 = (VarSystem.goalfreq - 1 ./ (log(2) * (2 * x(1) .* x(2)))).^2; 
    f1 = VarSystem.goalfreq;
    f2 = getReliabilitySystemFromData(DataSystem, VarSystem);  

    F = [f1, f2]; 


%% fminimax
[best_params,fval,tElapsed] = run_fminimaxContRC_multi(DataSystem, VarSystem, x0, lb, ub) 

%% fgoalattain
[best_params,fval,tElapsed] = run_fgoalattainContRC_multi(DataSystem,goal,weight, VarSystem, x0, lb, ub) 
%% gamultiobj
[best_params,fval,tElapsed] = run_gamultiobjContRC_multi(DataSystem, VarSystem, lb, ub) 

%% paretosearch
[best_params,fval,tElapsed] = run_paretosearchContRC_multi(DataSystem, VarSystem, lb, ub)

end

