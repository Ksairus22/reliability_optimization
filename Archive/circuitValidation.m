clc, clear, close all
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
%%
electric_parameters = calculateCircuitParamsStruct_circuitValidation(DataSystem,VarSystem);
Rb = electric_parameters.Rb
Rbe = electric_parameters.Rbe
Re = electric_parameters.Re
mode = electric_parameters.Output

%%
function [electric_parameters] = calculateCircuitParamsStruct_circuitValidation(DataSystem,VarSystem)
    % inputStruct = struct(...
    %     'Us', 12,...
    %     'Ie', 1e-3,...
    %     'beta', DataSystem.Transistor.h21(VarSystem.IteratorTransistor),...
    %     'Ube', 0.55,...
    %     'Rb', VarSystem.resistance_B,...
    %     'Rbe', VarSystem.resistance_BE,...
    %     'Re', VarSystem.resistance_E,...
    %     'f', 20,...
    %     't', VarSystem.t);
    % electric_parameters = calculateCircuitParams(inputStruct);

inputStruct = struct(...
    'Re', VarSystem.resistance_E, ...      % Значение резистора Re
    'Rbe', VarSystem.resistance_BE, ...     % Значение резистора Rbe
    'Rb', VarSystem.resistance_B, ...      % Значение резистора Rb
    'beta', DataSystem.Transistor.h21(VarSystem.IteratorTransistor), ...    % Бета (усиление тока биполярного транзистора)
    'f', 20, ...      % Частота в герцах
    't', VarSystem.t, ...      % Временной интервал
    'Us', 12, ...       % Напряжение источника
    'Ube', 0.7 ...      % Напряжение на переходе базы-эмиттера
);

% Вызов функции
electric_parameters = calculateDirectCircuitParams(inputStruct);

end

