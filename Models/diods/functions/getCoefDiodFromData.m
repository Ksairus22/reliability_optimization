function [lambdaB, kPr, kR, kE] = getCoefDiodFromData(Data, rownum, iRelative, t)
    % Проверка на корректность номера строки
    if rownum > 0 && rownum <= height(Data)
        % Извлечение данных из указанной строки
        rowData = Data(rownum, :);
    
        % Возврат полей таблицы
        % num = rowData.num;
        % partName = rowData.partName{1};
        % type = rowData.type{1};
        % groupKey = rowData.groupKey; % {1}
        % technicalConditions = rowData.technicalConditions{1};
        lambdaB = rowData.lambdaB*1e-6;
    else
        error("Ошибка: Номер строки вне диапазона: "+num2str(rownum));
    end
    [lambdaB, kPr, kR, kE] = getCoefDiod(lambdaB, iRelative, t);
end