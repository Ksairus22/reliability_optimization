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

IteratorCapacitor   = 1;
IteratorDiod        = 1;
IteratorResistor_B  = 1;
IteratorResistor_K  = 1;
IteratorTransistor  = 1;
t   = 30;
capacity    = 1000e-12;
U_ratio     = 1/2;
iRelative   = 1/2;
power_b     = 0.5;
resistance_b= 200;
P_ratio_b   = 1/2;
power_k     = 0.5;
resistance_k = 200;
P_ratio_k   = 1/2;
pRelative   = 1/2;
s1  = 1/2;


%% optimization
goalfreq = 1000; 
x0 = [1e-12 1000];  
lb = [1e-12 1000]; 
ub = [1e-3 1e+7]; 

% Использование fminimax
x0 = [1e-12, 100]; % Начальная точка
% [x_fm, fval_fm] = fminimax(fun, x0, [], [], [], [], lb, ub, nlcon, options);
goal = [1000,0];
weight = [2,1];
%% fminimax
% [best_params,fval,tElapsed] = run_fminimaxContRC_multi(DataSystem,goalfreq, IteratorCapacitor, IteratorDiod, IteratorResistor_B, IteratorResistor_K, IteratorTransistor,... 
%                               t, U_ratio, iRelative, power_b, resistance_b, P_ratio_b, power_k, P_ratio_k,... 
%                               pRelative, s1, ... 
%                               x0, lb, ub) 
%% fgoalattain
% [best_params,fval,tElapsed] = run_fgoalattainContRC_multi(DataSystem,goalfreq,goal,weight,IteratorCapacitor, IteratorDiod, IteratorResistor_B, IteratorResistor_K, IteratorTransistor,... 
%                               t, U_ratio, iRelative, power_b, resistance_b, P_ratio_b, power_k, P_ratio_k,... 
%                               pRelative, s1, ... 
%                               x0, lb, ub) 
%% gamultiobj
% [best_params,fval,tElapsed] = run_gamultiobjContRC_multi(DataSystem,goalfreq, IteratorCapacitor, IteratorDiod, IteratorResistor_B, IteratorResistor_K, IteratorTransistor,... 
%                               t, U_ratio, iRelative, power_b, resistance_b, P_ratio_b, power_k, P_ratio_k,... 
%                               pRelative, s1, ... 
%                               lb, ub) 
%% paretosearch
[best_params,fval,tElapsed] = run_paretosearchContRC_multi(DataSystem,goalfreq, IteratorCapacitor, IteratorDiod, IteratorResistor_B, IteratorResistor_K, IteratorTransistor,... 
                              t, U_ratio, iRelative, power_b, resistance_b, P_ratio_b, power_k, P_ratio_k,... 
                              pRelative, s1, ... 
                              lb, ub) 
best_params
fval

