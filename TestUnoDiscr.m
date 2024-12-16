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
addpath("Models\transistors\")  
addpath("Models\transistors\functions\");

%% 
FilenameSystem.Capacitors = 'table_reliability_capacitor.xlsx';
FilenameSystem.Diods = 'table_reliability_diod.xlsx';
FilenameSystem.Resistors = 'table_reliability_resistor.xlsx';
FilenameSystem.Transistors = 'table_reliability_transistor.xlsx';
%% prototype
% [lambda] = getReliabilitySystemFromData(DataSystem, VarSystem)
%%
[DataSystem] = getTableSystemData(FilenameSystem);

[VarSystem] = getVarSystem();

%% optimization
lb = [1 1 1 1 1]; 
ub = [117 2 81 81 225]-1; 
x0 = [1 1 1 1 1];
%% Genetic 
[best_params,fval,tElapsed] = run_geneticDiscr(DataSystem, VarSystem, x0, lb, ub) 

%% Surrogate 
[best_params, fval, tElapsed] = run_surrogateoptDiscr(DataSystem,VarSystem, lb, ub)  
