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

IteratorCapacitor   = 1;
IteratorDiod        = 1;
IteratorResistor_B  = 1;
IteratorResistor_K  = 1;
IteratorTransistor  = 1;
t   = 30;
capacity    = 1000;
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


