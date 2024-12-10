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
VarSystem.goalfreq  = 1000;
%% prototype
% [lambda] = getReliabilitySystemFromData(DataSystem, VarSystem)
%% строить поверхность долго
% Задаем диапазоны значений для capacity и resistance_k
capacity_range = linspace(100, 15000000, 100); % от 500 до 1500
resistance_k_range = linspace(100, 1100000, 100); % от 100 до 300

% Создаем сетку значений
[CapacityGrid, ResistanceKGrid] = meshgrid(capacity_range, resistance_k_range);

% % Предварительно создаем матрицу для хранения результатов
% lambda_surface = zeros(size(CapacityGrid));
% 
% % Вычисляем lambda для каждой комбинации capacity и resistance_k
% for i = 1:size(CapacityGrid, 1)
%     for j = 1:size(CapacityGrid, 2)
%         lambda_surface(i, j) = getReliabilitySystemFromData(DataSystem, ...
%             IteratorCapacitor, IteratorDiod, IteratorResistor_B, IteratorResistor_K, IteratorTransistor, ...
%             t, CapacityGrid(i, j), U_ratio, iRelative, power_b, resistance_b, P_ratio_b, ...
%             power_k, ResistanceKGrid(i, j), P_ratio_k, pRelative, s1);
%     end
% end
lambda_surface = load("lambda","lambda_surface");
% save("lambda","lambda_surface")
% Построение 3D поверхности
figure;
surf(CapacityGrid, ResistanceKGrid, lambda_surface.lambda_surface);
xlabel('Capacity (μF)');
ylabel('Resistance (Ω)');
zlabel('Lambda (Failure Rate)');
title('Dependence of Lambda on Capacity and Resistance_k');
colorbar; % Добавляем цветовую панель для обозначения значений lambda
%% Оптимизация 
 
x0 = [200e-12 1e6]; 
lb = [100e-12 100]; 
ub = [1e-1 1e7]; 
numStarts = 200; 
plot_num = [];
fig = [];
%% Multistart
[best_params,fval,tElapsed] = run_multistartContRC(DataSystem, VarSystem, x0, lb, ub, numStarts) 
[fig, plot_num] = plotParam(fig, plot_num, best_params, fval, lambda_surface);

%% Globalsearch
[best_params,fval,tElapsed] = run_globalsearchContRC(DataSystem, VarSystem, x0, lb, ub) 
[fig, plot_num] = plotParam(fig, plot_num, best_params, fval, lambda_surface);

%% Genetic 
[best_params,fval,tElapsed] = run_geneticContRC(DataSystem, VarSystem, x0, lb, ub) 
[fig, plot_num] = plotParam(fig, plot_num, best_params, fval, lambda_surface);

%% PatternSearch
[best_params, fval, tElapsed] = run_patternSearchContRC(DataSystem, VarSystem, x0, lb, ub) 
[fig, plot_num] = plotParam(fig, plot_num, best_params, fval, lambda_surface);

%% Simulated Annealing
[best_params, fval, tElapsed] = run_simulatedAnnealingContRC(DataSystem, VarSystem, x0, lb, ub)
[fig, plot_num] = plotParam(fig, plot_num, best_params, fval, lambda_surface);

%% Surrogate 
[best_params,fval,tElapsed] = run_surrogateContRC(DataSystem, VarSystem, lb, ub)
[fig, plot_num] = plotParam(fig, plot_num, best_params, fval, lambda_surface);
 %%


function [fig, num] = plotParam(fig, num, best_params, fval, lambda_surface)
    if(isempty(fig) || isempty(num))
        num = 1;
    end
    fig = [fig figure(num)];
    hold on 
    sc = scatter3(best_params(1),best_params(2),fval,'red','square','filled','SizeData',200); 
    min(min(lambda_surface.lambda_surface))
    
    hold on
    sc = scatter3(best_params(1),best_params(2),fval,'red','square','filled','SizeData',200);
    
    num = num + 1;
end

