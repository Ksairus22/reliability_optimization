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

rng default % For reproducibility  

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

    % f1 = abs(goalfreq - 1 ./ (log(2) * (2 * capacity .* resistance_k))); 
    f1 = 0;
    
    f2 = getReliabilitySystemFromData(DataSystem, 70,     1 ,   44 ,   73  , 160, t, capacity, U_ratio, iRelative, power_b, resistance_b, P_ratio_b, power_k, resistance_k, P_ratio_k, pRelative, s1);  
    
    f2
    F = [f1, f2];  