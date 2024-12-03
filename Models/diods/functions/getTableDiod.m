function [num, partName, type, groupKey, technicalConditions, lambdaB] = getTableDiod(filename, rownum)
    % Проверка на существование файла
    if isfile(filename)
        % Чтение данных из Excel файла в виде таблицы
        data = readtable(filename);
        
        % Проверка на корректность номера строки
        if rownum > 0 && rownum <= height(data)
            % Извлечение данных из указанной строки
            rowData = data(rownum, :);
            
            % Возврат полей таблицы
            num = rowData.num;
            partName = rowData.partName{1};
            type = rowData.type{1};
            groupKey = rowData.groupKey; % {1}
            technicalConditions = rowData.technicalConditions{1};
            lambdaB = (rowData.lambdaB)*1e6;
        else
            error("Ошибка: Номер строки вне диапазона: "+num2str(rownum));
        end
    else
        error("Файл не найден. Проверьте имя файла и его расположение: "+filename);
    end
end
