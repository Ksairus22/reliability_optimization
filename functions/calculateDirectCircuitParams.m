function params = calculateDirectCircuitParams(inputStruct)
    % Извлечение параметров из входной структуры
    Re = inputStruct.Re;
    Rbe = inputStruct.Rbe;
    Rb = inputStruct.Rb;
    beta = inputStruct.beta;
    f = inputStruct.f;
    Us = inputStruct.Us;
    Ube = inputStruct.Ube;

    % Непосредственные вычисления
    % Эти уравнения вычисляются с помощью полной параллельной цепи
    % Определим r1 и r2 так, чтобы не использовать символические переменные
    % Предполагаем, что будем использовать Rb и Rbe для расчетов
    
    R1 = Rb; % заменяем r1
    R2 = Rbe; % заменяем r2

    I_total = Us / (R1 + R2); % Ток в цепи исходя из закона Ома
    I_Rb = I_total; % Ток через Rb
    I_Re = -(7 * R1 - 113 * R2) / (10 * Re * (R1 + R2)); % Предполагаемое вычисление тока через Re

    % Вычисляем напряжения и мощности
    Ub = I_Rb * Rb;
    % Ue = I_Re * Re;

    Rin_func = Re * beta; % Входное сопротивление
    C1 = 100 / (f * Rin_func); % Явное использование T = 1 / f

    Pb = Ub^2 / Rb;
    Pbe = (Us - Ub)^2 / Rbe;
    
    
    Ik = I_Re; % Ток, который мы вычислили
    
    Ub = I_Rb * R2;
    Ue = Ub - Ube;
    Ie = Ue / Re;
    Ik = Ie;
    Ib = Ik / beta;
    Pe = Ue^2 / Re;
    % Создание выходной структуры
    outputStruct = struct('Ue', Ue, ...
                          'Re', Re, ...
                          'Ub', Ub, ...
                          'Rbe', Rbe, ...
                          'Rb', Rb, ...
                          'Rin_func', Rin_func, ...
                          'C1', C1, ...
                          'Pb', Pb, ...
                          'Pbe', Pbe, ...
                          'Pe', Pe);
    
    % Создание подструктур
    Rb_struct = struct('U', Ub, 'P', Pb, 'R', Rb);
    Re_struct = struct('U', Ue, 'P', Pe, 'R', Re);
    Rbe_struct = struct('U', (Us - Ub), 'P', Pbe, 'R', Rbe);
    C1_struct = struct('U', Ub, 'C', C1);
    
    VT_struct = struct(...
        'Ube', Ube, ...
        'Uke', Us - Ue, ...
        'Ukb', Us - Ub, ...
        'Pke', Ik * (Us - Ue), ...
        'P', Ik * (Us - Ue), ...
        'U', Us - Ue, ...
        'I', Ik, ...
        't', inputStruct.t);

    % Создание главной структуры с входными и выходными подструктурами
    params = struct('Input', inputStruct, ...
                    'Output', outputStruct, ...
                    'Rb', Rb_struct, ...
                    'Re', Re_struct, ...
                    'Rbe', Rbe_struct, ...
                    'C1', C1_struct, ...
                    'VT', VT_struct);
end
