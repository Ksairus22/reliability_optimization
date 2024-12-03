function [lambdaB, kPr, kR, kF, kS1, kE] = getCoefTransistorFromData(Data, rownum, pRelative, t, s1)
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
        tTrMax = rowData.tTrMax;
        tLow = rowData.tLow;
        lambdaB = (rowData.lambdaB)*1e-6;
    else
        error("Ошибка: Номер строки вне диапазона: "+num2str(rownum));
    end
    [lambdaB, kPr, kR, kF, kS1, kE] = getCoefTransistor(tTrMax, tLow, lambdaB, pRelative, t, s1);
end