function [rowData] = getTableTransistor(filename, rownum)
    % Проверка на существование файла
    if isfile(filename)
        % Чтение данных из Excel файла в виде таблицы
        data = readtable(filename);
        
        % Проверка на корректность номера строки
        if rownum > 0 && rownum <= height(data)
            % Извлечение данных из указанной строки
            rowData = data(rownum, :);
            rowData.Lambda_b = rowData.Lambda_b*1e-6;
            % Возврат полей таблицы
            % Num = rowData.Num;
            % PartName = rowData.PartName{1};
            % Type = rowData.Type{1};
            % GroupKey = rowData.GroupKey; % {1}
            % TechnicalConditions = rowData.TechnicalConditions{1};
            % T_tr_max = rowData.T_tr_max;
            % T_low = rowData.T_low;
            % Lambda_b = rowData.Lambda_b*1e-6;
            % Struct = rowData.Struct;
            % U_max_kb = rowData.U_max_kb;
            % U_max_ke_1 = rowData.U_max_ke_1;
            % U_max_ke_2 = rowData.U_max_ke_2;
            % I_max_k = rowData.I_max_k;
            % h21 = rowData.h21;
            % f_max = rowData.f_max;
            % P_max = rowData.P_max;
            % Pack = rowData.Pack;

        else
            error("Ошибка: Номер строки вне диапазона: "+num2str(rownum));
        end
    else
        error("Файл не найден. Проверьте имя файла и его расположение: "+filename);
    end
end
