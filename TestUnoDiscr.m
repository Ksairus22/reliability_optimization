clc; clear; close all;
% Закрывает все окна msgbox
h = findall(0, 'Type', 'figure');
for i = 1:length(h)
    if contains(get(h(i), 'Tag'), 'Msgbox_ ') % Или любое другое условие для фильтрации
        close(h(i));
    end
end
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
%% Script param
[DataSystem] = getTableSystemData(FilenameSystem);
[VarSystem] = getVarSystem();
global drawing;
drawing.f = []; % Инициализация массива f
drawing.x = []; % Инициализация массива x

lb = [1 1]; 
ub = [81 225]-1; 
x0 = [30 30];
numVar = 2;
numStarts = 40; 
plot_num = [];
fig = [];
plot_dens = 100;
opt_mod = 1;
write_mod = 1;

%% строить поверхность долго
% Задаем диапазоны значений для capacity и resistance_k
resistance_range = lb(1):ub(1);
transistor_range = lb(2):ub(2);

% Создаем сетку значений
[ResistanceGrid, TransitorGrid] = meshgrid(resistance_range,transistor_range);

% % Предварительно создаем матрицу для хранения результатов
% lambda_surface = zeros(size(ResistanceGrid));
% 
% % Вычисляем lambda для каждой комбинации capacity и resistance_k
% for i = 1:size(ResistanceGrid, 1)
%     for j = 1:size(ResistanceGrid, 2)
%         [VarSystem] = getVarSystemVariable(VarSystem.IteratorCapacitor, VarSystem.IteratorDiod, ResistanceGrid(i,j), ResistanceGrid(i,j),...
%     ResistanceGrid(i,j), TransitorGrid(i,j), VarSystem.t, VarSystem.capacity,...
%     VarSystem.resistance_B,VarSystem.resistance_BE, VarSystem.resistance_E, VarSystem.goalfreq)
%         lambda_surface(i, j) = getReliabilitySystemFromData(DataSystem, VarSystem);
%     end
% end
% save("lambda2","lambda_surface")
lambda_surface = load("lambda2","lambda_surface");
% Построение 3D поверхности
figure;
surf(ResistanceGrid, TransitorGrid, lambda_surface.lambda_surface,'EdgeColor','none');
% contourf(ResistanceGrid, TransitorGrid, lambda_surface.lambda_surface);
% scatter3(ResistanceGrid, TransitorGrid, lambda_surface.lambda_surface,'black','filled');
%%
% Находим минимальное значение в матрице и его индекс
[minValue, linearIndex] = min(lambda_surface.lambda_surface(:));

% Преобразуем линейный индекс в двумерные индексы (строка и столбец)
[row, col] = ind2sub(size(lambda_surface.lambda_surface), linearIndex)
hold on
sc = scatter3(ResistanceGrid(row,col),TransitorGrid(row,col),lambda_surface.lambda_surface(row,col),'red','square','filled','SizeData',200); 
dt=datatip(sc);
% Задаем размер матрицы

% Создаем матрицу размером 70x70 с одинаковыми строками
matrixString = strings(height(ResistanceGrid), width(TransitorGrid));

% Заполняем матрицу одинаковым элементом
matrixString(:) = "TrueMinimum"; % замените "element" на желаемое 

aa = dataTipTextRow('label',matrixString);
sc.DataTipTemplate.DataTipRows(end+1) = aa;

hold off
xlabel('X: Resistor_{index}');
ylabel('Y: Transistor_{index}');
zlabel('Z: Lambda (Failure Rate)');
title(' ');
colorbar
if(opt_mod == 1)
    %% Direct opt
    %% Genetic 
    [best_params,fval,tElapsed] = run_geneticDiscr(DataSystem, VarSystem, x0, lb, ub, numVar,numStarts);
    [fig, plot_num] = plotParam(fig, plot_num, x0, VarSystem, DataSystem, best_params, fval, lambda_surface, ResistanceGrid, TransitorGrid,row,col,'Genetic',tElapsed);
    %% Surrogate 
    [best_params, fval, tElapsed] = run_surrogateoptDiscr(DataSystem,VarSystem, lb, ub, numVar,numStarts); 
    [fig, plot_num] = plotParam(fig, plot_num, x0, VarSystem, DataSystem, best_params, fval, lambda_surface, ResistanceGrid, TransitorGrid,row,col,'Surrogate',tElapsed);
folderName = 'figures\traektfigures_unodiscr';
save_all_figures(folderName);  

