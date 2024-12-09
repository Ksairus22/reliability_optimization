function [best_params,fval,tElapsed] = run_paretosearchContRC_multi(DataSystem,goalfreq, IteratorCapacitor, IteratorDiod, IteratorResistor_B, IteratorResistor_K, IteratorTransistor,... 
                              t, U_ratio, iRelative, power_b, resistance_b, P_ratio_b, power_k, P_ratio_k,... 
                              pRelative, s1, ... 
                              lb, ub) 

fun = @(x) objval(x,goalfreq, DataSystem, IteratorCapacitor, IteratorDiod, IteratorResistor_B, IteratorResistor_K, IteratorTransistor,... 
                              t, U_ratio, iRelative, power_b, resistance_b, P_ratio_b, power_k, P_ratio_k,... 
                              pRelative, s1);
nlcon = @nonlcon;  

% Настройки для gamultiobj
options = optimoptions('paretosearch','Display','off','PlotFcn',{'psplotparetof' 'psplotparetox' 'psplotspread' 'psplotvolume' 'psplotfuncount' 'psplotdistance'});  

tStart = tic;
[best_params, fval] = paretosearch(fun, 2, [], [], [], [], lb, ub, nlcon, options); 
tElapsed = toc(tStart); 

end


function [Cineq,Ceq] = nonlcon(x)  
    Cineq = [];  
    Ceq = [];  
end  

function F = objval(x,goalfreq, DataSystem, IteratorCapacitor, IteratorDiod, IteratorResistor_B, IteratorResistor_K, IteratorTransistor,... 
                              t, U_ratio, iRelative, power_b, resistance_b, P_ratio_b, power_k, P_ratio_k,... 
                              pRelative, s1)

    f1 = (goalfreq - 1 ./ (log(2) * (2 * x(1) .* x(2)))).^2;  
    f2 = getReliabilitySystemFromData(DataSystem, IteratorCapacitor, IteratorDiod, IteratorResistor_B, IteratorResistor_K, IteratorTransistor, t, x(1), U_ratio, iRelative, power_b, resistance_b, P_ratio_b, power_k, x(2), P_ratio_k, pRelative, s1);  

    F = [f1, f2];  
end  