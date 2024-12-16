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

[VarSystem] = getVarSystem();

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
[best_params,fval,tElapsed] = run_fminimaxContRC_multi(DataSystem, VarSystem, x0, lb, ub) 

%% fgoalattain
[best_params,fval,tElapsed] = run_fgoalattainContRC_multi(DataSystem,goal,weight, VarSystem, x0, lb, ub) 
%% gamultiobj
[best_params,fval,tElapsed] = run_gamultiobjContRC_multi(DataSystem, VarSystem, lb, ub) 

%% paretosearch
[best_params,fval,tElapsed] = run_paretosearchContRC_multi(DataSystem, VarSystem, lb, ub)

best_params
fval

