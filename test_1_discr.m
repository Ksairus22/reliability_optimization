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
% [lambda] = getReliabilitySystemFromData(DataSystem,...
%     IteratorCapacitor, IteratorDiod, IteratorResistor_B, IteratorResistor_K, IteratorTransistor,...
%     t, capacity, U_ratio, iRelative, power_b, resistance_b, P_ratio_b,...
%     power_k, resistance_k, P_ratio_k, pRelative, s1)
%%
[DataSystem] = getTableSystemData(FilenameSystem);

% IteratorCapacitor   = 1;
% IteratorDiod        = 1;
% IteratorResistor_B  = 1;
% IteratorResistor_K  = 1;
% IteratorTransistor  = 1;
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
lb = [1 1 1 1 1]; 
ub = [117 2 81 81 225]-1; 
x0 = [1 1 1 1 1];
%% Genetic 
% [best_params,fval,tElapsed] = run_geneticDiscr(DataSystem,...
%                                   t, capacity, U_ratio, iRelative, power_b, resistance_b, P_ratio_b,...
%                                   power_k, resistance_k, P_ratio_k, pRelative, s1,...
%                                   x0, lb, ub);
%% Surrogate 
[best_params,fval,tElapsed] = run_surrogateoptDiscr(DataSystem,...
                                  t, capacity, U_ratio, iRelative, power_b, resistance_b, P_ratio_b,...
                                  power_k, resistance_k, P_ratio_k, pRelative, s1,...
                                  x0, lb, ub) 
%%

% sse_fun  = @(x) getReliabilitySystemFromData(DataSystem,...
%     x(1)+1, x(2)+1, x(3)+1, x(4)+1, x(5)+1,...
%     t, capacity, U_ratio, iRelative, power_b, resistance_b, P_ratio_b,...
%     power_k, resistance_k, P_ratio_k, pRelative, s1)
% 
% lb = [1 1 1 1 1]; 
% ub = [117 2 81 81 225]-1; 
% % ub = [20 2 20 20 20]-1; 
% 
%     opts = optimoptions(@ga, ...
%                         'PopulationSize', 20, ...
%                         'MaxGenerations', 100, ...
%                         'EliteCount', 10, ...
%                         'FunctionTolerance', 1e-8, ...
%                         'PlotFcn', @gaplotbestfun);
% 
% [xbest, fbest, exitflag] = ga(sse_fun, 5, [], [], [], [], ...
%     lb, ub, [], 1:5, opts);
% xbest=xbest+1;
% outputstruct.xbest=xbest;
% outputstruct.fbest=fbest;
% outputstruct

