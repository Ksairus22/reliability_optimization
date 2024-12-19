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
resistance_b_range = linspace(1e3, .5e6, 70); % от 100 до 300
resistance_be_range = linspace(1e3, .5e6, 70); % от 100 до 300

% Создаем сетку значений
[ResistanceBEGrid, ResistanceBGrid] = meshgrid(resistance_be_range, resistance_b_range);

% Предварительно создаем матрицу для хранения результатов
lambda_surface = zeros(size(ResistanceBEGrid));

% % Вычисляем lambda для каждой комбинации capacity и resistance_k
% for i = 1:size(ResistanceBEGrid, 1)
%     for j = 1:size(ResistanceBEGrid, 2)
%         [VarSystem] = getVarSystemVariable(VarSystem.IteratorCapacitor, VarSystem.IteratorDiod, VarSystem.IteratorResistor_B, VarSystem.IteratorResistor_BE,...
%     VarSystem.IteratorResistor_E, VarSystem.IteratorTransistor, VarSystem.t, VarSystem.capacity,...
%     ResistanceBGrid(i, j),ResistanceBEGrid(i, j), VarSystem.resistance_E, VarSystem.goalfreq)
%         lambda_surface(i, j) = getReliabilitySystemFromData(DataSystem, VarSystem);
%     end
% end
% save("lambda1","lambda_surface")
% save("lambda","lambda_surface")
lambda_surface = load("lambda1","lambda_surface");
% lambda_surface = load("lambda","lambda_surface");
% Построение 3D поверхности
figure;
surf(ResistanceBEGrid, ResistanceBGrid, lambda_surface.lambda_surface,'EdgeColor','none');
%%
% Находим минимальное значение в матрице и его индекс
[minValue, linearIndex] = min(lambda_surface.lambda_surface(:));

% Преобразуем линейный индекс в двумерные индексы (строка и столбец)
[row, col] = ind2sub(size(lambda_surface.lambda_surface), linearIndex)
hold on
sc = scatter3(ResistanceBEGrid(row,col),ResistanceBGrid(row,col),lambda_surface.lambda_surface(row,col),'red','square','filled','SizeData',200); 
dt=datatip(sc);
% Задаем размер матрицы

% Создаем матрицу размером 70x70 с одинаковыми строками
matrixString = strings(height(ResistanceBGrid), width(ResistanceBGrid));

% Заполняем матрицу одинаковым элементом
matrixString(:) = "TrueMinimum"; % замените "element" на желаемое 

aa = dataTipTextRow('label',matrixString);
sc.DataTipTemplate.DataTipRows(end+1) = aa;

hold off
xlabel('X: Resistance_{be} (Ω)');
ylabel('Y: Resistance_{b} (Ω)');
zlabel('Z: Lambda (Failure Rate)');
title(' ');
colorbar; % Добавляем цветовую панель для обозначения значений lambda
%% Оптимизация 

x0 = [3e5 3e5]; 
lb = [1e3 1e3]; 
ub = [.5e6 .5e6]; 
numStarts = 100; 
plot_num = [];
fig = [];
%% Multistart
[best_params,fval,tElapsed] = run_multistartContRC(DataSystem, VarSystem, x0, lb, ub, numStarts) 
[fig, plot_num] = plotParam(fig, plot_num, best_params, fval, lambda_surface, ResistanceBEGrid, ResistanceBGrid,row,col,"Multistart",tElapsed);

%% Globalsearch
[best_params,fval,tElapsed] = run_globalsearchContRC(DataSystem, VarSystem, x0, lb, ub, numStarts) 
[fig, plot_num] = plotParam(fig, plot_num, best_params, fval, lambda_surface, ResistanceBEGrid, ResistanceBGrid,row,col,"Globalsearch",tElapsed);

%% Genetic 
[best_params,fval,tElapsed] = run_geneticContRC(DataSystem, VarSystem, x0, lb, ub, numStarts) 
[fig, plot_num] = plotParam(fig, plot_num, best_params, fval, lambda_surface, ResistanceBEGrid, ResistanceBGrid,row,col,"Genetic",tElapsed);

