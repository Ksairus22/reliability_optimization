function data_parsed = getTableResistorData(filename)
        opts = detectImportOptions(filename, 'PreserveVariableNames', true);
        % Устанавливаем тип всех переменных как 'string'
        opts.VariableTypes(:) = {'string'};
        % Читаем таблицу
        data = readtable(filename, opts);
        data_parsed = data(~ismissing(data{:, 11}), :);
        % writetable(data_parsed, "this","FileType","spreadsheet");
end