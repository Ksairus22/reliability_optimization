function isInRange = checkRange(value, reference, percent)
    % checkRange проверяет, находится ли значение в диапазоне ±50% от эталонного значения.
    % value - число, которое нужно проверить
    % reference - эталонное значение
    
    % Вычисляем пределы диапазона
    lowerBound = reference * (1-percent/100); % нижний предел (50% от эталона)
    upperBound = reference * (1+percent/100); % верхний предел (150% от эталона)
    
    % Проверяем, находится ли value в диапазоне
    isInRange = (value >= lowerBound) && (value <= upperBound);
end
