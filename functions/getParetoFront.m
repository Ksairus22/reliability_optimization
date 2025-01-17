function paretoFront = getParetoFront(matrix1, matrix2)
    % matrix1 и matrix2 - две матрицы размера 224x80
    [nRows, nCols] = size(matrix1); % Получаем количество строк и столбцов
    
    % Массив для хранения индексов строк, которые принадлежат Парето-фронту
    paretoFrontIndices = false(nRows, 1);
    
    % Проходим по всем строкам и сравниваем каждую строку с другими
    for i = 1:nRows
        isDominated = false;
        
        for j = 1:nRows
            if i ~= j
                % Проверяем, доминирует ли строка j над строкой i
                % Проверка доминирования по всем столбцам
                if all(matrix1(j,:) <= matrix1(i,:) & matrix2(j,:) <= matrix2(i,:)) && ...
                   any(matrix1(j,:) < matrix1(i,:) | matrix2(j,:) < matrix2(i,:))
                    isDominated = true;
                    break;
                end
            end
        end
        
        % Если строка i не доминируется ни одной другой строкой, она на Парето-фронте
        if ~isDominated
            paretoFrontIndices(i) = true;
        end
    end
    
    % Получаем индексы строк, составляющих Парето-фронт
    paretoFront = [matrix1(paretoFrontIndices,:), matrix2(paretoFrontIndices,:)];
end
