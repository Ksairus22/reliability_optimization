function [Data] = getTableTransistorData(filename)
    % Проверка на существование файла
    % if isfile(filename)
        % Чтение данных из Excel файла в виде таблицы
        Data = readtable(filename);
        Data.Lambda_b = Data.Lambda_b*1e-6;
    % else
    %     error("Файл не найден. Проверьте имя файла и его расположение: "+filename);
    % end
end