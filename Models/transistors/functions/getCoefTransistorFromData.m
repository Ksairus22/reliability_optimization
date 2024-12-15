function [CoefStruct] = getCoefTransistorFromData(Data, rownum, TransistorStruct)
    % Проверка на корректность номера строки
    if rownum > 0 && rownum <= height(Data)
        % Извлечение данных из указанной строки
        ParamStruct = Data(rownum, :);
    else
        error("Ошибка: Номер строки вне диапазона: "+num2str(rownum));
    end
    [CoefStruct] = getCoefTransistor(ParamStruct, TransistorStruct);
end