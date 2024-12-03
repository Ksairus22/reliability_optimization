clc; clear; close all;diary off;
diary LogFile_ConsoleOutput.txt
disp("Start    " + datestr(datetime()))
tStart=tic;
plot_def = boolean([0 0 0]);
%% Include
addpath("functions\")
%% Inputs
filename = 'database_src.xlsx';
rownum = 95;
U_ratio= 0.6;
t = 25;
capacity = 100;% pF
%% Work: open file -> get coef -> get lambda
% open file ->
data = getTableData(filename);
% 
lambda = [];
for i = 1:height(data)
    capacitor_struct = getTableCapacitor(data, i);
    % get coef ->
    [K_c, K_r] = getCoefCapacitor(data, i, capacity, U_ratio, t, capacitor_struct);
    % 
    % get lambda ->
    lambda = getReliabilityCapacitor(capacitor_struct, K_c, K_r);
    % 
    if plot_def(1)
        figure(1)
        stem(i,K_c)
        hold on
    end
    if plot_def(2)
        figure(2)
        stem(i,K_r)
        hold on
    end
    if plot_def(3)
        figure(3)
        stem(i,lambda)
        hold on
    end
end
% 
if plot_def(1)
figure(1)
xlabel('Индекс')
ylabel('K_c')
end
if plot_def(2)
figure(2)
xlabel('Индекс')
ylabel('K_r')
end
if plot_def(3)
figure(3)
xlabel('Индекс')
ylabel('\lambda, 1/ч')
end
%% plot 2D
t = 25:125;
lambda = zeros(1,length(t));
for i = 1:length(t)
    output_struct = getTableCapacitor(data, rownum);
    [K_c, K_r] = getCoefCapacitor(data, rownum, capacity, U_ratio, t(i), capacitor_struct);
    lambda(i) = getReliabilityCapacitor(capacitor_struct, K_c, K_r);
end
plot(t,lambda,'k','LineWidth',2)
xlabel('1/ч')
ylabel('\lambda')
grid
% 
%% plot 2.5D
t = 25:125;
lambda = zeros(1,length(t));
U_ratio = 0.1:0.1:1;
figure(2)
for k = 1:length(U_ratio)
    for i = 1:length(t)
        output_struct = getTableCapacitor(data, rownum);
        [K_c, K_r] = getCoefCapacitor(data, rownum, capacity, U_ratio(k), t(i), capacitor_struct);
        lambda(i) = getReliabilityCapacitor(capacitor_struct, K_c, K_r);
    end
    legendEntries{k} = ['U\_ratio = ' num2str(U_ratio(k))]; 
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
% output_struct = getTableCapacitor(data, rownum);
% [K_c, K_r] = getCoefCapacitor(data, rownum, capacity, U_ratio, t, capacitor_struct);
% [lambda] = getReliabilityCapacitor(capacitor_struct, K_c, K_r);
%%
disp("Finish    " + datestr(datetime()));
tElapsed=toc(tStart);
disp("Elapsed time: "+num2str(tElapsed)+" sec")
diary off