elseif(opt_mod == 2)
    %% Statistic opt
    numOpts = 5;
    numStarts = 40;
    numPoint = [5, 5];    % plot_dens
    
    k_range = [0.1, 0.1];
    range_delta = [(ub(1)-lb(1)), (ub(2)-lb(2))];
    lb_opt_space = [lb(1)+range_delta(1)*k_range(1), lb(2)+range_delta(2)*k_range(2)];
    ub_opt_space = [ub(1)-range_delta(1)*k_range(1), ub(2)-range_delta(2)*k_range(2)];
    x0_vecX = (linspace(lb_opt_space(1),ub_opt_space(1),numPoint(1)));
    x0_vecY = (linspace(lb_opt_space(2),ub_opt_space(2),numPoint(2)));
    [x0_matY, x0_matX] = meshgrid(x0_vecY, x0_vecX);
    
    % % 
% Визуализация
% figure;
hold on;
view(2)
scatter(x0_matX, x0_matY, 'filled','k'); % Отображение точек


% Рисуем прямоугольник
rectangle('Position', [lb_opt_space(1), lb_opt_space(2), ...
                       ub_opt_space(1) - lb_opt_space(1), ...
                       ub_opt_space(2) - lb_opt_space(2)], ...
          'EdgeColor', 'r', 'LineWidth', 1.5, 'LineStyle', '--');

% Настройки графика
xlabel('X');
ylabel('Y');
axis equal; % Равные масштабы по осям
title('Равномерное распределение точек внутри прямоугольника');
grid on;
hold off;
    % % 

    best_params = zeros(6, size(x0_matX,1), size(x0_matY,2), numOpts, 2);
    fval        = zeros(6, size(x0_matX,1), size(x0_matY,2), numOpts);
    tElapsed    = zeros(6, size(x0_matX,1), size(x0_matY,2), numOpts);

    %% Progress-bar handle
    % Создание окна
    hFig = figure('Name', 'Графический прогресс-бар', 'NumberTitle', 'off', ...
                  'Position', [50, 500, 400, 100], 'Resize', 'off');    
    % Создание панели для прогресс-бара
    hPanel = uipanel('Parent', hFig, 'Position', [0.1, 0.4, 0.8, 0.2]);    
    % Создание графического элемента для отображения прогресса
    hProgressBar = uicontrol('Style', 'text', 'Parent', hPanel, ...
                              'BackgroundColor', 'g', 'Position', [0, 0, 0, 20]);    
    % Создание текстового элемента для отображения процентов
    hPercentage = uicontrol('Style', 'text', 'Parent', hPanel, ...
                            'Position', [175, 0, 50, 20], ...
                            'String', '0%', 'FontSize', 10, ...
                            'HorizontalAlignment', 'center');
    % Определяем количество итераций
    numIterations = 6*size(x0_matX,1)*size(x0_matY,2)*numOpts;
    if(write_mod)
    %% Run statistics
    for met = 0:1
    for i = 1:size(x0_matX,1)
        for j = 1:size(x0_matY,2)
            for k = 1:numOpts
                x0_val = [x0_matX(i,j),x0_matY(i,j)]
                switch met
                    case 0
                    %% Genetic 
                        [best_params(3,i,j,k,:),fval(3,i,j,k),tElapsed(3,i,j,k)] = run_geneticDiscr(DataSystem, VarSystem, x0, lb, ub, numVar,numStarts);
                    case 1
                    %% Surrogate 
                        [best_params(6,i,j,k,:), fval(6,i,j,k), tElapsed(6,i,j,k)] = run_surrogateoptDiscr(DataSystem,VarSystem, lb, ub, numVar,numStarts); 
                    otherwise
                        error("why you here")
                end
                %% Draw progrss-bar
                progress = ((met)*size(x0_matX,1)*size(x0_matY,2)*numOpts + (i-1)*size(x0_matY,2)*numOpts + (j-1)*numOpts + (k-1))/numIterations;
                numIterations = 6*size(x0_matX,1)*size(x0_matY,2)*numOpts;
                % Обновляем длину прогресс-бара
                set(hProgressBar, 'Position', [0, 0, progress * 320, 20]); % 400 - ширина окна
                set(hPercentage, 'String', sprintf('%.0f%%', progress * 100)); % Отображаем проценты
            end
        end
    end
    end
    
    save("best_params_stat1","best_params");
    save("fval_stat1","fval");
    save("tElapsed_stat1","tElapsed");
    end

    load("best_params_stat1","best_params");
    load("fval_stat1","fval");
    load("tElapsed_stat1","tElapsed");

    % % x_mat = (1:length(x0_matr))'*ones(1,10);
    % x_mat = (squeeze(x0_matr(:,1)))*ones(1,10);
    % figure()
    % scatter(x_mat, squeeze(fval(1, :, :)))

