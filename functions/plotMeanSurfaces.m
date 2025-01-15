function plotMeanSurfaces(fval, x0_vecX, x0_vecY, minValue, maxValue, numOpts)
    % plotMeanSurfaces - Функция для визуализации средних значений
    %
    % Синтаксис: plotMeanSurfaces(fval, x0_vecX, x0_vecY, minValue, numOpts)
    %
    % Входные параметры:
    %   fval - массив значений для усреднения
    %   x0_vecX - вектор значений по оси X
    %   x0_vecY - вектор значений по оси Y
    %   minValue - минимальное значение для цветовой шкалы
    %   numOpts - количество статистических данных для отображения в легенде
    
    f_mean = mean(fval, 4);
    method_name = {"Multistart", "Globalsearch", "Genetic", "PatternSearch", "Simulated Annealing", "Surrogate"};
    
    % Ширина и высота каждой фигуры
    mul = 1;
    figWidth = mul*300;
    figHeight = mul*200;

    % Расстояние между фигурами
    margin = 0;

    % Создание сетки для координат X и Y
    [x0_matX, x0_matY] = meshgrid(x0_vecX, x0_vecY);
    
    for i = 1:size(f_mean, 1)
        f_mat = squeeze(f_mean(i,:,:));
        
        % Вычисление позиции для каждой фигуры
        xPos = mod(i-1, 2) * (figWidth + margin); % Две фигуры в ряд
        yPos = floor((i-1) / 2) * (figHeight + margin) + 50; % Позиция по высоте
        
        % Создание фигуры с заданной позицией
        figure('Position', [xPos, yPos, figWidth, figHeight]);
        % surf(x0_matX, x0_matY, f_mat);
        interpolateSurface(x0_matX, x0_matY, f_mat);
        grid on;
        
        % Настройка графика
        caxis([minValue maxValue]);
        colorbar; % Показать цветовую шкалу
        xlabel('X-axis'); % Подпись оси X
        ylabel('Y-axis'); % Подпись оси Y
        zlabel('Z-axis'); % Подпись оси Z
        view(2); % Вид сверху
        axis tight; % Подгоняем оси под данные
        title(method_name{i});
        legend("Stat count = " + num2str(numOpts));
    end
end


function interpolateSurface(x0_matX, x0_matY, f_mat)
    % Преобразуем x0_matX и x0_matY в одномерные векторы, если они не таковыми являются 
    if ismatrix(x0_matX) && size(x0_matX, 2) > 1 
        x0_matX = x0_matX(:); 
    end 

    if ismatrix(x0_matY) && size(x0_matY, 2) > 1 
        x0_matY = x0_matY(:); 
    end 

    % Проверяем, что x0_matX и x0_matY имеют одинаковую длину 
    if length(x0_matX) ~= length(x0_matY) 
        error('Длины x0_matX и x0_matY должны быть одинаковыми.'); 
    end 

    % Создаем сетку для интерполяции 
    [xq, yq] = meshgrid(linspace(min(x0_matX), max(x0_matX), 100), linspace(min(x0_matY), max(x0_matY), 100)); 

    % Интерполируем значения функции f_mat 
    % Убедитесь, что f_mat - это вектор, который соответствует x0_matX и x0_matY. 
    fq = griddata(x0_matX, x0_matY, f_mat(:), xq, yq, 'cubic');  

    % Создаем график 
    surf(xq, yq, fq, 'EdgeColor', 'None', 'FaceColor', 'interp');
    xlabel('X-axis');
    ylabel('Y-axis');
    zlabel('Function Value');
    title('Interpolated Surface Plot');
    colorbar; % Добавляет цветовую шкалу
end
