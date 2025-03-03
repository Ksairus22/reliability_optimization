function  output_struct = getTableCapacitor(data, rownum)
% [L_bcg,L_b,K_pr,K_z,K_x,K_e,dT,A,B,Nt,Ns,H]
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
    output_struct.L_bcg = str2double((data_rownumed.Lambda_bsg));
    output_struct.L_b = str2double((data_rownumed.Lambda_b));
    output_struct.K_pr = str2double((data_rownumed.K_pr));
    output_struct.K_z = str2double((data_rownumed.K_z));
    output_struct.K_x = str2double((data_rownumed.K_x));
    output_struct.K_e = str2double((data_rownumed.K_e));
    output_struct.unom = str2double((data_rownumed.unom));

    dT_from_db = data_rownumed(1,12);    
    dT_char_arr=string(table2array(dT_from_db)); 
    dT_arr = strrep(strsplit(dT_char_arr, ';'), [' '], ['']);
    
    % Инициализация dT
    dT = [];
    
    % Проверяем количество полученных элементов
    if numel(dT_arr) > 1
        dT1 = strsplit(dT_arr(1), ',');
        dT2 = strsplit(dT_arr(2), ',');    
        dT = str2double([dT1; dT2]);
    elseif numel(dT_arr) == 1
        % Обрабатываем случай, когда только один элемент
        dT1 = strsplit(dT_arr{1}, ',');
        dT = str2double(dT1);
    end
    output_struct.dT = dT;

    A_from_db = data_rownumed.A;
    A_char_arr=string((A_from_db)); 
    A_arr = strrep(strrep(strsplit(A_char_arr,';'),[' '],['']),',','.');
    A = str2double(A_arr);
    output_struct.A = A;

    B_from_db = data_rownumed.B;
    B_char_arr=string((B_from_db)); 
    B_arr = strrep(strrep(strsplit(B_char_arr,';'),[' '],['']),',','.');
    B = str2double(B_arr);
    output_struct.B = B;

    Nt_from_db = data_rownumed.Nt;
    Nt_char_arr=string((Nt_from_db)); 
    Nt_arr = strrep(strrep(strsplit(Nt_char_arr,';'),[' '],['']),',','.');
    Nt = str2double(Nt_arr);
    output_struct.Nt = Nt;

    G_from_db = data_rownumed.G;
    G_char_arr=string((G_from_db)); 
    G_arr = strrep(strrep(strsplit(G_char_arr,';'),[' '],['']),',','.');
    G = str2double(G_arr);
    output_struct.G = G;

    Ns_from_db = data_rownumed.Ns;
    Ns_char_arr=string((Ns_from_db)); 
    Ns_arr = strrep(strrep(strsplit(Ns_char_arr,';'),[' '],['']),',','.');
    Ns = str2double(Ns_arr);
    output_struct.Ns = Ns;

    H_from_db = data_rownumed.H;
    H_char_arr=string((H_from_db)); 
    H_arr = strrep(strrep(strsplit(H_char_arr,';'),[' '],['']),',','.');
    H = str2double(H_arr);
    output_struct.H = H;
    
    output_struct.Group = (data_rownumed.("Ключ группы изделий"));

        else
            error("Ошибка: Номер строки вне диапазона: "+num2str(rownum));
        end

end