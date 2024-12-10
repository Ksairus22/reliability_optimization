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

%%
[DataSystem] = getTableSystemData(FilenameSystem);

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
%% Оптимизация 
goalfreq = 100; 
x0 = [1e-12 1000];  
lb = [1e-12 1000]; 
ub = [1e-3 1e+7]; 
numStarts = 200; 
%% Multistart
% [best_params,fval,tElapsed] = run_multistartContRC_freq(goalfreq, x0, lb, ub, numStarts) 
 %% Globalsearch
[best_params,fval,tElapsed] =  run_globalsearchContRC_freq(goalfreq, x0, lb, ub) 
%% Genetic 
% [best_params, fval, tElapsed] = run_geneticContRC_freq(goalfreq, x0, lb, ub) 
%% PatternSearch
% [best_params, fval, tElapsed] = run_patternSearchContRC_freq(goalfreq, x0, lb, ub) 
%% Simulated Annealing
% [best_params, fval, tElapsed] = run_simulatedAnnealingContRC_freq(goalfreq, x0, lb, ub) 
%% Surrogate 
% [best_params, fval, tElapsed] = run_surrogateContRC_freq(goalfreq, lb, ub) 
% 
sse_func = @(x, y) 1./(log(2)*(2*x.*y));
fsurf(sse_func,[0,1200],"MeshDensity",100)


hold on
sc = scatter3(best_params(1),best_params(2),sse_func(best_params(1),best_params(2)),'red','square','filled','SizeData',200);

f = sse_func(best_params(1),best_params(2))


