function [resultA, resultB] = removeRowsWithNaN(inputMatrixA, inputMatrixB)
    % Функция удаляет строки из обеих матриц, в которых есть хотя бы одно NaN
    % Входные данные:
    % - inputMatrixA: матрица размером 70x2
    % - inputMatrixB: матрица размером 70x7
    % Выходные данные:
    % - resultA: обновленная матрица A без строк с NaN
    % - resultB: обновленная матрица B без строк с NaN

    % Проверка на корректность входных аргументов
    if size(inputMatrixA, 2) ~= 2 || size(inputMatrixB, 2) ~= 7
        error('Matrix A должна быть размером 70x2, а матрица B размером 70x7.');
    end

    % Логический вектор, определяющий строки, в которых нет NaN в первой матрице
    validRowsA = all(~isnan(inputMatrixA), 2);
    
    % Логический вектор, определяющий строки, в которых нет NaN во второй матрице
    validRowsB = all(~isnan(inputMatrixB), 2);

    % Пересечение логических векторов, чтобы найти строки, которые есть в обеих матрицах
    validRows = validRowsA & validRowsB;

    % Формирование новых матриц, исключая строки с NaN
    resultA = inputMatrixA(validRows, :);
    resultB = inputMatrixB(validRows, :);
end
