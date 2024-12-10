clc; clear; close all;  

%% Includes  
addpath("functions\");  
addpath("Models\");  
addpath("Models\capacitors\");  
addpath("Models\capacitors\functions\");  
addpath("Models\diods\");  
addpath("Models\diods\functions\");  
addpath("Models\resistors\");  
addpath("Models\resistors\functions\");  
addpath("Models\transistors\");    
addpath("Models\transistors\functions\");  

%%   
FilenameSystem.Capacitors = 'table_reliability_capacitor.xlsx';  
FilenameSystem.Diods = 'table_reliability_diod.xlsx';  
FilenameSystem.Resistors = 'table_reliability_resistor.xlsx';  
FilenameSystem.Transistors = 'table_reliability_transistor.xlsx';  

% Предварительная загрузка данных 
[DataSystem] = getTableSystemData(FilenameSystem); 

lb = [1e-12 100]; %[cap [F] res [Ohm] 
ub = [1e-1 1e6];  

fun = @(x) objval(x, DataSystem);  % Передайте DataSystem 
nlcon = @nonlcon;  

% Опции для fminimax с функциями отрисовки
options = optimoptions('fgoalattain','Display','iter', ...
                       'PlotFcn', {@optimplotfval, @optimplotfunccount, @optimplotx});

% Использование fminimax
x0 = [1e-12, 100]; % Начальная точка
[x_fm, fval_fm] = fgoalattain(fun, x0, [1000,0], [2,1], [], [], [], [], lb, ub, nlcon, options);

x_fm
fval_fm

function [Cineq,Ceq] = nonlcon(x)  
    Cineq = [];  
    Ceq = [];  
end  

function F = objval(x, DataSystem) % Добавлен аргумент DataSystem 
    % Параметры могут быть вынесены как константы 
    t = 30;  
    capacity = 1000e-12;  
    U_ratio = 1/2;  
    iRelative = 1/2;  
    power_b = 0.5;  
    resistance_b = 200;  
    P_ratio_b = 1/2;  
    power_k = 0.5;  
    resistance_k = 200;  
    P_ratio_k = 1/2;  
    pRelative = 1/2;  
    s1 = 1/2;  
    goalfreq = 1000; 

    f1 = 1 ./ (log(2) * (2 * x(1) .* x(2)));  
    f2 = getReliabilitySystemFromData(DataSystem, 1, 1, 1, 1, 1, t, x(1), U_ratio, iRelative, power_b, resistance_b, P_ratio_b, power_k, x(2), P_ratio_k, pRelative, s1);  

    F = [f1, f2];  
end  
