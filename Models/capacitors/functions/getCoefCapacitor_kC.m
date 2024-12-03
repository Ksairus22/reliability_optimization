function [K_c] = getCoefCapacitor_kC(capacity,data_indexed)
    
    K_c_from_db = [data_indexed(1,19) data_indexed(1,20) data_indexed(1,21)];
    K_c_char_arr = table2array(K_c_from_db);
    K_c_arr = str2double(K_c_char_arr);
    a = str2double(table2array(data_indexed(1,2)));
    if (a == 4) || (a == 5) ||...
            (a == 6) || (a == 7)
        K_c = K_c_arr(1)*(capacity*1e-6)^K_c_arr(2);
    else
        K_c = K_c_arr(1)*(capacity)^K_c_arr(2);
    end
end