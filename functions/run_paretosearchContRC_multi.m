function [best_params,fval,tElapsed] = run_paretosearchContRC_multi(DataSystem, VarSystem, lb, ub, numStarts)

fun = @(x) getFunctionSystemMultiCont(x, DataSystem, VarSystem);

nlcon = @nonlcon;  

% Настройки для gamultiobj
options = optimoptions('paretosearch',...
                        'Display','off',...
                        'PlotFcn',{'psplotparetof' 'psplotparetox' 'psplotspread' 'psplotvolume' 'psplotfuncount' 'psplotdistance'});  

tStart = tic;
[best_params, fval] = paretosearch(fun, 2, [], [], [], [], lb, ub, nlcon, options); 
tElapsed = toc(tStart); 

end


function [Cineq,Ceq] = nonlcon(x)  
    Cineq = [];  
    Ceq = [];  
end  