%% PatternSearch
[best_params, fval, tElapsed] = run_patternSearchContRC(DataSystem, VarSystem, x0, lb, ub, numStarts) 
[fig, plot_num] = plotParam(fig, plot_num, best_params, fval, lambda_surface, ResistanceBEGrid, ResistanceBGrid,row,col,"PatternSearch",tElapsed);

%% Simulated Annealing
[best_params, fval, tElapsed] = run_simulatedAnnealingContRC(DataSystem, VarSystem, x0, lb, ub, numStarts)
[fig, plot_num] = plotParam(fig, plot_num, best_params, fval, lambda_surface, ResistanceBEGrid, ResistanceBGrid,row,col,"Simulated Annealing",tElapsed);

%% Surrogate 
[best_params,fval,tElapsed] = run_surrogateContRC(DataSystem, VarSystem, lb, ub, numStarts)
[fig, plot_num] = plotParam(fig, plot_num, best_params, fval, lambda_surface, ResistanceBEGrid, ResistanceBGrid,row,col,"Surrogate",tElapsed);
 %%


 function [fig, num] = plotParam(fig, num, best_params, fval, lambda_surface, ResistanceBEGrid, ResistanceBGrid,row,col,name,tElapsed)
    if(isempty(fig) || isempty(num))
        num = 1;
    end
    fig = [fig figure()];

surf(ResistanceBEGrid, ResistanceBGrid, lambda_surface.lambda_surface,'EdgeColor','none');

xlabel('X: Resistance_{be} (Ω)');
ylabel('Y: Resistance_{b} (Ω)');
zlabel('Z: Lambda (Failure Rate)');
title(' ');
colorbar; % Добавляем цветовую панель для обозначения значений lambda

    hold on 
    sc = scatter3(best_params(1),best_params(2),fval,'red','square','filled','SizeData',200); 
    dt=datatip(sc);
    % min(min(lambda_surface.lambda_surface)

    % Создаем матрицу размером 70x70 с одинаковыми строками
matrixString = strings(height(ResistanceBGrid), width(ResistanceBGrid));

% Заполняем матрицу одинаковым элементом
matrixString(:) = name; % замените "element" на желаемое 

aa = dataTipTextRow('label',matrixString);
sc.DataTipTemplate.DataTipRows(end+1) = aa;

    
    sc = scatter3(ResistanceBEGrid(row,col),ResistanceBGrid(row,col),lambda_surface.lambda_surface(row,col),'green','square','filled','SizeData',200); 
    dt=datatip(sc);


% Заполняем матрицу одинаковым элементом
matrixString(:) = "TrueMinimum"; % замените "element" на желаемое 

aa = dataTipTextRow('label',matrixString);
sc.DataTipTemplate.DataTipRows(end+1) = aa;
    
    num = num + 1;
    hold off













    % Specify the Excel file name
filename = 'your_excel_file.xlsx'; % Replace 'your_excel_file.xlsx' with your actual file name

% Read the existing Excel file into a table
try
    existingData = readtable(filename);
catch
    existingData = [];
end

% Создайте структуру для нового значения
mstr = struct( ...
   'name', name, ...
   'best_params_1', best_params(1), ...
   'best_params_2', best_params(2), ...
   'fval', fval, ...
   'absError', lambda_surface.lambda_surface(row,col)-fval,...
   'tElapsed', tElapsed ...
);

% Преобразуйте структуру в таблицу
newTable = struct2table(mstr);

% Теперь попробуйте объединить таблицы
combinedData = [existingData; newTable];



% Write the combined data back to the Excel file
try
    writetable(combinedData, filename, 'Sheet',1); % Writes to the first sheet. Change 'Sheet',1 to specify other sheets if needed.
catch
    error('Error writing the table to Excel file.  Make sure the file is not open in another application.');
end

disp('Table appended successfully!');

end


