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
% [lambda] = getReliabilitySystemFromData(DataSystem, VarSystem)
%% строить поверхность долго
% Задаем диапазоны значений для capacity и resistance_k
capacity_range = linspace(1e-12, 1e-1, 100); % от 500 до 1500
resistance_k_range = linspace(1, 1.1e6, 100); % от 100 до 300

% Создаем сетку значений
[CapacityGrid, ResistanceKGrid] = meshgrid(capacity_range, resistance_k_range);

% Предварительно создаем матрицу для хранения результатов
lambda_surface = zeros(size(CapacityGrid));

% Вычисляем lambda для каждой комбинации capacity и resistance_k
for i = 1:size(CapacityGrid, 1)
    for j = 1:size(CapacityGrid, 2)
    %     [VarSystem] = getVarSystemVariable(VarSystem.IteratorCapacitor, VarSystem.IteratorDiod, VarSystem.IteratorResistor_B, VarSystem.IteratorResistor_BE,...
    % VarSystem.IteratorResistor_E, VarSystem.IteratorTransistor, VarSystem.t, CapacityGrid(i, j),...
    % ResistanceKGrid(i, j), VarSystem.resistance_BE, VarSystem.resistance_E, VarSystem.goalfreq)
        lambda_surface(i, j) = getReliabilitySystemFromData(DataSystem, VarSystem);
    end
end
% save("lambda","lambda_surface")
lambda_surface = load("lambda","lambda_surface");
% Построение 3D поверхности
figure;
surf(CapacityGrid, ResistanceKGrid, lambda_surface.lambda_surface,'EdgeColor','none');
xlabel('Capacity (μF)');
ylabel('Resistance (Ω)');
zlabel('Lambda (Failure Rate)');
title('Dependence of Lambda on Capacity and Resistance_k');
colorbar; % Добавляем цветовую панель для обозначения значений lambda
%% Оптимизация 
 
x0 = [200e-12 1e6]; 
lb = [100e-12 100]; 
ub = [1e-2 1.1e6]; 
numStarts = 200; 
plot_num = [];
fig = [];
% %% Multistart
% [best_params,fval,tElapsed] = run_multistartContRC(DataSystem, VarSystem, x0, lb, ub, numStarts) 
% [fig, plot_num] = plotParam(fig, plot_num, best_params, fval, lambda_surface, CapacityGrid, ResistanceKGrid);
% 
% %% Globalsearch
% [best_params,fval,tElapsed] = run_globalsearchContRC(DataSystem, VarSystem, x0, lb, ub) 
% [fig, plot_num] = plotParam(fig, plot_num, best_params, fval, lambda_surface, CapacityGrid, ResistanceKGrid);
% 
% %% Genetic 
% [best_params,fval,tElapsed] = run_geneticContRC(DataSystem, VarSystem, x0, lb, ub) 
% [fig, plot_num] = plotParam(fig, plot_num, best_params, fval, lambda_surface, CapacityGrid, ResistanceKGrid);
% 
% %% PatternSearch
% [best_params, fval, tElapsed] = run_patternSearchContRC(DataSystem, VarSystem, x0, lb, ub) 
% [fig, plot_num] = plotParam(fig, plot_num, best_params, fval, lambda_surface, CapacityGrid, ResistanceKGrid);
% 
% %% Simulated Annealing
% [best_params, fval, tElapsed] = run_simulatedAnnealingContRC(DataSystem, VarSystem, x0, lb, ub)
% [fig, plot_num] = plotParam(fig, plot_num, best_params, fval, lambda_surface, CapacityGrid, ResistanceKGrid);
% 
% %% Surrogate 
% [best_params,fval,tElapsed] = run_surrogateContRC(DataSystem, VarSystem, lb, ub)
% [fig, plot_num] = plotParam(fig, plot_num, best_params, fval, lambda_surface, CapacityGrid, ResistanceKGrid);
 %%


function [fig, num] = plotParam(fig, num, best_params, fval, lambda_surface, CapacityGrid, ResistanceKGrid)
    if(isempty(fig) || isempty(num))
        num = 1;
    end
    fig = [fig figure()];

surf(CapacityGrid, ResistanceKGrid, lambda_surface.lambda_surface);
xlabel('Capacity (μF)');
ylabel('Resistance (Ω)');
zlabel('Lambda (Failure Rate)');
title('Dependence of Lambda on Capacity and Resistance_k');

    hold on 
    sc = scatter3(best_params(1),best_params(2),fval,'red','square','filled','SizeData',200); 
    min(min(lambda_surface.lambda_surface))
    
    hold on
    sc = scatter3(best_params(1),best_params(2),fval,'red','square','filled','SizeData',200);
    
    num = num + 1;
end