plotMeanSurfaces(fval, x0_vecX, x0_vecY, minValue, max(max(max(max(fval)))), numOpts);
plotMeanSurfaces(tElapsed, x0_vecX, x0_vecY, min(min(min(min(tElapsed)))), max(max(max(max(tElapsed)))), numOpts);
folderName = 'figures\statfigures_unodiscr';
save_all_figures(folderName);   


else
    warning('Uncorrect opt mod');
end
msgbox('Success');



function [fig, plot_num] = plotParam(fig, plot_num, x0, VarSystem, DataSystem, best_params, fval, lambda_surface, ResistanceBEGrid, ResistanceBGrid,row,col,name,tElapsed)
fontsz = 7; 
    if(isempty(fig) || isempty(plot_num))
        plot_num = 1;
    end
    % Ширина и высота каждой фигуры
    xPos = 100;
    yPos = 100;
    mul = 0.8;
    figWidth = mul*600;
    figHeight = mul*450;
    fig = [fig figure('Position', [xPos, yPos, figWidth, figHeight]);];

surf(ResistanceBEGrid, ResistanceBGrid, lambda_surface.lambda_surface,'EdgeColor','none', 'FaceAlpha', 0.5);
ax = gca;
% ax.ZDir="reverse";


xlabel('X: Resistor_{index}');
ylabel('Y: Transistor_{index}');
zlabel('Z: Lambda (Failure Rate)');
title(' ');
colorbar; % Добавляем цветовую панель для обозначения значений lambda

    hold on 
    sc = scatter3(best_params(1),best_params(2),fval,'red','square','filled','SizeData',400); 
    dt=datatip(sc);
    dt.Location="northwest";
% 
% Настройка свойств datatip
set(dt, 'FontSize', fontsz); % Уменьшение размера шрифта
% 
    % min(min(lambda_surface.lambda_surface)

    % Создаем матрицу размером 70x70 с одинаковыми строками
matrixString = strings(height(ResistanceBGrid), width(ResistanceBGrid));

% Заполняем матрицу одинаковым элементом
matrixString(:) = name; % замените "element" на желаемое 

aa = dataTipTextRow('label',matrixString);

sc.DataTipTemplate.DataTipRows(end+1) = aa;

    
    sc = scatter3(ResistanceBEGrid(row,col),ResistanceBGrid(row,col),lambda_surface.lambda_surface(row,col),'green','square','filled','SizeData',400); 
    dt=datatip(sc);
    dt.Location="northeast";
% Настройка свойств datatip
set(dt, 'FontSize', fontsz); % Уменьшение размера шрифта

% % % 
% % % 
% Заполняем матрицу одинаковым элементом
matrixString1 = strings(height(ResistanceBGrid), width(ResistanceBGrid));
matrixString1(:) = 'x_0'; % замените "element" на желаемое 

sc1 = scatter3(x0(1),x0(2),getFunctionSystemUnoDiscr(x0, DataSystem, VarSystem),'magenta','square','filled','SizeData',400); 
bb = dataTipTextRow('label',matrixString1);

sc1.DataTipTemplate.DataTipRows(end+1) = bb;

    

    dt1=datatip(sc1);
% Настройка свойств datatip
set(dt1, 'FontSize', fontsz); % Уменьшение размера шрифта

% % % 
% % % 
% Заполняем матрицу одинаковым элементом
matrixString(:) = "TrueMinimum"; % замените "element" на желаемое 

aa = dataTipTextRow('label',matrixString);
sc.DataTipTemplate.DataTipRows(end+1) = aa;
    
    plot_num = plot_num + 1;
    hold off




    % Specify the Excel file name
filename = 'result.xlsx'; % Replace 'your_excel_file.xlsx' with your actual file name

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

% % 
% % 
% % 
% traektory
hold on
global drawing;
plot3(drawing.x(:,1), drawing.x(:,2), drawing.f(:,1),'Color','k','Marker','.','MarkerSize',20);
hold off
% Write the combined data back to the Excel file
try
    writetable(combinedData, filename, 'Sheet',1); % Writes to the first sheet. Change 'Sheet',1 to specify other sheets if needed.
catch
    error('Error writing the table to Excel file.  Make sure the file is not open in another application.');
end

disp('Table appended successfully!');
clear_drawing();

end

function clear_drawing()
global drawing;
drawing.f = []; % Инициализация массива f
drawing.x = []; % Инициализация массива x
end








