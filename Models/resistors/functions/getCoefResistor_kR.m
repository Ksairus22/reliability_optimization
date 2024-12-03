function K_R = getCoefResistor_kR(resistance, Resistor_struct)
    conditions_str = Resistor_struct.cond_kr;
    coefficients_str = Resistor_struct.kr;
    % Разделяем условия и коэффициенты на составляющие
    conditions = strsplit(conditions_str, ';');
    coefficients = strsplit(coefficients_str, ';');
    coefficients = strrep(coefficients,',','.');
    
    % Инициализируем коэффициент по умолчанию
    K_R = NaN;
    % Проходим по всем условиям
    for i = 1:length(conditions)
        condition = strsplit(strtrim(conditions{i}), ',');
        condition = strtrim(condition);
        % Проверяем, удовлетворяет ли сопротивление текущему условию
        is_valid = 0;
        
        for j = 1:length(condition)
            if startsWith(condition{j}, '<=')
                limit = str2double(strrep(condition{j}, '<=', ''));
                if resistance <= limit
                    is_valid = is_valid + 1;
                    % break;
                end
            elseif startsWith(condition{j}, '>=')
                limit = str2double(strrep(condition{j}, '>=', ''));
                if resistance >= limit
                    is_valid = is_valid + 1;
                    % break;
                end
            elseif startsWith(condition{j}, '<')
                limit = str2double(strrep(condition{j}, '<', ''));
                if resistance < limit
                    is_valid = is_valid + 1;
                    % break;
                end
            elseif startsWith(condition{j}, '>')
                limit = str2double(strrep(condition{j}, '>', ''));
                if resistance > limit
                    is_valid = is_valid + 1;
                    % break;
                end
            end
        end
                % Если текущий набор условий выполнен, получаем соответствующий коэффициент
        if is_valid == length(condition)
            K_R = str2num(coefficients(i));
            return; % Прекращаем выполнение после нахождения первого подходящего коэффициента
        else
            K_R = NaN;
            % disp('Сопротивление не соответствует ни одному набору условий.');
        end

    end
    
    
end

