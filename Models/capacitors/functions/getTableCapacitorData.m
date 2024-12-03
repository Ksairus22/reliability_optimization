function data_parsed = getTableCapacitorData(filename)
        opts = detectImportOptions(filename, 'PreserveVariableNames', true);
        % Устанавливаем тип всех переменных как 'string'
        opts.VariableTypes(:) = {'string'};
        % Читаем таблицу
        data = readtable(filename, opts);
        data_parsed = data(~ismissing(data{:, 11}), :);
        % writetable(data_parsed, "this","FileType","spreadsheet");
end