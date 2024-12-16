clc; clear; close all;
%% startup
% Определение 10 различных цветов
newColors = [
    0.1, 0.2, 0.5;   % Цвет 1
    0.9, 0.1, 0.1;   % Цвет 2
    0.1, 0.9, 0.1;   % Цвет 3
    0.5, 0.5, 0.1;   % Цвет 4
    0.1, 0.5, 0.5;   % Цвет 5
    0.8, 0.5, 0.2;   % Цвет 6
    0.2, 0.8, 0.8;   % Цвет 7
    0.5, 0.2, 0.8;   % Цвет 8
    0.9, 0.8, 0.1;   % Цвет 9
    0.2, 0.7, 0.5    % Цвет 10
];

% Установка новых цветов по умолчанию
set(groot, 'defaultAxesColorOrder', newColors);


%% Includes
addpath("functions\");
addpath("Models\");
addpath("Models\capacitors\");
addpath("Models\capacitors\functions\");
addpath("Models\diods\");
addpath("Models\diods\functions\");
addpath("Models\resistors\");
addpath("Models\resistors\functions\");
addpath("Models\transistors\")  
addpath("Models\transistors\functions\");

%% 
FilenameSystem.Capacitors = 'table_reliability_capacitor.xlsx';
FilenameSystem.Diods = 'table_reliability_diod.xlsx';
FilenameSystem.Resistors = 'table_reliability_resistor.xlsx';
FilenameSystem.Transistors = 'table_reliability_transistor.xlsx';

%%
[DataSystem] = getTableSystemData(FilenameSystem);

VarSystem.IteratorCapacitor   = 1;
VarSystem.IteratorDiod        = 1;
VarSystem.IteratorResistor_B  = 1;
VarSystem.IteratorResistor_K  = 1;
VarSystem.IteratorTransistor  = 1;
VarSystem.t   = 30;
VarSystem.capacity    = 1000e-12;
VarSystem.U_ratio     = 1/2;
VarSystem.iRelative   = 1/2;
VarSystem.power_b     = 0.5;
VarSystem.resistance_b= 200;
VarSystem.P_ratio_b   = 1/2;
VarSystem.power_k     = 0.5;
VarSystem.resistance_k = 200;
VarSystem.P_ratio_k   = 1/2;
VarSystem.pRelative   = 1/2;
VarSystem.s1  = 1/2;
VarSystem.goalfreq  = 1000;
% 
Resistor_struct = getTableResistor(DataSystem.Resistor, VarSystem.IteratorResistor_B);
%% K_p
    % Resistor_struct = getTableResistor(DataSystem.Resistor, VarSystem.IteratorResistor_B);
    % % get coef ->
    % t=25:1:85;
    % P_ratio=0.1:0.1:1;
    % for k = 1:length(P_ratio)
    %     point(k).P_ratio(k)=P_ratio(k);
    %     for i = 1:length(t)
    %         [K_p, K_R, K_m, K_stab] = getCoefResistor(VarSystem.power_b, VarSystem.resistance_b, P_ratio(k), t(i), Resistor_struct);
    % 
    %         point(k).t(i)=t(i);
    %         point(k).K_p(i)=K_p;
    %         point(k).K_R(i)=K_R;
    %         point(k).K_m(i)=K_m;
    %         point(k).K_stab(i)=K_stab;
    %     end
    % end
    % figure
    % for k = 1:length(P_ratio)
    %     plot(point(k).t,point(k).K_p)
    %     hold on
    % end
    % 
    % figure
    % [X,Y] = meshgrid(t,P_ratio);
    % for k = 1:length(P_ratio)
    %     Z(k,:) = point(k).K_p; 
    % end
    % surf(X,Y,Z,'EdgeColor','none')
    % colorbar
    % colormap('cool')
    % xlabel('T, ℃')
    % ylabel('P/P_н')
    % zlabel('K_p')
    % hold on
    % fimplicit3(@(x1,x2,K_p) K_p-1,[t(1) t(end) P_ratio(1) P_ratio(end) min(min(Z)) max(max(Z))],'FaceAlpha',0.1,'EdgeColor','r')
    % legend('K_p(T,P/P_н)','K_p = 1')
%% K_R
% figure;
% 
% R = [0:10:2000 2000:1000:2e6]; % Резисторы
% point = struct(); % Инициализация структуры
% 
% % Получаем коэффициенты для каждого R
% for i = 1:length(R)
%     [K_p, K_R, K_m, K_stab] = getCoefResistor(VarSystem.power_b, R(i), VarSystem.P_ratio_b, VarSystem.t, Resistor_struct);
% 
%     point(i).R = R(i);
%     point(i).K_p = K_p;
%     point(i).K_R = K_R;
%     point(i).K_m = K_m;
%     point(i).K_stab = K_stab;
% end
% 
% % Вытаскиваем K_R для всех точек
% K_R_values = [point.K_R];
% 
% % Строим график
% semilogx(R, K_R_values, 'LineWidth', 2, 'Color', 'k'); % Синяя линия
% grid on; % Включаем сетку
% 
% % Добавляем заголовок и подписи
% title('Зависимость K_R от R', 'FontSize', 14);
% xlabel('Сопротивление R (Ом)', 'FontSize', 12);
% ylabel('Коэффициент K_R', 'FontSize', 12);
% 
% % Добавляем легенду
% legend('K_R', 'Location', 'Best');
% 
% % Настройка осей
% xlim([min(R) max(R)]);
% ylim([min(K_R_values) max(K_R_values)]);
% 
% % Дополнительные настройки
% set(gca, 'FontSize', 12); % Установка размера шрифта
%% K_M
% figure;
% 
% power= 0.1:0.01:3; % Резисторы
% point = struct(); % Инициализация структуры
% 
% % Получаем коэффициенты для каждого R
% for i = 1:length(power)
%     [K_p, K_R, K_m, K_stab] = getCoefResistor(power(i), VarSystem.resistance_b, VarSystem.P_ratio_b, VarSystem.t, Resistor_struct);
% 
%     point(i).power = power(i);
%     point(i).K_p = K_p;
%     point(i).K_R = K_R;
%     point(i).K_m = K_m;
%     point(i).K_stab = K_stab;
% end
% 
% % Вытаскиваем K_R для всех точек
% K_m_values = [point.K_m];
% 
% % Строим график
% plot(power, K_m_values, 'LineWidth', 2, 'Color', 'k'); % Синяя линия
% grid on; % Включаем сетку
% 
% % Добавляем заголовок и подписи
% title('Зависимость K_M от P', 'FontSize', 14);
% xlabel('P, Вт', 'FontSize', 12);
% ylabel('Коэффициент K_M', 'FontSize', 12);
% 
% % Добавляем легенду
% legend('K_M', 'Location', 'Best');
% 
% % Настройка осей
% xlim([min(power) max(power)]);
% ylim([min(K_m_values) max(K_m_values)]);
% 
% % Дополнительные настройки
% set(gca, 'FontSize', 12); % Установка размера шрифта
%% lambda1
% figure;
% 
% t=25:1:85;
% point = struct(); % Инициализация структуры
% 
% % Получаем коэффициенты для каждого R
% for i = 1:length(t)
%     lambda = getReliabilityResistorFromData(DataSystem.Resistor, VarSystem.IteratorResistor_B, VarSystem.power_b, VarSystem.resistance_b, VarSystem.iRelative, t(i));
% 
        % point.t(i)= t(i);
        % point.lambda(i) = lambda;
% end
% 
% % Вытаскиваем K_R для всех точек
% lambda = [point.lambda];
% 
% % Строим график
% plot(t, lambda, 'LineWidth', 2, 'Color', 'k'); % Синяя линия
% grid on; % Включаем сетку
% 
% % Добавляем заголовок и подписи
% title('Зависимость \lambda_э от t', 'FontSize', 14);
% xlabel('T, ℃', 'FontSize', 12);
% ylabel('\lambda_э', 'FontSize', 12);
% 
% % Добавляем легенду
% legend('\lambda_э', 'Location', 'Best');
% 
% % Настройка осей
% xlim([min(t) max(t)]);
% ylim([min(lambda) max(lambda)]);
% 
% % Дополнительные настройки
% set(gca, 'FontSize', 12); % Установка размера шрифта
%% lambda2
figure;

point = struct(); % Инициализация структуры
t=25:1:85;
P_ratio=0.1:0.1:1;
% leg_cell = [];
Resistor_struct = getTableResistor(DataSystem.Resistor, VarSystem.IteratorResistor_B);
for k = 1:length(P_ratio)
% Получаем коэффициенты для каждого R
    for i = 1:length(t)
        lambda = getReliabilityResistorFromData(DataSystem.Resistor, VarSystem.IteratorResistor_B, VarSystem.power_b, VarSystem.resistance_b, P_ratio(k), t(i));
        
        point(k).t(i)= t(i);
        point(k).lambda(i) = lambda;
        leg_cell(k) = {"P/P_н = " + num2str(P_ratio(k))};
    end
end

% Вытаскиваем K_R для всех точек
% lambda = [point.lambda];

% Строим график
    % figure
    for k = 1:length(P_ratio)
        plot(point(k).t,point(k).lambda, 'LineWidth', 2)
        hold on
    end
grid on; % Включаем сетку

% Добавляем заголовок и подписи
title('Зависимость \lambda_э от t', 'FontSize', 14);
xlabel('T, ℃', 'FontSize', 12);
ylabel('\lambda_э', 'FontSize', 12);

% % Добавляем легенду
% legend('\lambda_э');
legend(leg_cell, 'Location', 'Best')

% Настройка осей
xlim([min(t) max(t)]);
% ylim([min(lambda) max(lambda)]);

% Дополнительные настройки
set(gca, 'FontSize', 12); % Установка размера шрифта
% 
% 
% 


    figure
    [X,Y] = meshgrid(t,P_ratio);
    for k = 1:length(P_ratio)
        Z(k,:) = point(k).lambda; 
    end
    surf(X,Y,Z,'EdgeColor','none')
    colorbar
    colormap('cool')
    xlabel('T, ℃')
    ylabel('P/P_н')
    zlabel('lambda')
    % hold on
    % fimplicit3(@(x1,x2,lambda) lambda-1,[t(1) t(end) P_ratio(1) P_ratio(end) min(min(Z)) max(max(Z))],'FaceAlpha',0.1,'EdgeColor','r')
    % legend('lambda(T,P/P_н)','lambda = 1')
    legend('lambda(T,P/P_н)')
    %% lambda3
figure(1);

point = struct(); % Инициализация структуры
t=25:1:85;
P_ratio=0.1:0.1:1;
% leg_cell = [];

Resistor_struct = getTableResistor(DataSystem.Resistor, VarSystem.IteratorResistor_B);
for k = 1:length(P_ratio)
% Получаем коэффициенты для каждого R
    for i = 1:length(t)
        lambda = getReliabilityResistor(Resistor_struct, 1, 1, 1, 1);
        
        point(k).t(i)= t(i);
        point(k).lambda(i) = lambda;
        leg_cell(k) = {"P/P_н = " + num2str(P_ratio(k))};
    end
end

% Вытаскиваем K_R для всех точек
% lambda = [point.lambda];

% Строим график
    % figure
    % for k = 1:length(P_ratio)
        plot(point(1).t,point(1).lambda, 'LineWidth', 2,'LineStyle','--','Color','r')
        hold on
    % end
grid on; % Включаем сетку

% Добавляем заголовок и подписи
title('Зависимость \lambda_э от t', 'FontSize', 14);
xlabel('T, ℃', 'FontSize', 12);
ylabel('\lambda_э', 'FontSize', 12);

% % Добавляем легенду
% legend('\lambda_э');
% legend(leg_cell, 'Location', 'Best')

% Настройка осей
xlim([min(t) max(t)]);
% ylim([min(lambda) max(lambda)]);

% Дополнительные настройки
set(gca, 'FontSize', 12); % Установка размера шрифта
% 
% 
% 
legend([leg_cell,{"\lambda_э = \lambda_b^'"}], 'Location', 'Best')

    figure
    [X,Y] = meshgrid(t,P_ratio);
    for k = 1:length(P_ratio)
        Z(k,:) = point(k).lambda; 
    end
    surf(X,Y,Z,'EdgeColor','none')
    colorbar
    colormap('cool')
    xlabel('T, ℃')
    ylabel('P/P_н')
    zlabel('lambda')
    % hold on
    % fimplicit3(@(x1,x2,lambda) lambda-1,[t(1) t(end) P_ratio(1) P_ratio(end) min(min(Z)) max(max(Z))],'FaceAlpha',0.1,'EdgeColor','r')
    % legend('lambda(T,P/P_н)','lambda = 1')
    legend('lambda(T,P/P_н)')