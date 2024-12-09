function [best_params,fval,tElapsed] = run_gamultiobjDiscr_multi(DataSystem,goalfreq,... 
                              t, capacity, U_ratio, iRelative, power_b, resistance_b, P_ratio_b, power_k, resistance_k, P_ratio_k,... 
                              pRelative, s1, lb, ub)


fun = @(x) objval(DataSystem, x, goalfreq, t, capacity, ...
    U_ratio, iRelative, power_b, resistance_b, P_ratio_b, power_k, ...
    resistance_k, P_ratio_k, pRelative, s1);

% Настройки для gamultiobj
options = optimoptions('gamultiobj', ...
    'PlotFcn', {@gaplotpareto, @gaplotbestf, @gaplotrange, @gaplotspread});
tStart = tic;

[best_params, fval] = gamultiobj(fun,5,[],[],[],[],lb,ub,[],1:5,options);

tElapsed = toc(tStart); 

end

function F = objval(DataSystem, x, goalfreq, t, capacity, ...
    U_ratio, iRelative, power_b, resistance_b, P_ratio_b, power_k, ...
    resistance_k, P_ratio_k, pRelative, s1)

    % f1 = (goalfreq - 1 ./ (log(2) * (2 * x(1) .* x(2)))).^2; 
    f1 = goalfreq;
    f2 = getReliabilitySystemFromData(DataSystem, x(1), x(2), x(3), x(4), x(5), ...
        t, capacity, U_ratio, iRelative, power_b, ...
        resistance_b, P_ratio_b, power_k, resistance_k, P_ratio_k, pRelative, s1);  

    F = [f1, f2];  
end  