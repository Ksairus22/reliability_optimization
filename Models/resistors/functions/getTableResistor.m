function output_struct = getTableResistor(data, rownum)
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
    output_struct.A = str2double((data_rownumed.A));
    output_struct.B = str2double((data_rownumed.B));
    output_struct.Nt = str2double((data_rownumed.Nt));
    output_struct.G = str2double((data_rownumed.G));
    output_struct.Ns = str2double((data_rownumed.Ns));
    output_struct.J = str2double((data_rownumed.J));
    output_struct.H = str2double((data_rownumed.H));
    % output_struct.lbsg = str2double(table2array(data_rownumed(1,12)));
    % output_struct.lxsg = str2double(table2array(data_rownumed(1,13)));
    output_struct.kpr = str2double((data_rownumed.kpr));
    output_struct.lb = str2double((data_rownumed.lb));
    output_struct.cond_kr = (data_rownumed.cond_kr);
    output_struct.kr = (data_rownumed.kr);
    output_struct.ke = str2double((data_rownumed.ke));
    output_struct.Group = str2double((data_rownumed.Group));
    output_struct.pnom= str2double((data_rownumed.pnom));
  end