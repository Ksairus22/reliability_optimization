function [output] = putUnoContTable(resistance_b_range,resistance_be_range)
    % Создаем сетку значений
    [ResistanceBEGrid, ResistanceBGrid] = meshgrid(resistance_be_range, resistance_b_range);
    
    % Предварительно создаем матрицу для хранения результатов
    lambda_surface = zeros(size(ResistanceBEGrid));
    
    % Вычисляем lambda для каждой комбинации
    for i = 1:size(ResistanceBEGrid, 1)
        for j = 1:size(ResistanceBEGrid, 2)
            [VarSystem] = getVarSystemVariable(VarSystem.IteratorCapacitor, VarSystem.IteratorDiod, VarSystem.IteratorResistor_B, VarSystem.IteratorResistor_BE,...
        VarSystem.IteratorResistor_E, VarSystem.IteratorTransistor, VarSystem.t, VarSystem.capacity,...
        ResistanceBGrid(i, j),ResistanceBEGrid(i, j), VarSystem.resistance_E, VarSystem.goalfreq)
            lambda_surface(i, j) = getReliabilitySystemFromData(DataSystem, VarSystem);
        end
    end
    save("lambda1","lambda_surface");
    output = 1;
    disp("Save lambda1 for UnoCont is success")
end