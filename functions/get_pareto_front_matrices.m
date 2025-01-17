function pareto_front = get_pareto_front_matrices(f1, f2)
    % Проверка, что входные матрицы имеют одинаковый размер
    if ~isequal(size(f1), size(f2))
        error('Матрицы f1 и f2 должны иметь одинаковый размер');
    end
    
    % Преобразование матриц в векторы
    f1 = f1(:);  % Превращаем f1 в вектор
    f2 = f2(:);  % Превращаем f2 в вектор
    
    % Количество решений
    n = length(f1);
    
    % Логический вектор для Парето-фронта
    pareto_front = true(n, 1);

    % Поиск Парето-фронта
    for i = 1:n
        for j = 1:n
            % Если решение j доминирует над решением i
            if (f1(j) >= f1(i) && f2(j) <= f2(i)) && (f1(j) > f1(i) || f2(j) < f2(i))
                pareto_front(i) = false;
                break;
            end
        end
    end
    
    % Преобразование результата обратно в форму матрицы
    pareto_front = reshape(pareto_front, size(f1));
end
