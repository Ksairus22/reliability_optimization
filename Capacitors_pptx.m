clc; clear; close all;

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
VarSystem.IteratorResistor_B  = 20;
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
Capacitor_struct = getTableCapacitor(DataSystem.Capacitor, VarSystem.IteratorCapacitor);
%% K_p
    % Capacitor_struct = getTableCapacitor(DataSystem.Capacitor, VarSystem.IteratorCapacitor);
    % % get coef ->
    % t=25:1:85;
    % U_ratio=0.1:0.1:1;
    % for k = 1:length(U_ratio)
    %     point(k).U_ratio(k)=U_ratio(k);
    %     for i = 1:length(t)
    %         [K_c, K_p] = getCoefCapacitor(DataSystem.Capacitor, VarSystem.IteratorCapacitor, VarSystem.capacity, U_ratio(k), t(i), Capacitor_struct);
    % 
    %         point(k).t(i)=t(i);
    %         point(k).K_p(i)=K_p;
    %         point(k).K_c(i)=K_c;
    %     end
    % end
    % figure
    % for k = 1:length(U_ratio)
    %     plot(point(k).t,point(k).K_p)
    %     hold on
    % end
    % 
    % figure
    % [X,Y] = meshgrid(t,U_ratio);
    % for k = 1:length(U_ratio)
    %     Z(k,:) = point(k).K_p; 
    % end
    % surf(X,Y,Z,'EdgeColor','none')
    % colorbar
    % colormap('cool')
    % xlabel('T, ℃')
    % ylabel('U/U_н')
    % zlabel('K_p')
    % hold on
    % fimplicit3(@(x1,x2,K_p) K_p-1,[t(1) t(end) U_ratio(1) U_ratio(end) min(min(Z)) max(max(Z))],'FaceAlpha',0.1,'EdgeColor','C')
    % legend('K_p(T,U/U_н)','K_p = 1')
%% K_C
figure;

C = [0:10:2000 2000:1000:2e6]*1e-6; % Резисторы
point = struct(); % Инициализация структуры

% Получаем коэффициенты для каждого C
for i = 1:length(C)
    [K_c, K_p] = getCoefCapacitor(DataSystem.Capacitor, VarSystem.IteratorCapacitor, C(i), VarSystem.U_ratio, VarSystem.t, Capacitor_struct);

            point.C(i)=C(i);
            point.K_p(i)=K_p;
            point.K_c(i)=K_c;
end

% Вытаскиваем K_C для всех точек
K_c_values = [point.K_c];

% Строим график
semilogx(C, K_c_values, 'LineWidth', 2, 'Color', 'k'); % Синяя линия
grid on; % Включаем сетку

% Добавляем заголовок и подписи
title('Зависимость K_C от C', 'FontSize', 14);
xlabel('Емкость C (Ф)', 'FontSize', 12);
ylabel('Коэффициент K_C', 'FontSize', 12);

% Добавляем легенду
legend('K_C', 'Location', 'Best');

% Настройка осей
xlim([min(C) max(C)]);
ylim([min(K_c_values) max(K_c_values)]);

% Дополнительные настройки
set(gca, 'FontSize', 12); % Установка размера шрифта
%% K_M
% figure;
% 
% power= 0.1:0.01:3; % Резисторы
% point = struct(); % Инициализация структуры
% 
% % Получаем коэффициенты для каждого C
% for i = 1:length(power)
%     [K_p, K_C, K_m, K_stab] = getCoefResistor(power(i), VarSystem.resistance_b, VarSystem.P_ratio_b, VarSystem.t, Capacitor_struct);
% 
%     point(i).power = power(i);
%     point(i).K_p = K_p;
%     point(i).K_C = K_C;
%     point(i).K_m = K_m;
%     point(i).K_stab = K_stab;
% end
% 
% % Вытаскиваем K_C для всех точек
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
%% lambda2
figure;

point = struct(); % Инициализация структуры
t=25:1:85;
U_ratio=0.1:0.1:1;
% leg_cell = [];
Capacitor_struct = getTableCapacitor(DataSystem.Capacitor, VarSystem.IteratorCapacitor);
for k = 1:length(U_ratio)
% Получаем коэффициенты для каждого R
    for i = 1:length(t)
        lambda = getReliabilityCapacitorFromData(DataSystem.Capacitor, VarSystem.IteratorCapacitor, VarSystem.capacity, U_ratio(k), t(i));
        
        point(k).t(i)= t(i);
        point(k).lambda(i) = lambda;
        leg_cell(k) = {"U/U_н = " + num2str(U_ratio(k))};
    end
end

% Вытаскиваем K_R для всех точек
% lambda = [point.lambda];

% Строим график
    % figure
    for k = 1:length(U_ratio)
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
    [X,Y] = meshgrid(t,U_ratio);
    for k = 1:length(U_ratio)t=25:1:85;
        Z(k,:) = point(k).lambda; 
    end
    surf(X,Y,Z,'EdgeColor','none')
    colorbar
    colormap('cool')
    xlabel('T, ℃')
    ylabel('U/U_н')
    zlabel('lambda')
    % hold on
    % fimplicit3(@(x1,x2,lambda) lambda-1,[t(1) t(end) U_ratio(1) U_ratio(end) min(min(Z)) max(max(Z))],'FaceAlpha',0.1,'EdgeColor','r')
    % legend('lambda(T,U/U_н)','lambda = 1')
    legend('lambda(T,U/U_н)')
    %% lambda3
figure(2);

point = struct(); % Инициализация структуры
t=25:1:85;
U_ratio=0.1:0.1:1;
% leg_cell = [];

for k = 1:length(U_ratio)
% Получаем коэффициенты для каждого R
    for i = 1:length(t)
        lambda = getReliabilityCapacitor(Capacitor_struct, 1, 1);
        
        point(k).t(i)= t(i);
        point(k).lambda(i) = lambda;
        leg_cell(k) = {"U/U_н = " + num2str(U_ratio(k))};
    end
end

% Вытаскиваем K_R для всех точек
% lambda = [point.lambda];

% Строим график
    % figure
    % for k = 1:length(U_ratio)
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
    [X,Y] = meshgrid(t,U_ratio);
    for k = 1:length(U_ratio)
        Z(k,:) = point(k).lambda; 
    end
    surf(X,Y,Z,'EdgeColor','none')
    colorbar
    colormap('cool')
    xlabel('T, ℃')
    ylabel('U/U_н')
    zlabel('lambda')
    % hold on
    % fimplicit3(@(x1,x2,lambda) lambda-1,[t(1) t(end) U_ratio(1) U_ratio(end) min(min(Z)) max(max(Z))],'FaceAlpha',0.1,'EdgeColor','r')
    % legend('lambda(T,U/U_н)','lambda = 1')
    legend('lambda(T,U/U_н)')