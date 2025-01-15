function save_all_figures(folderName, format)
    % SAVE_ALL_FIGURES Сохраняет все открытые фигуры в указанный формат
    % в подкаталог 'statfigures'.
    %
    %   save_all_figures(format) сохраняет все открытые фигуры в 
    %   указанном формате (например, 'png', 'jpg', 'fig' и т.д.) 
    %   в подкаталоге 'statfigures'. Если формат не указан, 
    %   используется 'png' по умолчанию.

    if nargin < 2
        format = 'png'; % Формат по умолчанию
    end
    
    % Проверяем, существует ли подкаталог, если нет - создаем его
    
    if ~exist(folderName, 'dir')
        mkdir(folderName);
    end
    
    % Получаем все открытые фигуры
    figures = findobj('Type', 'figure');

    % Проверяем, есть ли открытые фигуры
    if isempty(figures)
        disp('Нет открытых фигур для сохранения.');
        return;
    end

    % Сохраняем каждую фигуру в указанный подкаталог
    for i = 1:length(figures)
        % Устанавливаем текущую фигуру
        figure(figures(i));

        % Создаем имя для файла
        filename = sprintf('figure_%d.%s', figures(i).Number, format);
        
        % Полный путь к файлу
        fullPath = fullfile(folderName, filename);
        
        % Сохраняем фигуру в файл в указанном формате
        saveas(figures(i), fullPath);
    end
    
    fprintf('Все фигуры сохранены в формате %s в папке "%s".\n', format, folderName);
end
