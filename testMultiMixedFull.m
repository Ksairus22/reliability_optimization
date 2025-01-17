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
lb = [1 1 1 1e-6 1e3 1e3 1e3]; 
ub = [117-1 81-1 225-1 1e-4 3e5 3e5 3e5]; 
x0 = [1 30 40 1e-6 10e3 20e3 10e3];
% 
% %% строить поверхность долго
% % Задаем диапазоны значений для capacity и resistance_k
% resistor_range = lb(1):ub(1);
% transistor_range = lb(2):ub(2);
% 
% 
% % Создаем сетку значений
% [ResistorsGrid, TransistorGrid] = meshgrid(resistor_range, transistor_range);
% 
% % % Предварительно создаем матрицу для хранения результатов
% % lambda_surface = zeros(size(ResistorsGrid));
% % rin_surface = zeros(size(ResistorsGrid));
% % % Вычисляем lambda для каждой комбинации capacity и resistance_k
% % for i = 1:size(ResistorsGrid, 1)
% %     for j = 1:size(ResistorsGrid, 2)
% %         VarSystem.IteratorCapacitor   = VarSystem.IteratorCapacitor;
% %         VarSystem.IteratorDiod        = VarSystem.IteratorDiod;
% %         VarSystem.IteratorResistor_B  = ResistorsGrid(i,j);
% %         VarSystem.IteratorResistor_BE = ResistorsGrid(i,j);
% %         VarSystem.IteratorResistor_E  = ResistorsGrid(i,j);
% %         VarSystem.IteratorTransistor  = TransistorGrid(i,j);
% 
% %         VarSystem.capacity     = VarSystem.capacity;
% %         VarSystem.resistance_B = VarSystem.resistance_B;
% %         VarSystem.resistance_BE= VarSystem.resistance_BE;
% %         VarSystem.resistance_E = VarSystem.resistance_E;
% 
% %         [lambda_surface(i, j), rin_surface(i, j)] = getReliabilityResInSystemFromData(DataSystem, VarSystem);
% %     end
% % end
% % save("lambda5_1","lambda_surface")
% % save("rin5_1","rin_surface")
% 
% lambda_surface = load("lambda5_1","lambda_surface");
% rin_surface = load("rin5_1","rin_surface");
% % Построение 3D поверхности
% figure;
% surf(ResistorsGrid, TransistorGrid, lambda_surface.lambda_surface,'EdgeColor','none');
% xlabel('X: Resistance_{index}');
% ylabel('Y: Transistor_{index}');
% zlabel('Z: Lambda (Failure Rate)');
% figure;
% surf(ResistorsGrid, TransistorGrid, rin_surface.rin_surface,'EdgeColor','none');
% xlabel('X: Resistance{index}');
% ylabel('Y: Transistor_{index}');
% zlabel('Z: R_{in} (Ω)');
% 
% figure 
% % shift=height(lambda_surface.lambda_surface);
% matr1_r=rin_surface.rin_surface;
% matr1_lam=lambda_surface.lambda_surface;
% % for i=1:height(lambda_surface.lambda_surface)
% %         pareto_x(i) = matr1_r(i,1);
% %     for j=1:height(lambda_surface.lambda_surface)
% %         tmp2(j) = matr1_lam(i,j);
% %     end
% %     pareto_y(i) = min(tmp2);
% % end
% % paretoFront = getParetoFront(matr1_r, matr1_lam)
% 
% 
% % scatter(pareto_y,pareto_x,'black','<','filled','SizeData',40)
% % grid
% % ylabel('Y: R_{in} (Ω)');
% % xlabel('X: Lambda (Failure Rate)');
% 
% pareto_front = get_pareto_front_matrices(matr1_r, matr1_lam);
% 
% % Визуализация
% figure;
% plot(matr1_r(:), matr1_lam(:), 'ko');  % Все решения
% hold on;
% plot(matr1_r(pareto_front), matr1_lam(pareto_front), 'ro');  % Парето-фронт
% xlabel('X: R_{in} (Ω)');
% ylabel('Y: Lambda (Failure Rate)');
% legend('Все решения', 'Парето-фронт');
% title("Истинный Парето-фронт")

%%
[best_params,fval,tElapsed] = run_gamultiobjMixed_multi(DataSystem,VarSystem, lb, ub);

%%
fval = abs(fval);

[fval, best_params] = removeRowsWithNaN(fval, best_params);
%%
figure;
plot(fval(:,1), fval(:,2), 'ko');  % Все решения


figure
hold on
for i = 1:length(fval)
    scatter(fval(i,1),fval(i,2),'filled','o','SizeData',200)
    % plot(fval(i,1), fval(i,2), 'o');  % Все решения
    str{i} = num2str(i)+" : IC="+num2str(best_params(i,1))+"; IR="+num2str(best_params(i,2))+"; IVT="+num2str(best_params(i,3))+"; C="+num2str(best_params(i,4))+"; Rb"+num2str(best_params(i,5))+"; Rbe="+num2str(best_params(i,6))+"; Re="+num2str(best_params(i,7))+" ";
end
xlabel('X: R_{in} (Ω)');
ylabel('Y: Lambda (Failure Rate)');
legend(str);
title("Gamultiobj Парето-фронт")
% xlim([0,16]*1e6)
% ylim([0,10]*1e-8)
tempMat = [fval,best_params];
tempMat = sortrows(tempMat,1);
writematrix(tempMat, 'tempMat.xlsx');
% tElapsed
% best_params
% fval