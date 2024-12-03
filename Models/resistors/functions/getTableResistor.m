function output_struct = getTableResiistor(data, rownum)
    output_struct = {};
        
        % Проверка на корректность номера строки
        if rownum > 0 && rownum <= height(data)
            % Извлечение данных из указанной строки
            rowData = data(rownum, :);
            
    % Возврат полей таблицы
    data_parsed = data(~ismissing(data{:, 11}), :);

    data_rownumed = data_parsed(rownum,:);
    output_struct.data_rownumed = data_rownumed;
    % Извлекаем коэффициенты
    output_struct.A = str2double(table2array(data_rownumed(1,5)));
    output_struct.B = str2double(table2array(data_rownumed(1,6)));
    output_struct.Nt = str2double(table2array(data_rownumed(1,7)));
    output_struct.G = str2double(table2array(data_rownumed(1,8)));
    output_struct.Ns = str2double(table2array(data_rownumed(1,9)));
    output_struct.J = str2double(table2array(data_rownumed(1,10)));
    output_struct.H = str2double(table2array(data_rownumed(1,11)));
    % output_struct.lbsg = str2double(table2array(data_rownumed(1,12)));
    % output_struct.lxsg = str2double(table2array(data_rownumed(1,13)));
    output_struct.kpr = str2double(table2array(data_rownumed(1,14)));
    output_struct.lb = str2double(table2array(data_rownumed(1,15)));
    output_struct.cond_kr = table2array(data_rownumed(1,16));
    output_struct.kr = table2array(data_rownumed(1,17));
    output_struct.ke = str2double(table2array(data_rownumed(1,18)));
    output_struct.Group = str2double(table2array(data_rownumed(1,2)));
  end