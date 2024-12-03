clc; clear; close all;diary off;
diary LogFile_ConsoleOutput.txt
disp("Start    " + datestr(datetime()))
tStart=tic;
plot_def = boolean([0 0 0 0 0]);
%% Include
addpath("functions\")
%% Inputs
filename = 'database_src.xlsx';
rownum = 1;
P_ratio= 0.1;
t = 25;
resistance = 1e5;% 
power = 0.5;
%% Work: open file -> get coef -> get lambda
% open file ->
data = getTableData(filename);
% 
lambda = [];
for i = 1:height(data)
    Resistor_struct = getTableResistor(data, i);
    % get coef ->
    [K_p, K_R, K_m, K_stab] = getCoefResistor(power, resistance, P_ratio, t, Resistor_struct);
    % 
    % get lambda ->
    lambda = getReliabilityResistor(Resistor_struct, K_p, K_R, K_m, K_stab);
    % 
    if plot_def(1)
        figure(1)
        stem(i,K_p)
        hold on
    end
    if plot_def(2)
        figure(2)
        stem(i,K_R)
        hold on
    end
    if plot_def(3)
        figure(3)
        stem(i,K_m)
        hold on
    end
    if plot_def(4)
        figure(4)
        stem(i,K_stab)
        hold on
    end
    if plot_def(5)
        figure(5)
        stem(i,lambda)
        hold on
    end
end
% 
if plot_def(1)
figure(1)
xlabel('Индекс')
ylabel('K_p')
end
if plot_def(2)
figure(2)
xlabel('Индекс')
ylabel('K_R')
end
if plot_def(3)
figure(3)
xlabel('Индекс')
ylabel('K_m')
end
if plot_def(4)
figure(4)
xlabel('Индекс')
ylabel('K_stab, 1/ч')
end
if plot_def(5)
figure(5)
xlabel('Индекс')
ylabel('\lambda, 1/ч')
end
%% plot 2D
t = 25:85;
lambda = zeros(1,length(t));
for i = 1:length(t)
        Resistor_struct = getTableResistor(data, rownum);
        [K_p, K_R, K_m, K_stab] = getCoefResistor(power, resistance, P_ratio, t(i), Resistor_struct);
        lambda(i) = getReliabilityResistor(Resistor_struct, K_p, K_R, K_m, K_stab);
end
plot(t,lambda,'k','LineWidth',2)
xlabel('1/ч')
ylabel('\lambda')
grid
% 
%% plot 2.5D
t = 25:125;
lambda = zeros(1,length(t));
P_ratio = 0.1:0.1:1;
figure(2)
for k = 1:length(P_ratio)
    for i = 1:length(t)
        Resistor_struct = getTableResistor(data, rownum);
            [K_p, K_R, K_m, K_stab] = getCoefResistor(power, resistance, P_ratio(k), t(i), Resistor_struct);
            lambda(i) = getReliabilityResistor(Resistor_struct, K_p, K_R, K_m, K_stab);
    end
    legendEntries{k} = ['P\_ratio = ' num2str(P_ratio(k))]; 
    plot(t,lambda,'LineWidth',2)
    hold on
end
legend(legendEntries)
xlabel('1/ч')
ylabel('\lambda')
grid
% 
%% Functions
% data_parsed = getTableData(filename);
% output_struct = getTableResistor(data, rownum);
% [K_c, K_r] = getCoefResistor(data, rownum, capacity, U_ratio, t, Resistor_struct);
% [lambda] = getReliabilityResistor(Resistor_struct, K_c, K_r);
%%
disp("Finish    " + datestr(datetime()));
tElapsed=toc(tStart);
disp("Elapsed time: "+num2str(tElapsed)+" sec")
diary off