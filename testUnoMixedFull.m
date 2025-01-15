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
[VarSystem] = getVarSystem();
%% prototype
[lambda_init] = getReliabilitySystemFromData(DataSystem, VarSystem)
%% optimization
    % VarSystem.IteratorCapacitor   = x(1);
    % VarSystem.IteratorResistor_B  = x(2);
    % VarSystem.IteratorResistor_BE = x(2);
    % VarSystem.IteratorResistor_E  = x(2);
    % VarSystem.IteratorTransistor  = x(3);
    % 
    % VarSystem.resistance_B  = x(4);
    % VarSystem.resistance_BE = x(5);
    % VarSystem.resistance_E  = x(6);
    % VarSystem.capacity      = x(7);

lb = [  1       1       1       1e3 1e3 1e3 1e-6]; 
ub = [  117-1   81-1    225-1   .5e6 .5e6 .5e6 1e-4]; 
x0 = [  1       30      41      10e3 20e3 10e3 1e-6];
numVar = 7;
plot_num = [];
fig = [];
numStarts = 10000; 


%% Genetic 
[best_params1,fval1,tElapsed1] = run_geneticMixedFull(DataSystem, VarSystem, x0, lb, ub, numVar,numStarts) 
%% Surrogate 
% [best_params2, fval2, tElapsed2] = run_surrogateoptMixedFull(DataSystem,VarSystem, lb, ub, numVar,numStarts)  

%% prototype val
VarSystem.IteratorCapacitor   = best_params1(1);
VarSystem.IteratorResistor_B  = best_params1(2);
VarSystem.IteratorResistor_BE = best_params1(2);
VarSystem.IteratorResistor_E  = best_params1(2);
VarSystem.IteratorTransistor  = best_params1(3);
VarSystem.resistance_B  = best_params1(4);
VarSystem.resistance_BE = best_params1(5);
VarSystem.resistance_E  = best_params1(6);
VarSystem.capacity      = best_params1(7);
[lambda_val] = getReliabilitySystemFromData(DataSystem, VarSystem)
