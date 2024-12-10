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

% IteratorCapacitor   = 1;
% IteratorDiod        = 1;
% IteratorResistor_B  = 1;
% IteratorResistor_K  = 1;
% IteratorTransistor  = 1;
% t   = 30;
% capacity    = 1000e-12;
% U_ratio     = 1/2;
% iRelative   = 1/2;
% power_b     = 0.5;
% resistance_b= 200;
% P_ratio_b   = 1/2;
% power_k     = 0.5;
% resistance_k = 200;
% P_ratio_k   = 1/2;
% pRelative   = 1/2;
% s1  = 1/2;

VarSystem.IteratorCapacitor   = 1;
VarSystem.IteratorDiod        = 1;
VarSystem.IteratorResistor_B  = 1;
VarSystem.IteratorResistor_K  = 1;
VarSystem.IteratorTransistor  = 1;
VarSystem.t   = 30;
VarSystem.capacity    = 1000e-12;
VarSystem.U_ratio     = 1/2;
VarSystem.iRelative   = 1/2;
VarSystem.power_b     = 0.5;
VarSystem.resistance_b= 200;
VarSystem.P_ratio_b   = 1/2;
VarSystem.power_k     = 0.5;
VarSystem.resistance_k = 200;
VarSystem.P_ratio_k   = 1/2;
VarSystem.pRelative   = 1/2;
VarSystem.s1  = 1/2;
VarSystem.goalfreq  = 1000;

%% optimization
lb = [1 1 1 1 1]; 
ub = [117 2 81 81 225]-1; 
x0 = [1 1 1 1 1];

[best_params,fval,tElapsed] = run_gamultiobjDiscr_multi(DataSystem,VarSystem, lb, ub)

tElapsed
best_params
fval