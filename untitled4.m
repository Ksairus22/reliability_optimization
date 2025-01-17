clc;clear;close all;
% Пример данных
N = 100;
f1 = 1:N;  % Значения первой функции
f2 = rand([1,N]);  % Значения второй функции

% for i = 1:length(f1)
%     if(f1(i)>i/length(f1))
%         f1(i) = i/length(f1);
%     end
% end
for i = 1:length(f2)
    if(f2(i)<(length(f2)-i)/length(f2))
        f2(i) = (length(f2)-i)/length(f2);
    end
end

% Получение Парето-фронта
pareto_front = get_pareto_front(f1, f2);

% Вывод индексов решений, которые принадлежат Парето-фронту
disp('Решения, входящие в Парето-фронт:');
disp(find(pareto_front));

% Для визуализации Парето-фронта
figure;
plot(f1, f2, 'o'); % Все решения
hold on;
plot(f1(pareto_front), f2(pareto_front), 'ro'); % Решения, входящие в Парето-фронт
xlabel('f1');
ylabel('f2');
legend('Все решения', 'Парето-фронт');

function pareto_front = get_pareto_front(f1, f2)
    % Проверка на одинаковую длину векторов
    if length(f1) ~= length(f2)
        error('Векторы f1 и f2 должны иметь одинаковую длину');
    end
    
    n = length(f1);  % Количество решений
    pareto_front = logical(ones(n, 1));  % Изначально все решения считаются частью Парето-фронта

    for i = 1:n
        for j = 1:n
            % Если решение j доминирует над решением i (по обеим функциям)
            if (f1(j) <= f1(i) && f2(j) <= f2(i)) && (f1(j) < f1(i) || f2(j) < f2(i))
                pareto_front(i) = false;
                break;
            end
        end
    end
end
