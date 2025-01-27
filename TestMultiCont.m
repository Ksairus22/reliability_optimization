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
x0 = [3e5 3e5]; 
lb = [1e3 1e3]; 
ub = [.5e6 .5e6]; 

% Использование fminimax
% [x_fm, fval_fm] = fminimax(fun, x0, [], [], [], [], lb, ub, nlcon, options);
goal = [0,-inf];
weight = [1,1];
numStarts = 1000;
%% строить поверхность долго
% Задаем диапазоны значений для capacity и resistance_k
resistance_b_range = linspace(lb(1),ub(1),100);
resistance_e_range = linspace(lb(2),ub(2),100);


% Создаем сетку значений
[ResistanceBGrid, ResistanceEGrid] = meshgrid(resistance_b_range, resistance_e_range);

% % Предварительно создаем матрицу для хранения результатов
% lambda_surface = zeros(size(ResistanceBGrid));
% rin_surface = zeros(size(ResistanceBGrid));
% % Вычисляем lambda для каждой комбинации capacity и resistance_k
% for i = 1:size(ResistanceBGrid, 1)
%     for j = 1:size(ResistanceBGrid, 2)
%         [VarSystem] = getVarSystemVariable(VarSystem.IteratorCapacitor, VarSystem.IteratorDiod, VarSystem.IteratorResistor_B, VarSystem.IteratorResistor_BE,...
%     VarSystem.IteratorResistor_E, VarSystem.IteratorTransistor, VarSystem.t, VarSystem.capacity,...
%     ResistanceBGrid(i, j),ResistanceBGrid(i, j), ResistanceEGrid(i, j), VarSystem.goalfreq)
%         [lambda_surface(i, j), rin_surface(i, j)] = getReliabilityResInSystemFromData(DataSystem, VarSystem);
%     end
% end
% save("lambda4_1","lambda_surface")
% save("rin4_1","rin_surface")
lambda_surface = load("lambda4_1","lambda_surface");
rin_surface = load("rin4_1","rin_surface");
% Построение 3D поверхности
figure;
surf(ResistanceBGrid, ResistanceEGrid, lambda_surface.lambda_surface,'EdgeColor','none');
xlabel('X: Resistance_{b} (Ω)');
ylabel('Y: Resistance_{e} (Ω)');
zlabel('Z: Lambda (Failure Rate)');
figure;
surf(ResistanceBGrid, ResistanceEGrid, rin_surface.rin_surface,'EdgeColor','none');
xlabel('X: Resistance_{b} (Ω)');
ylabel('Y: Resistance_{e} (Ω)');
zlabel('Z: R_{in} (Ω)');

figure 
shift=height(lambda_surface.lambda_surface);
matr1_r=rin_surface.rin_surface;
matr1_lam=lambda_surface.lambda_surface;
for i=1:height(lambda_surface.lambda_surface)
        pareto_x(i) = matr1_r(i,1);
    for j=1:height(lambda_surface.lambda_surface)
        tmp2(j) = matr1_lam(i,j);
    end
    pareto_y(i) = min(tmp2);
end
scatter(pareto_x,pareto_y,'black','<','filled','SizeData',40)
grid
xlabel('X: R_{in} (Ω)');
ylabel('Y: Lambda (Failure Rate)');
xlim([0 1]*1e7)
ylim([0 6]*1e-8)
%% fminimax
% [best_params,fval,tElapsed] = run_fminimaxContRC_multi(DataSystem, VarSystem, x0, lb, ub, numStarts) 

%% fgoalattain
% [best_params,fval,tElapsed] = run_fgoalattainContRC_multi(DataSystem,goal,weight, VarSystem, x0, lb, ub, numStarts) 
%% gamultiobj
[best_params1,fval1,tElapsed1] = run_gamultiobjContRC_multi(DataSystem, VarSystem, lb, ub, numStarts);
fval1 = abs(fval1);
[fig1] = plotParetto(fval1(:,1),fval1(:,2),"gamultiobj");

%% paretosearch
[best_params2,fval2,tElapsed2] = run_paretosearchContRC_multi(DataSystem, VarSystem, lb, ub, numStarts);
fval2 = abs(fval2);
[fig2] = plotParetto(fval2(:,1),fval2(:,2),"paretosearch");
%%
figure
scatter(fval1(:,1),fval1(:,2),'red','filled','o','SizeData' ,200)
grid
legend("Pareto solve")
title("gamultiobj")
xlabel('X: R_{in} (Ω)');
ylabel('Y: Lambda (Failure Rate)');
xlim([0 1]*1e7)
ylim([0 6]*1e-8)

%%
figure
scatter(fval2(:,1),fval2(:,2),'blue','filled','o','SizeData',200)
grid
legend("Pareto solve")
title("paretosearch")
xlabel('X: R_{in} (Ω)');
ylabel('Y: Lambda (Failure Rate)');
xlim([0 1]*1e7)
ylim([0 6]*1e-8)

%%
figure
scatter(pareto_x,pareto_y,'black','<','filled','SizeData',40)
hold on
scatter(fval1(:,1),fval1(:,2),'red','filled','o','SizeData' ,200)
scatter(fval2(:,1),fval2(:,2),'blue','filled','o','SizeData',200)
hold off
grid
legend("Thrue Paretto front","gamultiobj","paretosearch")
title("Compare")
xlabel('X: R_{in} (Ω)');
ylabel('Y: Lambda (Failure Rate)');
xlim([0 1]*1e7)
ylim([0 6]*1e-8)

%%
function [fig] = plotParetto(fx,fy,name)
    fig = figure;
    scatter(fx,fy)
    title(name);
    grid
    xlabel('X: R_{in} (Ω)');
    ylabel('Y: Lambda (Failure Rate)');
    xlim([0 6]*1e7)
    ylim([0 6]*1e-8)
end
