function [K_c, K_r] = getCoefCapacitor(data, rownum, capacity, U_ratio, t, capacitor_struct)
    % Проверка корректности индекса
    if rownum < 1 || rownum > height(data)
        error('Индекс вне диапазона! Пожалуйста, укажите корректный номер изделия.');
    end

        data_parsed = data(~ismissing(data{:, 11}), :);
        data_indexed = data_parsed(rownum,:);

        K_c = getCoefCapacitor_kC(capacity,data_indexed);
        K_r = getCoefCapacitor_kR(capacitor_struct, t, U_ratio);
end
